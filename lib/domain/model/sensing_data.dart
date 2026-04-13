class SensingData {
  final int id;
  final String deviceId;
  final int timestamp;
  final int heartRate;
  final int statusIndex;
  final int statusLevel;
  final int temperature;
  final int humidity;
  final int heatIndex;
  final int heatIndexMax;
  final int fallState;
  final int batteryLevel;
  final int latitude;
  final int longitude;
  final int altitudeDiff;
  final int ppi0;
  final int ppi1;
  final int ppi2;
  final bool synced;
  final int createdAt;
  final String locationSource;

  const SensingData({
    this.id = 0,
    required this.deviceId,
    required this.timestamp,
    this.heartRate = 0,
    this.statusIndex = 0,
    this.statusLevel = 0,
    this.temperature = 0,
    this.humidity = 0,
    this.heatIndex = 0,
    this.heatIndexMax = 0,
    this.fallState = -1,
    this.batteryLevel = 0,
    this.latitude = 0,
    this.longitude = 0,
    this.altitudeDiff = 0,
    this.ppi0 = 0,
    this.ppi1 = 0,
    this.ppi2 = 0,
    this.synced = false,
    this.createdAt = 0,
    this.locationSource = 'MS200',
  });

  double get temperatureCelsius =>
      (temperature / 100.0 * 100).roundToDouble() / 100;

  double get humidityPercent =>
      (humidity / 100.0 * 100).roundToDouble() / 100;

  double get altitudeDiffMetres => altitudeDiff / 10.0;

  double get latitudeDegrees => latitude / 1e7;

  double get longitudeDegrees => longitude / 1e7;

  bool get hasGps => latitude != 0 || longitude != 0;

  bool get isFallDetected => fallState >= 2;

  SensingData copyWith({
    int? id,
    String? deviceId,
    int? timestamp,
    int? heartRate,
    int? statusIndex,
    int? statusLevel,
    int? temperature,
    int? humidity,
    int? heatIndex,
    int? heatIndexMax,
    int? fallState,
    int? batteryLevel,
    int? latitude,
    int? longitude,
    int? altitudeDiff,
    int? ppi0,
    int? ppi1,
    int? ppi2,
    bool? synced,
    int? createdAt,
    String? locationSource,
  }) {
    return SensingData(
      id: id ?? this.id,
      deviceId: deviceId ?? this.deviceId,
      timestamp: timestamp ?? this.timestamp,
      heartRate: heartRate ?? this.heartRate,
      statusIndex: statusIndex ?? this.statusIndex,
      statusLevel: statusLevel ?? this.statusLevel,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      heatIndex: heatIndex ?? this.heatIndex,
      heatIndexMax: heatIndexMax ?? this.heatIndexMax,
      fallState: fallState ?? this.fallState,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      altitudeDiff: altitudeDiff ?? this.altitudeDiff,
      ppi0: ppi0 ?? this.ppi0,
      ppi1: ppi1 ?? this.ppi1,
      ppi2: ppi2 ?? this.ppi2,
      synced: synced ?? this.synced,
      createdAt: createdAt ?? this.createdAt,
      locationSource: locationSource ?? this.locationSource,
    );
  }
}
