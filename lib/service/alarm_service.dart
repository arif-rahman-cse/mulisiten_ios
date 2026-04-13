import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

/// Manages alarm sound and haptic feedback for critical alerts (e.g. fall detection).
class AlarmService {
  final AudioPlayer _player = AudioPlayer();
  Timer? _vibrationTimer;
  bool _active = false;

  bool get isActive => _active;

  /// Start looping alarm sound and repeating vibration pattern.
  Future<void> startAlarm() async {
    if (_active) return;
    _active = true;

    // Play looping alarm sound
    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.setVolume(1.0);
    await _player.play(AssetSource('sounds/alarm.wav'));

    // Repeating vibration pattern:  vibrate 500ms, pause 300ms
    _startVibrationLoop();
  }

  /// Stop all alarm output.
  Future<void> stopAlarm() async {
    if (!_active) return;
    _active = false;

    await _player.stop();
    _vibrationTimer?.cancel();
    _vibrationTimer = null;
    Vibration.cancel();
  }

  void _startVibrationLoop() {
    _vibrateOnce();
    _vibrationTimer = Timer.periodic(
      const Duration(milliseconds: 1500),
      (_) => _vibrateOnce(),
    );
  }

  Future<void> _vibrateOnce() async {
    if (!_active) return;
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(pattern: [0, 500, 200, 500, 200, 500]);
    }
  }

  void dispose() {
    stopAlarm();
    _player.dispose();
  }
}
