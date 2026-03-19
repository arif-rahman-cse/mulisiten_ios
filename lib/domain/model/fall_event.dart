class FallEvent {
  final int id;
  final String deviceId;
  final int timestamp;
  final int latitude;
  final int longitude;
  final int elapsedSeconds;
  final int statusLevel;
  final int heatIndex;
  final String source;
  final bool uploaded;
  final int createdAt;
  final int heartRate;
  final int temperature;
  final int humidity;
  final int heatIndexMax;
  final int fallState;
  final int batteryLevel;
  final int altitudeDiff;
  final int statusIndex;
  final int ppi0;
  final int ppi1;
  final int ppi2;
  final String userName;
  final String locationSource;

  static const sourceRealtime = 'REALTIME_SENSING';
  static const sourceIBeacon = 'IBEACON';

  const FallEvent({
    this.id = 0,
    required this.deviceId,
    required this.timestamp,
    this.latitude = 0,
    this.longitude = 0,
    this.elapsedSeconds = 0,
    this.statusLevel = 0,
    this.heatIndex = 0,
    this.source = sourceRealtime,
    this.uploaded = false,
    this.createdAt = 0,
    this.heartRate = 0,
    this.temperature = 0,
    this.humidity = 0,
    this.heatIndexMax = 0,
    this.fallState = 0,
    this.batteryLevel = 0,
    this.altitudeDiff = 0,
    this.statusIndex = 0,
    this.ppi0 = 0,
    this.ppi1 = 0,
    this.ppi2 = 0,
    this.userName = '',
    this.locationSource = 'MS200',
  });

  double get latitudeDegrees => latitude / 1e7;
  double get longitudeDegrees => longitude / 1e7;
  bool get hasGps => latitude != 0 || longitude != 0;
}
