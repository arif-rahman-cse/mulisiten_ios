import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class DeviceLocationProvider {
  final _log = Logger(printer: SimplePrinter(printTime: false));
  Position? _lastPosition;

  Position? get lastPosition => _lastPosition;

  Future<void> initialize() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
  }

  Future<Position?> getCurrentPosition({bool background = false}) async {
    try {
      final accuracy = background
          ? LocationAccuracy.medium
          : LocationAccuracy.high;
      _lastPosition = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: accuracy),
      );
      return _lastPosition;
    } catch (e) {
      _log.w('Failed to get location: $e');
      return _lastPosition;
    }
  }

  /// Convert a phone Position to lat/lon in the MS200's 10^-7 degree format.
  int latToE7(Position pos) => (pos.latitude * 1e7).round();
  int lonToE7(Position pos) => (pos.longitude * 1e7).round();
}
