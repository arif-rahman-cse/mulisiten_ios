import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'MULiSiTEN'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get month;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @scanForDevices.
  ///
  /// In en, this message translates to:
  /// **'Scan for Devices'**
  String get scanForDevices;

  /// No description provided for @noDevicePaired.
  ///
  /// In en, this message translates to:
  /// **'No device paired'**
  String get noDevicePaired;

  /// No description provided for @scanHint.
  ///
  /// In en, this message translates to:
  /// **'Scan for an MS200 wristband to get started'**
  String get scanHint;

  /// No description provided for @heartRate.
  ///
  /// In en, this message translates to:
  /// **'Heart Rate'**
  String get heartRate;

  /// No description provided for @bpm.
  ///
  /// In en, this message translates to:
  /// **'BPM'**
  String get bpm;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @humidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;

  /// No description provided for @ppiChart.
  ///
  /// In en, this message translates to:
  /// **'PPI (Peak-to-Peak Interval)'**
  String get ppiChart;

  /// No description provided for @waitingForData.
  ///
  /// In en, this message translates to:
  /// **'Waiting for data...'**
  String get waitingForData;

  /// No description provided for @fallDetected.
  ///
  /// In en, this message translates to:
  /// **'FALL DETECTED'**
  String get fallDetected;

  /// No description provided for @fallMessage.
  ///
  /// In en, this message translates to:
  /// **'A fall event has been detected.\nAre you okay?'**
  String get fallMessage;

  /// No description provided for @imOk.
  ///
  /// In en, this message translates to:
  /// **'I\'m OK'**
  String get imOk;

  /// No description provided for @emergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get emergency;

  /// No description provided for @safe.
  ///
  /// In en, this message translates to:
  /// **'Safe'**
  String get safe;

  /// No description provided for @fall.
  ///
  /// In en, this message translates to:
  /// **'FALL'**
  String get fall;

  /// No description provided for @noGps.
  ///
  /// In en, this message translates to:
  /// **'No GPS'**
  String get noGps;

  /// No description provided for @phoneGps.
  ///
  /// In en, this message translates to:
  /// **'Phone GPS'**
  String get phoneGps;

  /// No description provided for @ms200Gps.
  ///
  /// In en, this message translates to:
  /// **'MS200 GPS'**
  String get ms200Gps;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// No description provided for @connecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get connecting;

  /// No description provided for @scanning.
  ///
  /// In en, this message translates to:
  /// **'Scanning...'**
  String get scanning;

  /// No description provided for @disconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get disconnected;

  /// No description provided for @scanTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan for MS200'**
  String get scanTitle;

  /// No description provided for @scanningDevices.
  ///
  /// In en, this message translates to:
  /// **'Scanning for MS200 devices...'**
  String get scanningDevices;

  /// No description provided for @noDevicesFound.
  ///
  /// In en, this message translates to:
  /// **'No devices found'**
  String get noDevicesFound;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @device.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get device;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @userProfile.
  ///
  /// In en, this message translates to:
  /// **'User Profile'**
  String get userProfile;

  /// No description provided for @systemSettings.
  ///
  /// In en, this message translates to:
  /// **'System Settings'**
  String get systemSettings;

  /// No description provided for @clockSync.
  ///
  /// In en, this message translates to:
  /// **'Clock Sync'**
  String get clockSync;

  /// No description provided for @syncNow.
  ///
  /// In en, this message translates to:
  /// **'Sync Now'**
  String get syncNow;

  /// No description provided for @syncedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Synced successfully'**
  String get syncedSuccess;

  /// No description provided for @syncFailed.
  ///
  /// In en, this message translates to:
  /// **'Sync failed'**
  String get syncFailed;

  /// No description provided for @readFromDevice.
  ///
  /// In en, this message translates to:
  /// **'Read from Device'**
  String get readFromDevice;

  /// No description provided for @writeToDevice.
  ///
  /// In en, this message translates to:
  /// **'Write to Device'**
  String get writeToDevice;

  /// No description provided for @read.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get read;

  /// No description provided for @write.
  ///
  /// In en, this message translates to:
  /// **'Write'**
  String get write;

  /// No description provided for @stopSensingWarning.
  ///
  /// In en, this message translates to:
  /// **'Stop sensing to change parameters'**
  String get stopSensingWarning;

  /// No description provided for @cloudUpload.
  ///
  /// In en, this message translates to:
  /// **'Cloud Upload'**
  String get cloudUpload;

  /// No description provided for @bufferToCloud.
  ///
  /// In en, this message translates to:
  /// **'Buffer to Cloud'**
  String get bufferToCloud;

  /// No description provided for @bufferDesc.
  ///
  /// In en, this message translates to:
  /// **'Upload unsent data periodically'**
  String get bufferDesc;

  /// No description provided for @realtimeUpload.
  ///
  /// In en, this message translates to:
  /// **'Realtime Upload'**
  String get realtimeUpload;

  /// No description provided for @realtimeDesc.
  ///
  /// In en, this message translates to:
  /// **'Stream data to cloud in real-time'**
  String get realtimeDesc;

  /// No description provided for @uploadInterval.
  ///
  /// In en, this message translates to:
  /// **'Upload Interval'**
  String get uploadInterval;

  /// No description provided for @apiBaseUrl.
  ///
  /// In en, this message translates to:
  /// **'API Base URL'**
  String get apiBaseUrl;

  /// No description provided for @apiKey.
  ///
  /// In en, this message translates to:
  /// **'API Key'**
  String get apiKey;

  /// No description provided for @localDatabase.
  ///
  /// In en, this message translates to:
  /// **'Local Database'**
  String get localDatabase;

  /// No description provided for @saveToLocalDb.
  ///
  /// In en, this message translates to:
  /// **'Save to Local DB'**
  String get saveToLocalDb;

  /// No description provided for @saveDesc.
  ///
  /// In en, this message translates to:
  /// **'Store sensing data locally'**
  String get saveDesc;

  /// No description provided for @clearDatabase.
  ///
  /// In en, this message translates to:
  /// **'Clear Local Database'**
  String get clearDatabase;

  /// No description provided for @clearDbTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear Database?'**
  String get clearDbTitle;

  /// No description provided for @clearDbMessage.
  ///
  /// In en, this message translates to:
  /// **'This will delete all locally stored sensing data and fall events. This action cannot be undone.'**
  String get clearDbMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @databaseCleared.
  ///
  /// In en, this message translates to:
  /// **'Database cleared'**
  String get databaseCleared;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @scanConnect.
  ///
  /// In en, this message translates to:
  /// **'Scan & Connect'**
  String get scanConnect;

  /// No description provided for @disconnect.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get disconnect;

  /// No description provided for @disconnectDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Disconnect from device?'**
  String get disconnectDialogTitle;

  /// No description provided for @disconnectDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'This will disconnect from your MS200 and clear saved pairing. You will need to scan again to reconnect.'**
  String get disconnectDialogMessage;

  /// No description provided for @disconnectFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not disconnect'**
  String get disconnectFailed;

  /// No description provided for @disconnectedReconnecting.
  ///
  /// In en, this message translates to:
  /// **'Disconnected — Reconnecting...'**
  String get disconnectedReconnecting;

  /// No description provided for @connectedSensing.
  ///
  /// In en, this message translates to:
  /// **'Connected — Sensing Active'**
  String get connectedSensing;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @heightCm.
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get heightCm;

  /// No description provided for @weightKg.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weightKg;

  /// No description provided for @exerciseHabit.
  ///
  /// In en, this message translates to:
  /// **'Exercise Habit'**
  String get exerciseHabit;

  /// No description provided for @medicalHistory.
  ///
  /// In en, this message translates to:
  /// **'Medical History'**
  String get medicalHistory;

  /// No description provided for @syncUser.
  ///
  /// In en, this message translates to:
  /// **'Sync User'**
  String get syncUser;

  /// No description provided for @syncSystem.
  ///
  /// In en, this message translates to:
  /// **'Sync System'**
  String get syncSystem;

  /// No description provided for @noDevice.
  ///
  /// In en, this message translates to:
  /// **'No Device'**
  String get noDevice;

  /// No description provided for @initBluetooth.
  ///
  /// In en, this message translates to:
  /// **'Initializing Bluetooth...'**
  String get initBluetooth;

  /// No description provided for @scanComplete.
  ///
  /// In en, this message translates to:
  /// **'Scan complete. No devices found.'**
  String get scanComplete;

  /// No description provided for @ext96msData.
  ///
  /// In en, this message translates to:
  /// **'96ms Extended Data'**
  String get ext96msData;

  /// No description provided for @ext96msDesc.
  ///
  /// In en, this message translates to:
  /// **'Enable IMU data at 96ms'**
  String get ext96msDesc;

  /// No description provided for @statusIndexMode.
  ///
  /// In en, this message translates to:
  /// **'Status Index Mode'**
  String get statusIndexMode;

  /// No description provided for @siMode.
  ///
  /// In en, this message translates to:
  /// **'Status Index mode'**
  String get siMode;

  /// No description provided for @ppiMode.
  ///
  /// In en, this message translates to:
  /// **'PPI mode'**
  String get ppiMode;

  /// No description provided for @storageMode.
  ///
  /// In en, this message translates to:
  /// **'Storage Mode'**
  String get storageMode;

  /// No description provided for @overwriteMode.
  ///
  /// In en, this message translates to:
  /// **'Continuous overwrite'**
  String get overwriteMode;

  /// No description provided for @keepRecords.
  ///
  /// In en, this message translates to:
  /// **'Keep records'**
  String get keepRecords;

  /// No description provided for @advertiseSetting.
  ///
  /// In en, this message translates to:
  /// **'Advertise Setting'**
  String get advertiseSetting;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'OFF'**
  String get off;

  /// No description provided for @dataSensingInterval.
  ///
  /// In en, this message translates to:
  /// **'Data Sensing Interval'**
  String get dataSensingInterval;

  /// No description provided for @notificationThreshold.
  ///
  /// In en, this message translates to:
  /// **'Notification Threshold'**
  String get notificationThreshold;

  /// No description provided for @beltWarning.
  ///
  /// In en, this message translates to:
  /// **'Belt Warning'**
  String get beltWarning;

  /// No description provided for @statusNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get statusNormal;

  /// No description provided for @statusCaution.
  ///
  /// In en, this message translates to:
  /// **'Caution'**
  String get statusCaution;

  /// No description provided for @statusWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get statusWarning;

  /// No description provided for @statusCritical.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get statusCritical;

  /// No description provided for @statusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get statusUnknown;

  /// No description provided for @noSensingData.
  ///
  /// In en, this message translates to:
  /// **'No sensing data'**
  String get noSensingData;

  /// No description provided for @noFallEvents.
  ///
  /// In en, this message translates to:
  /// **'No fall events'**
  String get noFallEvents;

  /// No description provided for @viewDb.
  ///
  /// In en, this message translates to:
  /// **'View DB'**
  String get viewDb;

  /// No description provided for @dbDebug.
  ///
  /// In en, this message translates to:
  /// **'DB Debug'**
  String get dbDebug;

  /// No description provided for @yrs.
  ///
  /// In en, this message translates to:
  /// **'yrs'**
  String get yrs;

  /// No description provided for @cm.
  ///
  /// In en, this message translates to:
  /// **'cm'**
  String get cm;

  /// No description provided for @kg.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get kg;

  /// No description provided for @ageRange.
  ///
  /// In en, this message translates to:
  /// **'0 – 120 yrs'**
  String get ageRange;

  /// No description provided for @heightRange.
  ///
  /// In en, this message translates to:
  /// **'0 – 250 cm'**
  String get heightRange;

  /// No description provided for @weightRange.
  ///
  /// In en, this message translates to:
  /// **'0 – 250 kg'**
  String get weightRange;

  /// No description provided for @medicalHistoryRange.
  ///
  /// In en, this message translates to:
  /// **'Range must be 0 – 10'**
  String get medicalHistoryRange;

  /// No description provided for @exerciseNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get exerciseNone;

  /// No description provided for @exerciseLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get exerciseLight;

  /// No description provided for @exerciseModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get exerciseModerate;

  /// No description provided for @exerciseHeavy.
  ///
  /// In en, this message translates to:
  /// **'Heavy'**
  String get exerciseHeavy;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get min;

  /// No description provided for @writeSuccess.
  ///
  /// In en, this message translates to:
  /// **'Settings saved successfully'**
  String get writeSuccess;

  /// No description provided for @writeFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to save settings'**
  String get writeFailed;

  /// No description provided for @displayName.
  ///
  /// In en, this message translates to:
  /// **'Display name'**
  String get displayName;

  /// No description provided for @displayNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get displayNameHint;

  /// No description provided for @enterNameTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterNameTitle;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get nameHint;

  /// No description provided for @saveBtn.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveBtn;

  /// No description provided for @cancelBtn.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelBtn;

  /// No description provided for @hiSafe.
  ///
  /// In en, this message translates to:
  /// **'Safe'**
  String get hiSafe;

  /// No description provided for @hiCaution.
  ///
  /// In en, this message translates to:
  /// **'Caution'**
  String get hiCaution;

  /// No description provided for @hiWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get hiWarning;

  /// No description provided for @hiDanger.
  ///
  /// In en, this message translates to:
  /// **'Danger'**
  String get hiDanger;

  /// No description provided for @hiExtremeDanger.
  ///
  /// In en, this message translates to:
  /// **'Extreme Danger'**
  String get hiExtremeDanger;

  /// No description provided for @altitude.
  ///
  /// In en, this message translates to:
  /// **'Altitude'**
  String get altitude;

  /// No description provided for @fallStatus.
  ///
  /// In en, this message translates to:
  /// **'Fall Status'**
  String get fallStatus;

  /// No description provided for @battery.
  ///
  /// In en, this message translates to:
  /// **'Battery'**
  String get battery;

  /// No description provided for @todayActivity.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Activity'**
  String get todayActivity;

  /// No description provided for @appleHealthSource.
  ///
  /// In en, this message translates to:
  /// **'Apple Health'**
  String get appleHealthSource;

  /// No description provided for @steps.
  ///
  /// In en, this message translates to:
  /// **'Steps'**
  String get steps;

  /// No description provided for @calories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get calories;

  /// No description provided for @kcal.
  ///
  /// In en, this message translates to:
  /// **'kcal'**
  String get kcal;

  /// No description provided for @activityLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading today\'s activity...'**
  String get activityLoading;

  /// No description provided for @allowAppleHealthAccess.
  ///
  /// In en, this message translates to:
  /// **'Allow Apple Health Access'**
  String get allowAppleHealthAccess;

  /// No description provided for @appleHealthPermissionCta.
  ///
  /// In en, this message translates to:
  /// **'Allow Apple Health access to show today\'s steps and calories.'**
  String get appleHealthPermissionCta;

  /// No description provided for @noActivityDataToday.
  ///
  /// In en, this message translates to:
  /// **'No Apple Health activity data available yet today.'**
  String get noActivityDataToday;

  /// No description provided for @activityLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load today\'s Apple Health activity.'**
  String get activityLoadFailed;

  /// No description provided for @altRising.
  ///
  /// In en, this message translates to:
  /// **'▲ Rising'**
  String get altRising;

  /// No description provided for @altDescending.
  ///
  /// In en, this message translates to:
  /// **'▼ Descending'**
  String get altDescending;

  /// No description provided for @altLevel.
  ///
  /// In en, this message translates to:
  /// **'— Level'**
  String get altLevel;

  /// No description provided for @fallStopped.
  ///
  /// In en, this message translates to:
  /// **'Stopped'**
  String get fallStopped;

  /// No description provided for @fallMonitoringLow.
  ///
  /// In en, this message translates to:
  /// **'Low Alt'**
  String get fallMonitoringLow;

  /// No description provided for @fallMonitoringHigh.
  ///
  /// In en, this message translates to:
  /// **'High Alt'**
  String get fallMonitoringHigh;

  /// No description provided for @fallAlarm.
  ///
  /// In en, this message translates to:
  /// **'ALARM'**
  String get fallAlarm;

  /// No description provided for @fallInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get fallInactive;

  /// No description provided for @fallDetectedBadge.
  ///
  /// In en, this message translates to:
  /// **'Fall Detected!'**
  String get fallDetectedBadge;

  /// No description provided for @historyNoData.
  ///
  /// In en, this message translates to:
  /// **'No historical data in this range'**
  String get historyNoData;

  /// No description provided for @historyLatest.
  ///
  /// In en, this message translates to:
  /// **'Latest'**
  String get historyLatest;

  /// No description provided for @historyAverage.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get historyAverage;

  /// No description provided for @historyMin.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get historyMin;

  /// No description provided for @historyMax.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get historyMax;

  /// No description provided for @historyTotalFalls.
  ///
  /// In en, this message translates to:
  /// **'Falls'**
  String get historyTotalFalls;

  /// No description provided for @historyRecentFalls.
  ///
  /// In en, this message translates to:
  /// **'Recent fall events'**
  String get historyRecentFalls;

  /// No description provided for @aboutLegal.
  ///
  /// In en, this message translates to:
  /// **'About / Legal'**
  String get aboutLegal;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @cloudConsentTitle.
  ///
  /// In en, this message translates to:
  /// **'Cloud Data Upload'**
  String get cloudConsentTitle;

  /// No description provided for @cloudConsentMessage.
  ///
  /// In en, this message translates to:
  /// **'When enabled, the following data from your MS200 wristband will be sent to the cloud server:\n\n• Heart rate & PPI intervals\n• Body temperature & humidity\n• GPS location (device or phone)\n• Fall detection status\n• Your name\n\nData is transmitted securely over HTTPS. You can disable uploads at any time from Settings.'**
  String get cloudConsentMessage;

  /// No description provided for @cloudConsentAgree.
  ///
  /// In en, this message translates to:
  /// **'Agree & Enable'**
  String get cloudConsentAgree;

  /// No description provided for @cloudConsentDecline.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cloudConsentDecline;

  /// No description provided for @locationRationaleTitle.
  ///
  /// In en, this message translates to:
  /// **'Location Access Required'**
  String get locationRationaleTitle;

  /// No description provided for @locationRationaleMessage.
  ///
  /// In en, this message translates to:
  /// **'MS200 Companion uses your phone\'s GPS to tag health readings when the wristband has no GPS signal, and to record your location during fall detection events.\n\nBackground location access allows continuous monitoring even when the app is minimized.'**
  String get locationRationaleMessage;

  /// No description provided for @locationRationaleContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get locationRationaleContinue;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
