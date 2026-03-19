import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ms200_companion/data/preferences/app_preferences.dart';

Future<void> initializeBackgroundService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onServiceStart,
      autoStart: false,
      isForegroundMode: true,
      foregroundServiceTypes: [AndroidForegroundType.connectedDevice, AndroidForegroundType.location],
      notificationChannelId: 'ms200_foreground',
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
  return true;
}

@pragma('vm:entry-point')
void onServiceStart(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final appPrefs = AppPreferences(prefs);

  Timer? reconnectTimer;
  Timer? syncTimer;

  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();
    _updateNotification(service, 'Running');
  }

  service.on('stop').listen((_) {
    reconnectTimer?.cancel();
    syncTimer?.cancel();
    service.stopSelf();
  });

  service.on('update_notification').listen((data) {
    if (service is AndroidServiceInstance && data != null) {
      final title = data['title'] as String? ?? 'MS200 Companion';
      final body = data['body'] as String? ?? '';
      service.setForegroundNotificationInfo(title: title, content: body);
    }
  });

  // Hybrid reconnect: autoConnect + polling fallback
  service.on('start_reconnect').listen((data) {
    final address = data?['address'] as String? ?? appPrefs.pairedDeviceAddress;
    if (address.isEmpty) return;

    _updateNotification(service, 'Disconnected — Reconnecting...');

    final device = BluetoothDevice.fromId(address);
    device.connect(license: License.free, autoConnect: true, mtu: null);

    reconnectTimer?.cancel();
    reconnectTimer = Timer.periodic(const Duration(seconds: 60), (_) async {
      try {
        final connected = device.isConnected;
        if (!connected) {
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

  // Periodic batch sync (every 15 minutes)
  syncTimer = Timer.periodic(const Duration(minutes: 15), (_) {
    service.invoke('sync_batch');
  });
}

void _updateNotification(ServiceInstance service, String content) {
  if (service is AndroidServiceInstance) {
    service.setForegroundNotificationInfo(
      title: 'MS200 Companion',
      content: content,
    );
  }
}
