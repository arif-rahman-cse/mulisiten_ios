import 'dart:io';

import 'package:health/health.dart';
import 'package:ms200_companion/domain/model/daily_activity_summary.dart';

class AppleHealthRepository {
  final Health _health;
  bool _configured = false;

  AppleHealthRepository({Health? health}) : _health = health ?? Health();

  bool get isSupported => Platform.isIOS;

  Future<void> ensureConfigured() async {
    if (_configured || !isSupported) return;
    await _health.configure();
    _configured = true;
  }

  Future<bool> requestReadAuthorization() async {
    if (!isSupported) return false;
    await ensureConfigured();

    return _health.requestAuthorization(
      [HealthDataType.STEPS, HealthDataType.ACTIVE_ENERGY_BURNED],
      permissions: [HealthDataAccess.READ, HealthDataAccess.READ],
    );
  }

  Future<DailyActivitySummary> fetchTodaySummary() async {
    if (!isSupported) {
      throw UnsupportedError('Apple Health is only available on iOS.');
    }

    await ensureConfigured();

    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);

    final stepCount =
        await _health.getTotalStepsInInterval(startOfDay, now) ?? 0;
    final calories = await _fetchTodayCalories(startOfDay, now);

    return DailyActivitySummary(
      stepCount: stepCount,
      activeCalories: calories,
      fetchedAt: now,
    );
  }

  Future<double> _fetchTodayCalories(DateTime startOfDay, DateTime now) async {
    final points = await _health.getHealthDataFromTypes(
      types: [HealthDataType.ACTIVE_ENERGY_BURNED],
      startTime: startOfDay,
      endTime: now,
    );

    var total = 0.0;
    for (final point in points) {
      final value = point.value;
      if (value is NumericHealthValue) {
        total += value.numericValue.toDouble();
      }
    }

    return total;
  }
}
