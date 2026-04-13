import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ms200_companion/data/local/app_database.dart';
import 'package:ms200_companion/data/preferences/app_preferences.dart';
import 'package:ms200_companion/data/remote/api_service.dart';
import 'package:ms200_companion/data/remote/cloud_uploader.dart';
import 'package:ms200_companion/domain/model/sensing_data.dart';
import 'package:ms200_companion/env/env.dart';

final _log = Logger(printer: SimplePrinter(printTime: false));

Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onServiceStart,
      autoStart: false,
      isForegroundMode: true,
      foregroundServiceTypes: [
        AndroidForegroundType.connectedDevice,
        AndroidForegroundType.location,
      ],
      initialNotificationTitle: 'MS200 Companion',
      initialNotificationContent: 'Initializing...',
    ),
    iosConfiguration: IosConfiguration(
      autoStart: false,
      onForeground: onServiceStart,
      onBackground: onIosBackground,
    ),
  );
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  // await performBatchSync('ios_background');
  return true;
}

@pragma('vm:entry-point')
void onServiceStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final appPrefs = AppPreferences(prefs);

  Timer? reconnectTimer;
  // Timer? syncTimer;

  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();
    _updateNotification(service, 'Running');
  }

  service.on('stop').listen((_) {
    reconnectTimer?.cancel();
    // syncTimer?.cancel();
    service.stopSelf();
  });

  service.on('update_notification').listen((data) {
    if (service is AndroidServiceInstance && data != null) {
      final title = data['title'] as String? ?? 'MS200 Companion';
      final body = data['body'] as String? ?? '';
      service.setForegroundNotificationInfo(title: title, content: body);
    }
  });

  service.on('start_reconnect').listen((data) {
    final address = data?['address'] as String? ?? appPrefs.pairedDeviceAddress;
    if (address.isEmpty) return;

    _updateNotification(service, 'Disconnected — Reconnecting...');

    final device = BluetoothDevice.fromId(address);
    device.connect(license: License.free, autoConnect: true, mtu: null);

    reconnectTimer?.cancel();
    reconnectTimer = Timer.periodic(const Duration(seconds: 60), (_) async {
      try {
        if (!device.isConnected) {
          await device.connect(
            license: License.free,
            autoConnect: false,
            timeout: const Duration(seconds: 10),
          );
        }
      } catch (_) {}
    });
  });

  service.on('stop_reconnect').listen((_) {
    reconnectTimer?.cancel();
    reconnectTimer = null;
    _updateNotification(service, 'Connected — Sensing Active');
  });

  // Sync buffered records from previous sessions immediately
  // await performBatchSync('background_service immediate');

  // Periodic batch sync every 15 minutes
  // syncTimer = Timer.periodic(const Duration(minutes: 1), (_) async {
  //   await performBatchSync('background_service periodic');
  // });
}

/// Standalone batch sync that creates its own DB and API instances.
/// Safe to call from any isolate (main app, background service, iOS background).
Future<void> performBatchSync(String src) async {
  //print('performBatchSync src: $src');
  AppDatabase? db;
  try {
    final prefs = await SharedPreferences.getInstance();
    final appPrefs = AppPreferences(prefs);

    final apiUrl = appPrefs.cloudApiUrl;
    if (apiUrl.isEmpty) return;

    db = AppDatabase();
    final api = ApiService(baseUrl: apiUrl, apiKey: Env.cloudApiKey);
    final uploader = CloudUploader(api);

    final records = await db.getUnsyncedRecords(100);
    print('performBatchSync records: ${records.length}');
    if (records.isEmpty) return;

    final domainRecords = records
        .map(
          (r) => SensingData(
            id: r.id,
            deviceId: r.deviceId,
            timestamp: r.timestamp,
            heartRate: r.heartRate,
            statusIndex: r.statusIndex,
            statusLevel: r.statusLevel,
            temperature: r.temperature,
            humidity: r.humidity,
            heatIndex: r.heatIndex,
            heatIndexMax: r.heatIndexMax,
            fallState: r.fallState,
            batteryLevel: r.batteryLevel,
            latitude: r.latitude,
            longitude: r.longitude,
            altitudeDiff: r.altitudeDiff,
            ppi0: r.ppi0,
            ppi1: r.ppi1,
            ppi2: r.ppi2,
            synced: r.synced,
            createdAt: r.createdAt,
            locationSource: r.locationSource,
          ),
        )
        .toList();

    final success = await uploader.uploadBatch(
      domainRecords,
      appPrefs.userName,
    );
    if (success) {
      await db.markAsSynced(records.map((r) => r.id).toList());
    }
  } catch (e) {
    _log.w('Batch sync failed: $e');
  } finally {
    await db?.close();
  }
}

void _updateNotification(ServiceInstance service, String content) {
  if (service is AndroidServiceInstance) {
    service.setForegroundNotificationInfo(
      title: 'MS200 Companion',
      content: content,
    );
  }
}
