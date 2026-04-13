class DailyActivitySummary {
  final int stepCount;
  final double activeCalories;
  final DateTime fetchedAt;

  const DailyActivitySummary({
    required this.stepCount,
    required this.activeCalories,
    required this.fetchedAt,
  });

  bool get hasData => stepCount > 0 || activeCalories > 0;
}

enum DailyActivityStatus {
  unsupported,
  loading,
  ready,
  noData,
  permissionDenied,
  error,
}

class DailyActivityState {
  final DailyActivityStatus status;
  final DailyActivitySummary? summary;
  final String? message;

  const DailyActivityState({required this.status, this.summary, this.message});

  const DailyActivityState.unsupported()
    : this(status: DailyActivityStatus.unsupported);

  const DailyActivityState.loading()
    : this(status: DailyActivityStatus.loading);

  const DailyActivityState.noData() : this(status: DailyActivityStatus.noData);

  const DailyActivityState.permissionDenied()
    : this(status: DailyActivityStatus.permissionDenied);

  const DailyActivityState.ready(DailyActivitySummary summary)
    : this(status: DailyActivityStatus.ready, summary: summary);

  const DailyActivityState.error(String message)
    : this(status: DailyActivityStatus.error, message: message);

  bool get isVisible => status != DailyActivityStatus.unsupported;
}
