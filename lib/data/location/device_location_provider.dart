import 'dart:async';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class DeviceLocationProvider {
  final _log = Logger(printer: SimplePrinter(printTime: false));
  Position? _lastPosition;
  StreamSubscription<Position>? _positionSub;
  bool _streamActive = false;

  Position? get lastPosition => _lastPosition;
  bool get isStreaming => _streamActive;

  Future<void> initialize() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    // On iOS, request "Always" permission for background location keepalive.
    if (Platform.isIOS && permission == LocationPermission.whileInUse) {
      permission = await Geolocator.requestPermission();
    }
  }

  /// Start a continuous location stream that keeps the app alive on iOS.
  /// Uses low accuracy and a 50m distance filter to minimize battery impact.
  void startBackgroundLocationStream() {
    if (_streamActive) return;
    _streamActive = true;

    late LocationSettings settings;
    if (Platform.isIOS) {
      settings = AppleSettings(
        accuracy: LocationAccuracy.low,
        distanceFilter: 50,
        activityType: ActivityType.other,
        pauseLocationUpdatesAutomatically: false,
        allowBackgroundLocationUpdates: true,
        showBackgroundLocationIndicator: true,
      );
    } else {
      settings = AndroidSettings(
        accuracy: LocationAccuracy.low,
        distanceFilter: 50,
        forceLocationManager: false,
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationTitle: 'MS200 Companion',
          notificationText: 'Tracking location in background',
          enableWakeLock: true,
        ),
      );
    }

    _positionSub = Geolocator.getPositionStream(locationSettings: settings)
        .listen(
      (position) {
        _lastPosition = position;
      },
      onError: (e) {
        _log.w('Location stream error: $e');
      },
    );
  }

  void stopBackgroundLocationStream() {
    _positionSub?.cancel();
    _positionSub = null;
    _streamActive = false;
  }

  Future<Position?> getCurrentPosition({bool background = false}) async {
    if (_lastPosition != null) return _lastPosition;
    try {
      final accuracy =
          background ? LocationAccuracy.medium : LocationAccuracy.high;
      _lastPosition = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: accuracy),
      );
      return _lastPosition;
    } catch (e) {
      _log.w('Failed to get location: $e');
      return _lastPosition;
    }
  }

  int latToE7(Position pos) => (pos.latitude * 1e7).round();
  int lonToE7(Position pos) => (pos.longitude * 1e7).round();

  void dispose() {
    stopBackgroundLocationStream();
  }
}
