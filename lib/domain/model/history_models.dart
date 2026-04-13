import 'package:intl/intl.dart';

enum HistoryRange { day, week, month, year }

extension HistoryRangeX on HistoryRange {
  HistoryWindow window([DateTime? now]) {
    final current = now ?? DateTime.now();
    final tomorrow = DateTime(current.year, current.month, current.day + 1);

    switch (this) {
      case HistoryRange.day:
        return HistoryWindow(
          range: this,
          start: DateTime(current.year, current.month, current.day),
          endExclusive: tomorrow,
        );
      case HistoryRange.week:
        return HistoryWindow(
          range: this,
          start: tomorrow.subtract(const Duration(days: 7)),
          endExclusive: tomorrow,
        );
      case HistoryRange.month:
        return HistoryWindow(
          range: this,
          start: DateTime(current.year, current.month, 1),
          endExclusive: tomorrow,
        );
      case HistoryRange.year:
        return HistoryWindow(
          range: this,
          start: DateTime(current.year, 1, 1),
          endExclusive: tomorrow,
        );
    }
  }
}

class HistoryWindow {
  final HistoryRange range;
  final DateTime start;
  final DateTime endExclusive;

  const HistoryWindow({
    required this.range,
    required this.start,
    required this.endExclusive,
  });

  int get startMs => start.millisecondsSinceEpoch;

  int get endExclusiveMs => endExclusive.millisecondsSinceEpoch;
}

class HistoryAggregateRow {
  final int bucketStartMs;
  final int sampleCount;
  final double heartRateAvg;
  final double heartRateMin;
  final double heartRateMax;
  final double temperatureAvg;
  final double temperatureMin;
  final double temperatureMax;
  final double humidityAvg;
  final double humidityMin;
  final double humidityMax;
  final double altitudeAvg;
  final double altitudeMin;
  final double altitudeMax;

  const HistoryAggregateRow({
    required this.bucketStartMs,
    required this.sampleCount,
    required this.heartRateAvg,
    required this.heartRateMin,
    required this.heartRateMax,
    required this.temperatureAvg,
    required this.temperatureMin,
    required this.temperatureMax,
    required this.humidityAvg,
    required this.humidityMin,
    required this.humidityMax,
    required this.altitudeAvg,
    required this.altitudeMin,
    required this.altitudeMax,
  });
}

class HistoryFallAggregateRow {
  final int bucketStartMs;
  final int eventCount;

  const HistoryFallAggregateRow({
    required this.bucketStartMs,
    required this.eventCount,
  });
}

class HistoryChartPoint {
  final double x;
  final double y;
  final DateTime timestamp;
  final String label;

  const HistoryChartPoint({
    required this.x,
    required this.y,
    required this.timestamp,
    required this.label,
  });
}

class HistoryMetricSummary {
  final double latest;
  final double min;
  final double max;
  final double average;

  const HistoryMetricSummary({
    required this.latest,
    required this.min,
    required this.max,
    required this.average,
  });
}

class HistoryMetricData {
  final List<HistoryChartPoint> points;
  final HistoryMetricSummary? summary;

  const HistoryMetricData({required this.points, required this.summary});

  bool get hasData => points.isNotEmpty && summary != null;
}

class HistoryFallEventItem {
  final int id;
  final DateTime occurredAt;
  final int fallState;
  final int heartRate;
  final double temperatureCelsius;
  final double altitudeMetres;

  const HistoryFallEventItem({
    required this.id,
    required this.occurredAt,
    required this.fallState,
    required this.heartRate,
    required this.temperatureCelsius,
    required this.altitudeMetres,
  });
}

class HistoryDashboardData {
  final HistoryWindow window;
  final HistoryMetricData heartRate;
  final HistoryMetricData temperature;
  final HistoryMetricData humidity;
  final HistoryMetricData altitude;
  final List<HistoryChartPoint> fallCounts;
  final int totalFallCount;
  final List<HistoryFallEventItem> recentFalls;

  const HistoryDashboardData({
    required this.window,
    required this.heartRate,
    required this.temperature,
    required this.humidity,
    required this.altitude,
    required this.fallCounts,
    required this.totalFallCount,
    required this.recentFalls,
  });

  bool get hasAnyData =>
      heartRate.hasData ||
      temperature.hasData ||
      humidity.hasData ||
      altitude.hasData ||
      fallCounts.isNotEmpty ||
      recentFalls.isNotEmpty;
}

String formatHistoryBucketLabel(HistoryRange range, DateTime timestamp) {
  switch (range) {
    case HistoryRange.day:
      return DateFormat.Hm().format(timestamp);
    case HistoryRange.week:
      return DateFormat.E().format(timestamp);
    case HistoryRange.month:
      return DateFormat.Md().format(timestamp);
    case HistoryRange.year:
      return DateFormat.MMM().format(timestamp);
  }
}
