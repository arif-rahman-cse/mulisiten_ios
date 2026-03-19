import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ms200_companion/app.dart';
import 'package:ms200_companion/data/location/device_location_provider.dart';
import 'package:ms200_companion/providers/providers.dart';
import 'package:ms200_companion/service/background_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  // Enable FBP verbose logging in debug mode so we can see all BLE events
  if (kDebugMode) {
    FlutterBluePlus.setLogLevel(LogLevel.verbose, color: false);
    // Disable debugPrint in release mode to avoid spamming the console.
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  // Subscribe to adapter state early to trigger CBCentralManager creation on iOS.
  // Log every state change so we can diagnose issues.
  FlutterBluePlus.adapterState.listen((state) {
    debugPrint('[BLE] Adapter state changed: $state');
  });

  final prefs = await SharedPreferences.getInstance();

  await initializeBackgroundService();

  // Request location permission early so the app appears in iOS Location Services.
  await DeviceLocationProvider().initialize();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: const Ms200App(),
    ),
  );
}
