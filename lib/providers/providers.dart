import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ms200_companion/env/env.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ms200_companion/data/ble/beacon_scanner.dart';
import 'package:ms200_companion/data/ble/ble_manager.dart';
import 'package:ms200_companion/data/local/app_database.dart';
import 'package:ms200_companion/data/location/device_location_provider.dart';
import 'package:ms200_companion/data/preferences/app_preferences.dart';
import 'package:ms200_companion/data/repository/apple_health_repository.dart';
import 'package:ms200_companion/data/remote/api_service.dart';
import 'package:ms200_companion/data/remote/cloud_uploader.dart';
import 'package:ms200_companion/data/repository/device_repository.dart';
import 'package:ms200_companion/data/repository/fall_event_repository.dart';
import 'package:ms200_companion/data/repository/sensing_repository.dart';
import 'package:ms200_companion/domain/model/connection_state.dart';
import 'package:ms200_companion/domain/model/daily_activity_summary.dart';
import 'package:ms200_companion/domain/model/fall_event.dart';
import 'package:ms200_companion/domain/model/history_models.dart';
import 'package:ms200_companion/domain/model/sensing_data.dart';
import 'package:ms200_companion/service/alarm_service.dart';
import 'package:ms200_companion/service/fall_detection_service.dart';

// --- Core singletons ---

final bleManagerProvider = Provider<BleManager>((ref) {
  final manager = BleManager();
  ref.onDispose(() => manager.dispose());
  return manager;
});

final beaconScannerProvider = Provider<BeaconScanner>((ref) {
  final scanner = BeaconScanner();
  ref.onDispose(() => scanner.dispose());
  return scanner;
});

final beaconFallEventProvider = StreamProvider<BeaconFallEvent>((ref) {
  return ref.watch(beaconScannerProvider).fallEvents;
});

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Must be overridden in ProviderScope');
});

final appPreferencesProvider = Provider<AppPreferences>((ref) {
  return AppPreferences(ref.watch(sharedPreferencesProvider));
});

/// Bumped when display name changes so dependent UI (e.g. Home AppBar) refreshes.
final profileIdentityRevisionProvider =
    NotifierProvider<ProfileIdentityRevision, int>(ProfileIdentityRevision.new);

class ProfileIdentityRevision extends Notifier<int> {
  @override
  int build() => 0;

  void bump() => state++;
}

/// Bumped when [AppPreferences.sensingActive] is written from [SensingRepository]
/// so widgets that only watch [appPreferencesProvider] still rebuild (the
/// provider's value identity does not change when SharedPreferences mutates).
final sensingActiveRevisionProvider =
    NotifierProvider<SensingActiveRevision, int>(SensingActiveRevision.new);

class SensingActiveRevision extends Notifier<int> {
  @override
  int build() => 0;

  void bump() => state++;
}

final locationProvider = Provider<DeviceLocationProvider>((ref) {
  final provider = DeviceLocationProvider();
  ref.onDispose(() => provider.dispose());
  return provider;
});

// --- Remote ---

final apiServiceProvider = Provider<ApiService>((ref) {
  final prefs = ref.watch(appPreferencesProvider);
  return ApiService(baseUrl: prefs.cloudApiUrl, apiKey: Env.cloudApiKey);
});

final cloudUploaderProvider = Provider<CloudUploader>((ref) {
  return CloudUploader(ref.watch(apiServiceProvider));
});

// --- Repositories ---

final sensingRepositoryProvider = Provider<SensingRepository>((ref) {
  final repo = SensingRepository(
    ref.watch(bleManagerProvider),
    ref.watch(appDatabaseProvider),
    ref.watch(cloudUploaderProvider),
    ref.watch(appPreferencesProvider),
    ref.watch(locationProvider),
    onSensingActivePersisted: () =>
        ref.read(sensingActiveRevisionProvider.notifier).bump(),
  );
  // Periodic sync is disabled for now
  //repo.startPeriodicSync();
  ref.onDispose(() => repo.dispose());
  return repo;
});

final fallEventRepositoryProvider = Provider<FallEventRepository>((ref) {
  return FallEventRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(cloudUploaderProvider),
    ref.watch(appPreferencesProvider),
  );
});

final deviceRepositoryProvider = Provider<DeviceRepository>((ref) {
  return DeviceRepository(ref.watch(bleManagerProvider));
});

final appleHealthRepositoryProvider = Provider<AppleHealthRepository>((ref) {
  return AppleHealthRepository();
});

// --- Fall Detection ---

final alarmServiceProvider = Provider<AlarmService>((ref) {
  final service = AlarmService();
  ref.onDispose(() => service.dispose());
  return service;
});

