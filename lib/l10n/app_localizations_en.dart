// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'MULiSiTEN';

  @override
  String get home => 'Home';

  @override
  String get settings => 'Settings';

  @override
  String get history => 'History';

  @override
  String get day => 'Day';

  @override
  String get week => 'Week';

  @override
  String get month => 'Month';

  @override
  String get year => 'Year';

  @override
  String get scanForDevices => 'Scan for Devices';

  @override
  String get noDevicePaired => 'No device paired';

  @override
  String get scanHint => 'Scan for an MS200 wristband to get started';

  @override
  String get heartRate => 'Heart Rate';

  @override
  String get bpm => 'BPM';

  @override
  String get temperature => 'Temperature';

  @override
  String get humidity => 'Humidity';

  @override
  String get ppiChart => 'PPI (Peak-to-Peak Interval)';

  @override
  String get waitingForData => 'Waiting for data...';

  @override
  String get fallDetected => 'FALL DETECTED';

  @override
  String get fallMessage => 'A fall event has been detected.\nAre you okay?';

  @override
  String get imOk => 'I\'m OK';

  @override
  String get emergency => 'Emergency';

  @override
  String get safe => 'Safe';

  @override
  String get fall => 'FALL';

  @override
  String get noGps => 'No GPS';

  @override
  String get phoneGps => 'Phone GPS';

  @override
  String get ms200Gps => 'MS200 GPS';

  @override
  String get connected => 'Connected';

  @override
  String get connecting => 'Connecting...';

  @override
  String get scanning => 'Scanning...';

  @override
  String get disconnected => 'Disconnected';

  @override
  String get scanTitle => 'Scan for MS200';

  @override
  String get scanningDevices => 'Scanning for MS200 devices...';

  @override
  String get noDevicesFound => 'No devices found';

  @override
  String get retry => 'Retry';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get device => 'Device';

  @override
  String get appSettings => 'App Settings';

  @override
  String get userProfile => 'User Profile';

  @override
  String get systemSettings => 'System Settings';

  @override
  String get clockSync => 'Clock Sync';

  @override
  String get syncNow => 'Sync Now';

  @override
  String get syncedSuccess => 'Synced successfully';

  @override
  String get syncFailed => 'Sync failed';

  @override
  String get readFromDevice => 'Read from Device';

  @override
  String get writeToDevice => 'Write to Device';

  @override
  String get read => 'Read';

  @override
  String get write => 'Write';

  @override
  String get stopSensingWarning => 'Stop sensing to change parameters';

  @override
  String get cloudUpload => 'Cloud Upload';

  @override
  String get bufferToCloud => 'Buffer to Cloud';

  @override
  String get bufferDesc => 'Upload unsent data periodically';

  @override
  String get realtimeUpload => 'Realtime Upload';

  @override
  String get realtimeDesc => 'Stream data to cloud in real-time';

  @override
  String get uploadInterval => 'Upload Interval';

  @override
  String get apiBaseUrl => 'API Base URL';

  @override
  String get apiKey => 'API Key';

  @override
  String get localDatabase => 'Local Database';

  @override
  String get saveToLocalDb => 'Save to Local DB';

  @override
  String get saveDesc => 'Store sensing data locally';

  @override
  String get clearDatabase => 'Clear Local Database';

  @override
  String get clearDbTitle => 'Clear Database?';

  @override
  String get clearDbMessage =>
      'This will delete all locally stored sensing data and fall events. This action cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get clear => 'Clear';

  @override
  String get databaseCleared => 'Database cleared';

  @override
  String get start => 'Start';

  @override
  String get stop => 'Stop';

  @override
  String get scanConnect => 'Scan & Connect';

  @override
  String get disconnect => 'Disconnect';

  @override
  String get disconnectDialogTitle => 'Disconnect from device?';

  @override
  String get disconnectDialogMessage =>
      'This will disconnect from your MS200 and clear saved pairing. You will need to scan again to reconnect.';

  @override
  String get disconnectFailed => 'Could not disconnect';

  @override
  String get disconnectedReconnecting => 'Disconnected — Reconnecting...';

  @override
  String get connectedSensing => 'Connected — Sensing Active';

  @override
  String get age => 'Age';

  @override
  String get heightCm => 'Height (cm)';

  @override
  String get weightKg => 'Weight (kg)';

  @override
  String get exerciseHabit => 'Exercise Habit';

  @override
  String get medicalHistory => 'Medical History';

  @override
  String get syncUser => 'Sync User';

  @override
  String get syncSystem => 'Sync System';

  @override
  String get noDevice => 'No Device';

  @override
  String get initBluetooth => 'Initializing Bluetooth...';

  @override
  String get scanComplete => 'Scan complete. No devices found.';

  @override
  String get ext96msData => '96ms Extended Data';

  @override
  String get ext96msDesc => 'Enable IMU data at 96ms';

  @override
  String get statusIndexMode => 'Status Index Mode';

  @override
  String get siMode => 'Status Index mode';

  @override
  String get ppiMode => 'PPI mode';

  @override
  String get storageMode => 'Storage Mode';

  @override
  String get overwriteMode => 'Continuous overwrite';

  @override
  String get keepRecords => 'Keep records';

  @override
  String get advertiseSetting => 'Advertise Setting';

  @override
  String get off => 'OFF';

  @override
  String get dataSensingInterval => 'Data Sensing Interval';

  @override
  String get notificationThreshold => 'Notification Threshold';

  @override
  String get beltWarning => 'Belt Warning';

  @override
  String get statusNormal => 'Normal';

  @override
  String get statusCaution => 'Caution';

  @override
  String get statusWarning => 'Warning';

  @override
  String get statusCritical => 'Critical';

  @override
  String get statusUnknown => 'Unknown';

  @override
  String get noSensingData => 'No sensing data';

  @override
  String get noFallEvents => 'No fall events';

  @override
  String get viewDb => 'View DB';

  @override
  String get dbDebug => 'DB Debug';

  @override
  String get yrs => 'yrs';

  @override
  String get cm => 'cm';

  @override
  String get kg => 'kg';

  @override
  String get ageRange => '0 – 120 yrs';

  @override
  String get heightRange => '0 – 250 cm';

  @override
  String get weightRange => '0 – 250 kg';

  @override
  String get medicalHistoryRange => 'Range must be 0 – 10';

  @override
  String get exerciseNone => 'None';

  @override
  String get exerciseLight => 'Light';

  @override
  String get exerciseModerate => 'Moderate';

  @override
  String get exerciseHeavy => 'Heavy';

  @override
  String get min => 'min';

  @override
  String get writeSuccess => 'Settings saved successfully';

  @override
  String get writeFailed => 'Failed to save settings';

  @override
  String get displayName => 'Display name';

  @override
  String get displayNameHint => 'Enter your name';

  @override
  String get enterNameTitle => 'Enter your name';

  @override
  String get nameHint => 'Your name';

  @override
  String get saveBtn => 'Save';

  @override
  String get cancelBtn => 'Cancel';

  @override
  String get hiSafe => 'Safe';

  @override
  String get hiCaution => 'Caution';

  @override
  String get hiWarning => 'Warning';

  @override
  String get hiDanger => 'Danger';

  @override
  String get hiExtremeDanger => 'Extreme Danger';

  @override
  String get altitude => 'Altitude';

  @override
  String get fallStatus => 'Fall Status';

  @override
  String get battery => 'Battery';

  @override
  String get todayActivity => 'Today\'s Activity';

  @override
  String get appleHealthSource => 'Apple Health';

  @override
  String get steps => 'Steps';

  @override
  String get calories => 'Calories';

  @override
  String get kcal => 'kcal';

  @override
  String get activityLoading => 'Loading today\'s activity...';

  @override
  String get allowAppleHealthAccess => 'Allow Apple Health Access';

  @override
  String get appleHealthPermissionCta =>
      'Allow Apple Health access to show today\'s steps and calories.';

  @override
  String get noActivityDataToday =>
      'No Apple Health activity data available yet today.';

  @override
  String get activityLoadFailed =>
      'Could not load today\'s Apple Health activity.';

  @override
  String get altRising => '▲ Rising';

  @override
  String get altDescending => '▼ Descending';

  @override
  String get altLevel => '— Level';

  @override
  String get fallStopped => 'Stopped';

  @override
  String get fallMonitoringLow => 'Low Alt';

  @override
  String get fallMonitoringHigh => 'High Alt';

  @override
  String get fallAlarm => 'ALARM';

  @override
  String get fallInactive => 'Inactive';

  @override
  String get fallDetectedBadge => 'Fall Detected!';

  @override
  String get historyNoData => 'No historical data in this range';

  @override
  String get historyLatest => 'Latest';

  @override
  String get historyAverage => 'Average';

  @override
  String get historyMin => 'Min';

  @override
  String get historyMax => 'Max';

  @override
  String get historyTotalFalls => 'Falls';

  @override
  String get historyRecentFalls => 'Recent fall events';

  @override
  String get aboutLegal => 'About / Legal';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get cloudConsentTitle => 'Cloud Data Upload';

  @override
  String get cloudConsentMessage =>
      'When enabled, the following data from your MS200 wristband will be sent to the cloud server:\n\n• Heart rate & PPI intervals\n• Body temperature & humidity\n• GPS location (device or phone)\n• Fall detection status\n• Your name\n\nData is transmitted securely over HTTPS. You can disable uploads at any time from Settings.';

  @override
  String get cloudConsentAgree => 'Agree & Enable';

  @override
  String get cloudConsentDecline => 'Cancel';

  @override
  String get locationRationaleTitle => 'Location Access Required';

  @override
  String get locationRationaleMessage =>
      'MS200 Companion uses your phone\'s GPS to tag health readings when the wristband has no GPS signal, and to record your location during fall detection events.\n\nBackground location access allows continuous monitoring even when the app is minimized.';

  @override
  String get locationRationaleContinue => 'Continue';
}
