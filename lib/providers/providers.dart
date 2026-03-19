import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ms200_companion/data/ble/beacon_scanner.dart';
import 'package:ms200_companion/data/ble/ble_manager.dart';
import 'package:ms200_companion/data/local/app_database.dart';
import 'package:ms200_companion/data/location/device_location_provider.dart';
import 'package:ms200_companion/data/preferences/app_preferences.dart';
import 'package:ms200_companion/data/remote/api_service.dart';
import 'package:ms200_companion/data/remote/cloud_uploader.dart';
import 'package:ms200_companion/data/repository/device_repository.dart';
import 'package:ms200_companion/data/repository/fall_event_repository.dart';
import 'package:ms200_companion/data/repository/sensing_repository.dart';
import 'package:ms200_companion/domain/model/connection_state.dart';
import 'package:ms200_companion/domain/model/fall_event.dart';
import 'package:ms200_companion/domain/model/sensing_data.dart';
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

final locationProvider = Provider<DeviceLocationProvider>((ref) {
  return DeviceLocationProvider();
});

// --- Remote ---

final apiServiceProvider = Provider<ApiService>((ref) {
  final prefs = ref.watch(appPreferencesProvider);
  final apiKey = dotenv.maybeGet('CLOUD_API_KEY') ?? prefs.cloudApiKey;
  return ApiService(baseUrl: prefs.cloudApiUrl, apiKey: apiKey);
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
  );
  ref.onDispose(() => repo.dispose());
  return repo;
});

final fallEventRepositoryProvider = Provider<FallEventRepository>((ref) {
  return FallEventRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(cloudUploaderProvider),
  );
});

final deviceRepositoryProvider = Provider<DeviceRepository>((ref) {
  return DeviceRepository(ref.watch(bleManagerProvider));
});

// --- Fall Detection ---

final fallDetectionServiceProvider = Provider<FallDetectionService>((ref) {
  final service = FallDetectionService(ref.watch(fallEventRepositoryProvider));
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