final fallDetectionServiceProvider = Provider<FallDetectionService>((ref) {
  final service = FallDetectionService(
    ref.watch(fallEventRepositoryProvider),
    ref.watch(alarmServiceProvider),
  );
  ref.onDispose(() => service.dispose());
  return service;
});

final fallEventStreamProvider = StreamProvider<FallEvent>((ref) {
  return ref.watch(fallDetectionServiceProvider).fallEvents;
});

// --- Streams ---

final connectionStateProvider = StreamProvider<BleConnectionState>((ref) {
  return ref.watch(bleManagerProvider).connectionState;
});

final sensingDataStreamProvider = StreamProvider<SensingData>((ref) {
  return ref.watch(sensingRepositoryProvider).sensingData;
});

final historySelectedRangeProvider =
    NotifierProvider<HistorySelectedRangeNotifier, HistoryRange>(
      HistorySelectedRangeNotifier.new,
    );

class HistorySelectedRangeNotifier extends Notifier<HistoryRange> {
  @override
  HistoryRange build() => HistoryRange.day;

  void select(HistoryRange range) {
    state = range;
  }
}

final historyDashboardProvider = FutureProvider.autoDispose
    .family<HistoryDashboardData, HistoryRange>((ref, range) async {
      final db = ref.watch(appDatabaseProvider);
      final window = range.window();
      final aggregates = await db.getHistoryAggregates(window);
      final fallAggregates = await db.getFallHistoryAggregates(window);
      final recentFalls = await db.getRecentFallEvents(window);

      return HistoryDashboardData(
        window: window,
        heartRate: _buildMetricData(
          range,
          aggregates,
          avgSelector: (row) => row.heartRateAvg,
          minSelector: (row) => row.heartRateMin,
          maxSelector: (row) => row.heartRateMax,
        ),
        temperature: _buildMetricData(
          range,
          aggregates,
          avgSelector: (row) => row.temperatureAvg / 100.0,
          minSelector: (row) => row.temperatureMin / 100.0,
          maxSelector: (row) => row.temperatureMax / 100.0,
        ),
        humidity: _buildMetricData(
          range,
          aggregates,
          avgSelector: (row) => row.humidityAvg / 100.0,
          minSelector: (row) => row.humidityMin / 100.0,
          maxSelector: (row) => row.humidityMax / 100.0,
        ),
        altitude: _buildMetricData(
          range,
          aggregates,
          avgSelector: (row) => row.altitudeAvg / 10.0,
          minSelector: (row) => row.altitudeMin / 10.0,
          maxSelector: (row) => row.altitudeMax / 10.0,
        ),
        fallCounts: _buildFallPoints(range, fallAggregates),
        totalFallCount: fallAggregates.fold<int>(
          0,
          (total, row) => total + row.eventCount,
        ),
        recentFalls: recentFalls
            .map(
              (entry) => HistoryFallEventItem(
                id: entry.id,
                occurredAt: DateTime.fromMillisecondsSinceEpoch(
                  entry.createdAt,
                ).toLocal(),
                fallState: entry.fallState,
                heartRate: entry.heartRate,
                temperatureCelsius: entry.temperature / 100.0,
                altitudeMetres: entry.altitudeDiff / 10.0,
              ),
            )
            .toList(),
      );
    });

final dailyActivityProvider =
    NotifierProvider<DailyActivityController, DailyActivityState>(
      DailyActivityController.new,
    );

class DailyActivityController extends Notifier<DailyActivityState> {
  bool _started = false;

  AppleHealthRepository get _repository =>
      ref.read(appleHealthRepositoryProvider);

  @override
  DailyActivityState build() {
    if (!_repository.isSupported) {
      return const DailyActivityState.unsupported();
    }

    if (!_started) {
      _started = true;
      Future<void>.microtask(load);
    }

    return const DailyActivityState.loading();
  }

  Future<void> load() async {
    if (!_repository.isSupported) {
      state = const DailyActivityState.unsupported();
      return;
    }

    state = const DailyActivityState.loading();

    try {
      final authorized = await _repository.requestReadAuthorization();
      if (!authorized) {
        state = const DailyActivityState.permissionDenied();
        return;
      }

      final summary = await _repository.fetchTodaySummary();
      state = summary.hasData
          ? DailyActivityState.ready(summary)
          : const DailyActivityState.noData();
    } catch (error) {
      state = DailyActivityState.error(error.toString());
    }
  }
}

// --- Auto-sync device params on connection ---

final deviceParamsSyncProvider = Provider<void>((ref) {
  final connAsync = ref.watch(connectionStateProvider);
  final connState = connAsync.value;

  if (connState == BleConnectionState.connected) {
    final prefs = ref.read(appPreferencesProvider);
    if (!prefs.sensingActive) {
      final repo = ref.read(deviceRepositoryProvider);
      _syncDeviceParams(repo, prefs);
    }
  }
});

