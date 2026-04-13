import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ms200_companion/domain/model/history_models.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';

class HistoryFallCard extends StatelessWidget {
  final List<HistoryChartPoint> fallCounts;
  final int totalFallCount;
  final List<HistoryFallEventItem> recentFalls;

  const HistoryFallCard({
    super.key,
    required this.fallCounts,
    required this.totalFallCount,
    required this.recentFalls,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final baseColor = cs.error;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    baseColor.withValues(alpha: 0.18),
                    baseColor.withValues(alpha: 0.06),
                  ]
                : [baseColor.withValues(alpha: 0.16), cs.surface],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person_search, color: baseColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l.fallStatus,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: baseColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      '${l.historyTotalFalls}: $totalFallCount',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: cs.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (fallCounts.isEmpty)
                _NoData(label: l.historyNoData)
              else
                SizedBox(
                  height: 180,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: _horizontalInterval,
                        getDrawingHorizontalLine: (_) => FlLine(
                          color: cs.outlineVariant.withValues(alpha: 0.35),
                          strokeWidth: 1,
                        ),
                      ),
                      titlesData: FlTitlesData(
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 32,
                            interval: _horizontalInterval,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            getTitlesWidget: _buildBottomTitle,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barTouchData: const BarTouchData(enabled: false),
                      barGroups: [
                        for (var i = 0; i < fallCounts.length; i++)
                          BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                toY: fallCounts[i].y,
                                width: 18,
                                borderRadius: BorderRadius.circular(6),
                                color: baseColor,
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Text(
                l.historyRecentFalls,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              if (recentFalls.isEmpty)
                Text(
                  l.noFallEvents,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
                )
              else
                Column(
                  children: recentFalls
                      .take(3)
                      .map((event) => _EventRow(event: event))
                      .toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }

  double get _horizontalInterval {
    final maxValue = fallCounts.fold<double>(
      0,
      (current, point) => point.y > current ? point.y : current,
    );
    if (maxValue <= 1) return 1;
    if (maxValue <= 4) return 1;
    if (maxValue <= 10) return 2;
    return (maxValue / 4).ceilToDouble();
  }

  Widget _buildBottomTitle(double value, TitleMeta meta) {
    final index = value.round();
    if (index < 0 || index >= fallCounts.length) {
      return const SizedBox.shrink();
    }

    final step = fallCounts.length <= 4 ? 1 : (fallCounts.length / 4).ceil();
    if (index % step != 0 && index != fallCounts.length - 1) {
      return const SizedBox.shrink();
    }

    return SideTitleWidget(
      meta: meta,
      child: Text(
        fallCounts[index].label,
        style: const TextStyle(fontSize: 10),
      ),
    );
  }
}

class _EventRow extends StatelessWidget {
  final HistoryFallEventItem event;

  const _EventRow({required this.event});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final timeOfDay = TimeOfDay.fromDateTime(event.occurredAt).format(context);
    final date = MaterialLocalizations.of(
      context,
    ).formatShortDate(event.occurredAt);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: cs.error),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$date $timeOfDay',
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                Text(
                  'HR ${event.heartRate}  |  ${event.temperatureCelsius.toStringAsFixed(1)}°C  |  ${event.altitudeMetres.toStringAsFixed(1)}m',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NoData extends StatelessWidget {
  final String label;

  const _NoData({required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Center(
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
