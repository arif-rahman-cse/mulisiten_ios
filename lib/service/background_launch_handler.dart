import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ms200_companion/data/preferences/app_preferences.dart';
// import 'package:ms200_companion/service/background_service.dart';

/// Handles method channel calls from native iOS when the app is relaunched
/// by Significant Location Changes or Core Bluetooth State Restoration.
class BackgroundLaunchHandler {
  static const _channel = MethodChannel('com.ms200_companion/background');

  static void initialize() {
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onBackgroundLaunch':
          final args = call.arguments as Map?;
          final trigger = args?['trigger'] as String? ?? 'unknown';
          debugPrint('[Background] App relaunched by: $trigger');
          await _handleBackgroundLaunch(trigger);
      }
    });
  }

  static Future<void> _handleBackgroundLaunch(String trigger) async {
    // Attempt BLE reconnection if we have a paired device
    final prefs = await SharedPreferences.getInstance();
    final appPrefs = AppPreferences(prefs);
    final address = appPrefs.pairedDeviceAddress;

    if (address.isNotEmpty) {
      try {
        final device = BluetoothDevice.fromId(address);
        if (!device.isConnected) {
          debugPrint('[Background] Reconnecting to $address');
          await device.connect(
            license: License.free,
            autoConnect: true,
            mtu: null,
          );
        }
      } catch (e) {
        debugPrint('[Background] Reconnect failed: $e');
      }
    }

    // Sync any buffered records to cloud
    // await performBatchSync('background_launch_handler');
  }
}
