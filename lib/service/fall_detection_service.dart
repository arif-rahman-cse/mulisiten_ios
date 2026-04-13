import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:ms200_companion/data/repository/fall_event_repository.dart';
import 'package:ms200_companion/domain/model/fall_event.dart';
import 'package:ms200_companion/domain/model/sensing_data.dart';
import 'package:ms200_companion/service/alarm_service.dart';

/// Detects fall events from sensing data and manages the alert lifecycle.
///
/// Uses [ChangeNotifier] so any widget in the tree can react to
/// [alertActive] changes (e.g. the root-level overlay in app.dart).
class FallDetectionService extends ChangeNotifier {
  final FallEventRepository _fallRepo;
  final AlarmService _alarmService;
  final _log = Logger(printer: SimplePrinter(printTime: false));
  final _fallEventController = StreamController<FallEvent>.broadcast();
  final _notifications = FlutterLocalNotificationsPlugin();

  Stream<FallEvent> get fallEvents => _fallEventController.stream;

  bool _alertActive = false;
  bool get alertActive => _alertActive;

  FallDetectionService(this._fallRepo, this._alarmService);

  Future<void> initialize() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    await _notifications.initialize(
      settings: const InitializationSettings(android: android, iOS: ios),
    );
  }

  Future<void> onSensingData(SensingData data) async {
    if (data.fallState >= 2 && !_alertActive) {
      _alertActive = true;
      notifyListeners();

      final event = _fallRepo.fromSensingData(data);
      _fallEventController.add(event);

      await _fallRepo.saveFallEvent(event);

      _showNotification();
      _alarmService.startAlarm();

      _fallRepo.uploadImmediately(event).then((success) {
        if (!success) {
          _log.w('Fall event upload failed, queued for retry');
        }
      });
    }
  }

  void dismissAlert() {
    _alertActive = false;
    _alarmService.stopAlarm();
    notifyListeners();
  }

  Future<void> _showNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'fall_alerts',
      'Fall Alerts',
      channelDescription: 'Notifications for fall detection events',
      importance: Importance.max,
      priority: Priority.high,
      fullScreenIntent: true,
    );
    const details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
    await _notifications.show(
      id: 1001,
      title: 'Fall Detected!',
      body: 'A fall has been detected on your MS200 wristband.',
      notificationDetails: details,
    );
  }

  @override
  void dispose() {
    _fallEventController.close();
    _alarmService.dispose();
    super.dispose();
  }
}
