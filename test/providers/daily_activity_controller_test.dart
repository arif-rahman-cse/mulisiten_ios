import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ms200_companion/data/repository/apple_health_repository.dart';
import 'package:ms200_companion/domain/model/daily_activity_summary.dart';
import 'package:ms200_companion/providers/providers.dart';

class MockAppleHealthRepository implements AppleHealthRepository {
  int fetchCount = 0;

  @override
  bool get isSupported => true;

  @override
  Future<void> ensureConfigured() async {}

  @override
  Future<bool> requestReadAuthorization() async {
    return true;
  }

  @override
  Future<DailyActivitySummary> fetchTodaySummary() async {
    fetchCount++;
    return DailyActivitySummary(
      stepCount: 1000 * fetchCount,
      activeCalories: 300.0 * fetchCount,
      fetchedAt: DateTime.now(),
    );
  }
}

void main() {
  testWidgets('DailyActivityController reloads silently on app foreground', (
    tester,
  ) async {
    final mockRepo = MockAppleHealthRepository();

    final container = ProviderContainer(
      overrides: [appleHealthRepositoryProvider.overrideWithValue(mockRepo)],
    );
    addTearDown(container.dispose);

    // To properly initialize a NotifierProvider that uses AppLifecycleListener,
    // we need to run it inside a widget test context where the WidgetsBinding is active.

    // 1. Initial read should return loading state and queue a microtask to load real data
    var state = container.read(dailyActivityProvider);
    expect(state.status, DailyActivityStatus.loading);
    expect(mockRepo.fetchCount, 0);

    // 2. Pump microtasks so the initial load() completes
    await tester.pumpAndSettle();

    state = container.read(dailyActivityProvider);
    expect(state.status, DailyActivityStatus.ready);
    expect(state.summary?.stepCount, 1000);
    expect(mockRepo.fetchCount, 1);

    // 3. Simulate App going to background, then foregrounding
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);

    // 4. Pump so the background load() completes
    await tester.pumpAndSettle();

    state = container.read(dailyActivityProvider);

    // 5. Assert that a second fetch happened, and state is directly updated to ready
    //    with the new data (no 'loading' state shown during the transition).
    expect(state.status, DailyActivityStatus.ready);
    expect(state.summary?.stepCount, 2000); // new fetchCount == 2
    expect(mockRepo.fetchCount, 2);
  });
}
