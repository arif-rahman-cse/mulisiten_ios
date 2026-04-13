import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ms200_companion/app.dart';
import 'package:ms200_companion/providers/providers.dart';
import 'package:ms200_companion/service/background_launch_handler.dart';
import 'package:ms200_companion/service/background_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await [
      Permission.notification,
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
    ].request();

    // flutter_background_service only creates this channel inside the service
    // process; some devices throw Bad notification for startForeground unless
    // the channel exists in the main process first (see flutter_background_service#285).
    const fgChannel = AndroidNotificationChannel(
      'FOREGROUND_DEFAULT',
      'MS200 background service',
      description: 'Keeps device connection and sensing active in the background.',
      importance: Importance.defaultImportance,
    );
    final localNotifications = FlutterLocalNotificationsPlugin();
    await localNotifications.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      ),
    );
    await localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(fgChannel);
  }

  // Disable FlutterBluePlus logging in debug mode
  if (kDebugMode) {
    FlutterBluePlus.setLogLevel(LogLevel.verbose, color: false);
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  FlutterBluePlus.adapterState.listen(
    (state) => debugPrint('[BLE] Adapter state changed: $state'),
    onError: (Object e, StackTrace st) =>
        debugPrint('[BLE] adapterState error: $e'),
  );

  final prefs = await SharedPreferences.getInstance();

  await initializeBackgroundService();
  final service = FlutterBackgroundService();
  await service.startService();

  // Listen for native iOS background launch events (significant location
  // change, Core Bluetooth restoration) and trigger reconnection + sync.
  BackgroundLaunchHandler.initialize();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const Ms200App(),
    ),
  );
}
