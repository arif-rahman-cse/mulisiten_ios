class DeviceConfig {
  String serialNumber;
  int systemState;

  // User parameters (CMD 0x22)
  int age;
  int height;
  int weight;
  int exerciseHabit;
  int medicalHistory;
  int notificationThreshold;

  // System parameters (CMD 0x2E)
  int extendedData96ms;
  int statusIndexMode;
  int advertiseSetting;
  int storageMode;
  int detailedDataInterval;
  int sysNotificationThreshold;
  int beltWarning;

  DeviceConfig({
    this.serialNumber = '',
    this.systemState = 0,
    this.age = 0,
    this.height = 0,
    this.weight = 0,
    this.exerciseHabit = 0,
    this.medicalHistory = 0,
    this.notificationThreshold = 0,
    this.extendedData96ms = 0,
    this.statusIndexMode = 0,
    this.advertiseSetting = 0,
    this.storageMode = 0,
    this.detailedDataInterval = 0,
    this.sysNotificationThreshold = 0,
    this.beltWarning = 0,
  });

  String get systemStateName {
    switch (systemState) {
      case 0:
        return 'IDLE';
      case 1:
        return 'Standalone Sensing';
      case 2:
        return 'Realtime Sensing';
      case 3:
        return 'Uploading';
      case 4:
        return 'Erasing';
      case 5:
        return 'Advertising';
      default:
        return 'Unknown ($systemState)';
    }
  }

  bool get isIdle => systemState == 0;
  double get weightKg => weight / 10.0;
  double get heightCm => height / 10.0;
}
