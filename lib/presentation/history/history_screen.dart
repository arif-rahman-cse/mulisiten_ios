import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ms200_companion/core/theme/status_colors.dart';
import 'package:ms200_companion/domain/model/history_models.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';
import 'package:ms200_companion/presentation/history/widgets/history_fall_card.dart';
import 'package:ms200_companion/presentation/history/widgets/history_metric_card.dart';
import 'package:ms200_companion/providers/providers.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context)!;
    final selectedRange = ref.watch(historySelectedRangeProvider);
    final historyAsync = ref.watch(historyDashboardProvider(selectedRange));
    final sc = Theme.of(context).extension<StatusColors>()!;

    return DefaultTabController(
      length: HistoryRange.values.length,
      initialIndex: selectedRange.index,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l.history),
          bottom: TabBar(
            onTap: (index) {
              ref
                  .read(historySelectedRangeProvider.notifier)
                  .select(HistoryRange.values[index]);
            },
            tabs: [
              Tab(text: l.day),
              Tab(text: l.week),
              Tab(text: l.month),
              Tab(text: l.year),
            ],
          ),
        ),
        body: historyAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => _HistoryError(message: '$error'),
          data: (history) {
            if (!history.hasAnyData) {
              return Center(
                child: Text(
                  l.historyNoData,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              );
            }

            return ListView(
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
                top: 12,
                bottom: 120,
              ),
              children: [
                HistoryMetricCard(
                  title: l.heartRate,
                  icon: Icons.monitor_heart,
                  color: sc.critical,
                  unit: ' ${l.bpm}',
                  data: history.heartRate,
                ),
                const SizedBox(height: 8),
                HistoryMetricCard(
                  title: l.temperature,
                  icon: Icons.thermostat,
                  color: sc.tempWarmEnd,
                  unit: '°C',
                  data: history.temperature,
                ),
                const SizedBox(height: 8),
                HistoryMetricCard(
                  title: l.humidity,
                  icon: Icons.water_drop,
                  color: sc.humidityEnd,
                  unit: '%',
                  data: history.humidity,
                ),
                const SizedBox(height: 8),
                HistoryMetricCard(
                  title: l.altitude,
                  icon: Icons.height,
                  color: sc.altitudeEnd,
                  unit: 'm',
                  data: history.altitude,
                ),
                const SizedBox(height: 8),
                HistoryFallCard(
                  fallCounts: history.fallCounts,
                  totalFallCount: history.totalFallCount,
                  recentFalls: history.recentFalls,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _HistoryError extends StatelessWidget {
  final String message;

  const _HistoryError({required this.message});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                final range =
                    HistoryRange.values[DefaultTabController.of(context).index];
                final container = ProviderScope.containerOf(context);
                container.invalidate(historyDashboardProvider(range));
              },
              child: Text(l.retry),
            ),
          ],
        ),
      ),
    );
  }
}