Future<void> _syncDeviceParams(
  DeviceRepository repo,
  AppPreferences prefs,
) async {
  final userConfig = await repo.getUserParams();
  if (userConfig != null) {
    prefs.saveUserParams(userConfig);
  }

  final sysConfig = await repo.getSystemParams();
  if (sysConfig != null) {
    prefs.saveSystemParams(sysConfig);
  }
}

// --- App bootstrap: auto-reconnect & auto-resume after relaunch ---

final appBootstrapProvider = Provider<void>((ref) {
  final prefs = ref.read(appPreferencesProvider);

  // Setup lifecycle listener to refresh data on foreground
  final lifecycleListener = AppLifecycleListener(
    onResume: () {
      debugPrint('[Bootstrap] App resumed - refreshing daily activity');
      ref.read(dailyActivityProvider.notifier).load();
    },
  );
  ref.onDispose(lifecycleListener.dispose);

  // Auto-reconnect to the previously-paired device using OS-managed autoConnect.
  // This works for both foreground opens and background relaunches.
  if (prefs.hasPairedDevice) {
    final ble = ref.read(bleManagerProvider);
    final device = BluetoothDevice.fromId(prefs.pairedDeviceAddress);
    ble.reconnect(device, knownName: prefs.pairedDeviceName);
    debugPrint('[Bootstrap] Auto-reconnecting to ${prefs.pairedDeviceName}');
  }

  // When BLE transitions to connected, auto-resume sensing if it was active
  // before the app was terminated.
  ref.listen<AsyncValue<BleConnectionState>>(connectionStateProvider, (
    prev,
    next,
  ) {
    final wasConnected = prev?.value == BleConnectionState.connected;
    final isConnected = next.value == BleConnectionState.connected;

    if (!wasConnected && isConnected) {
      final repo = ref.read(sensingRepositoryProvider);
      // Always forward BLE detailed frames to the repo while connected. If
      // sensing_active was cleared (DB/prefs reset) while the band kept
      // streaming, this restores home UI without requiring a successful
      // start-sensing ACK.
      repo.startListening();

      final currentPrefs = ref.read(appPreferencesProvider);
      if (currentPrefs.sensingActive) {
        //debugPrint('[Bootstrap] Auto-resuming sensing after reconnect');
        // startRealtimeSensing initializes location + background stream.
        repo.startRealtimeSensing();
      }
    }
  });
});

// For showing heart rate historical data, do you count the

HistoryMetricData _buildMetricData(
  HistoryRange range,
  List<HistoryAggregateRow> rows, {
  required double Function(HistoryAggregateRow row) avgSelector,
  required double Function(HistoryAggregateRow row) minSelector,
  required double Function(HistoryAggregateRow row) maxSelector,
}) {
  if (rows.isEmpty) {
    return const HistoryMetricData(points: [], summary: null);
  }

  final points = <HistoryChartPoint>[];
  var weightedTotal = 0.0;
  var totalSamples = 0;
  var overallMin = double.infinity;
  var overallMax = -double.infinity;

  for (var index = 0; index < rows.length; index++) {
    final row = rows[index];
    final timestamp = DateTime.fromMillisecondsSinceEpoch(
      row.bucketStartMs,
    ).toLocal();
    final avg = avgSelector(row);
    final min = minSelector(row);
    final max = maxSelector(row);

    points.add(
      HistoryChartPoint(
        x: index.toDouble(),
        y: avg,
        timestamp: timestamp,
        label: formatHistoryBucketLabel(range, timestamp),
      ),
    );

    weightedTotal += avg * row.sampleCount;
    totalSamples += row.sampleCount;
    if (min < overallMin) overallMin = min;
    if (max > overallMax) overallMax = max;
  }

  return HistoryMetricData(
    points: points,
    summary: HistoryMetricSummary(
      latest: points.last.y,
      min: overallMin,
      max: overallMax,
      average: totalSamples == 0 ? 0 : weightedTotal / totalSamples,
    ),
  );
}

List<HistoryChartPoint> _buildFallPoints(
  HistoryRange range,
  List<HistoryFallAggregateRow> rows,
) {
  return [
    for (var index = 0; index < rows.length; index++)
      HistoryChartPoint(
        x: index.toDouble(),
        y: rows[index].eventCount.toDouble(),
        timestamp: DateTime.fromMillisecondsSinceEpoch(
          rows[index].bucketStartMs,
        ).toLocal(),
        label: formatHistoryBucketLabel(
          range,
          DateTime.fromMillisecondsSinceEpoch(
            rows[index].bucketStartMs,
          ).toLocal(),
        ),
      ),
  ];
}
