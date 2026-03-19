import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:vibration/vibration.dart';
import 'package:ms200_companion/data/repository/fall_event_repository.dart';
import 'package:ms200_companion/domain/model/fall_event.dart';
import 'package:ms200_companion/domain/model/sensing_data.dart';

class FallDetectionService {
  final FallEventRepository _fallRepo;
  final _log = Logger(printer: SimplePrinter(printTime: false));
  final _fallEventController = StreamController<FallEvent>.broadcast();
  final _notifications = FlutterLocalNotificationsPlugin();

  Stream<FallEvent> get fallEvents => _fallEventController.stream;

  bool _alertActive = false;
  bool get alertActive => _alertActive;

  FallDetectionService(this._fallRepo);

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
    if (data.fallState >= 1 && !_alertActive) {
      _alertActive = true;
      final event = _fallRepo.fromSensingData(data);
      _fallEventController.add(event);

      await _fallRepo.saveFallEvent(event);

      _showNotification();
      _vibrate();

      _fallRepo.uploadImmediately(event).then((success) {
        if (!success) {
          _log.w('Fall event upload failed, queued for retry');
        }
      });
    }
  }

  void dismissAlert() {
    _alertActive = false;
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

  Future<void> _vibrate() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(pattern: [0, 500, 200, 500, 200, 500]);
    }
  }

  void dispose() {
    _fallEventController.close();
  }
}
