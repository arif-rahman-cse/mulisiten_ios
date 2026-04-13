import 'package:shared_preferences/shared_preferences.dart';
import 'package:ms200_companion/domain/model/device_config.dart';

class AppPreferences {
  final SharedPreferences _prefs;

  AppPreferences(this._prefs);

  // --- Keys ---
  static const _keyLocalDbEnabled = 'local_db_enabled';
  static const _keyCloudBufferEnabled = 'cloud_buffer_enabled';
  static const _keyRealtimeUploadEnabled = 'realtime_upload_enabled';
  static const _keyRealtimeUploadInterval = 'realtime_upload_interval_sec';
  static const _keyCloudApiUrl = 'cloud_api_url';
  static const _keyPairedDeviceAddress = 'paired_device_address';
  static const _keyPairedDeviceName = 'paired_device_name';
  static const _keySensingActive = 'sensing_active';
  static const _keyUserName = 'user_name';
  static const _keyCloudUploadConsented = 'cloud_upload_consented';

  // User param keys
  static const _keyUserAge = 'user_age';
  static const _keyUserHeight = 'user_height';
  static const _keyUserWeight = 'user_weight';
  static const _keyUserExerciseHabit = 'user_exercise_habit';
  static const _keyUserMedicalHistory = 'user_medical_history';
  

  // System param keys
  static const _keySysExt96ms = 'sys_ext_96ms';
  static const _keySysStatusIndexMode = 'sys_status_index_mode';
  static const _keySysAdvertiseSetting = 'sys_advertise_setting';
  static const _keySysStorageMode = 'sys_storage_mode';
  static const _keySysDetailedDataInterval = 'sys_detailed_data_interval';
  static const _keySysNotificationThreshold = 'sys_notification_threshold';
  static const _keySysBeltWarning = 'sys_belt_warning';

  // --- Local DB ---
  bool get localDbEnabled => _prefs.getBool(_keyLocalDbEnabled) ?? true;
  set localDbEnabled(bool v) => _prefs.setBool(_keyLocalDbEnabled, v);

  // --- Cloud Buffer ---
  bool get cloudBufferEnabled =>
      _prefs.getBool(_keyCloudBufferEnabled) ?? true;
  set cloudBufferEnabled(bool v) => _prefs.setBool(_keyCloudBufferEnabled, v);

  // --- Cloud Upload Consent ---
  bool get cloudUploadConsented =>
      _prefs.getBool(_keyCloudUploadConsented) ?? false;
  set cloudUploadConsented(bool v) =>
      _prefs.setBool(_keyCloudUploadConsented, v);

  // --- Realtime Upload ---
  bool get realtimeUploadEnabled =>
      _prefs.getBool(_keyRealtimeUploadEnabled) ?? false;
  set realtimeUploadEnabled(bool v) =>
      _prefs.setBool(_keyRealtimeUploadEnabled, v);

  int get realtimeUploadIntervalSec =>
      _prefs.getInt(_keyRealtimeUploadInterval) ?? 30;
  set realtimeUploadIntervalSec(int v) =>
      _prefs.setInt(_keyRealtimeUploadInterval, v);

  // --- Cloud API ---
  String get cloudApiUrl =>
      _prefs.getString(_keyCloudApiUrl) ?? 'https://cms.k-fis.com/';
  set cloudApiUrl(String v) => _prefs.setString(_keyCloudApiUrl, v);

  // --- Paired Device ---
  String get pairedDeviceAddress =>
      _prefs.getString(_keyPairedDeviceAddress) ?? '';
  set pairedDeviceAddress(String v) =>
      _prefs.setString(_keyPairedDeviceAddress, v);

  String get pairedDeviceName =>
      _prefs.getString(_keyPairedDeviceName) ?? '';
  set pairedDeviceName(String v) =>
      _prefs.setString(_keyPairedDeviceName, v);

  bool get hasPairedDevice => pairedDeviceAddress.isNotEmpty;

  void clearPairedDevice() {
    _prefs.remove(_keyPairedDeviceAddress);
    _prefs.remove(_keyPairedDeviceName);
  }

  // --- Sensing State ---
  bool get sensingActive => _prefs.getBool(_keySensingActive) ?? false;
  set sensingActive(bool v) => _prefs.setBool(_keySensingActive, v);

  // --- User Name ---
  String get userName => _prefs.getString(_keyUserName) ?? '';
  set userName(String v) => _prefs.setString(_keyUserName, v);

  // --- Cached User Params ---
  int get userAge => _prefs.getInt(_keyUserAge) ?? 0;
  set userAge(int v) => _prefs.setInt(_keyUserAge, v);

  int get userHeight => _prefs.getInt(_keyUserHeight) ?? 0;
  set userHeight(int v) => _prefs.setInt(_keyUserHeight, v);

  int get userWeight => _prefs.getInt(_keyUserWeight) ?? 0;
  set userWeight(int v) => _prefs.setInt(_keyUserWeight, v);

  int get userExerciseHabit => _prefs.getInt(_keyUserExerciseHabit) ?? 0;
  set userExerciseHabit(int v) => _prefs.setInt(_keyUserExerciseHabit, v);

  int get userMedicalHistory => _prefs.getInt(_keyUserMedicalHistory) ?? 0;
  set userMedicalHistory(int v) => _prefs.setInt(_keyUserMedicalHistory, v);

  void saveUserParams(DeviceConfig config) {
    userAge = config.age;
    userHeight = config.height;
    userWeight = config.weight;
    userExerciseHabit = config.exerciseHabit;
    userMedicalHistory = config.medicalHistory;
  }

  // --- Cached System Params ---
  int get sysExt96ms => _prefs.getInt(_keySysExt96ms) ?? 0;
  set sysExt96ms(int v) => _prefs.setInt(_keySysExt96ms, v);

  int get sysStatusIndexMode => _prefs.getInt(_keySysStatusIndexMode) ?? 0;
  set sysStatusIndexMode(int v) => _prefs.setInt(_keySysStatusIndexMode, v);

  int get sysAdvertiseSetting => _prefs.getInt(_keySysAdvertiseSetting) ?? 0;
  set sysAdvertiseSetting(int v) => _prefs.setInt(_keySysAdvertiseSetting, v);

  int get sysStorageMode => _prefs.getInt(_keySysStorageMode) ?? 0;
  set sysStorageMode(int v) => _prefs.setInt(_keySysStorageMode, v);

  int get sysDetailedDataInterval =>
      _prefs.getInt(_keySysDetailedDataInterval) ?? 0;
  set sysDetailedDataInterval(int v) =>
      _prefs.setInt(_keySysDetailedDataInterval, v);

  int get sysNotificationThreshold =>
      _prefs.getInt(_keySysNotificationThreshold) ?? 0;
  set sysNotificationThreshold(int v) =>
      _prefs.setInt(_keySysNotificationThreshold, v);

  int get sysBeltWarning => _prefs.getInt(_keySysBeltWarning) ?? 3;
  set sysBeltWarning(int v) => _prefs.setInt(_keySysBeltWarning, v);

  void saveSystemParams(DeviceConfig config) {
    sysExt96ms = config.extendedData96ms;
    sysStatusIndexMode = config.statusIndexMode;
    sysAdvertiseSetting = config.advertiseSetting;
    sysStorageMode = config.storageMode;
    sysDetailedDataInterval = config.detailedDataInterval;
    sysNotificationThreshold = config.sysNotificationThreshold;
    sysBeltWarning = config.beltWarning;
  }
}
