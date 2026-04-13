import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ms200_companion/domain/model/history_models.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';

class HistoryMetricCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final String unit;
  final HistoryMetricData data;

  const HistoryMetricCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.unit,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [color.withValues(alpha: 0.18), color.withValues(alpha: 0.08)]
                : [color.withValues(alpha: 0.18), cs.surface],
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
                  Icon(icon, color: color),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (!data.hasData)
                _NoData(label: l.historyNoData)
              else ...[
                _SummaryRow(summary: data.summary!, unit: unit),
                const SizedBox(height: 12),
                SizedBox(
                  height: 180,
                  child: LineChart(
                    LineChartData(
                      minY: _minY,
                      maxY: _maxY,
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
                            reservedSize: 42,
                            interval: _horizontalInterval,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 28,
                            interval: _labelInterval.toDouble(),
                            getTitlesWidget: _buildBottomTitle,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      lineTouchData: const LineTouchData(enabled: false),
                      lineBarsData: [
                        LineChartBarData(
                          spots: data.points
                              .map((point) => FlSpot(point.x, point.y))
                              .toList(),
                          isCurved: true,
                          color: color,
                          barWidth: 3,
                          dotData: const FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color: color.withValues(alpha: 0.12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  double get _minY {
    if (data.points.isEmpty) return 0;
    final rawMin = data.points
        .map((point) => point.y)
        .reduce((value, element) => value < element ? value : element);
    final rawMax = data.points
        .map((point) => point.y)
        .reduce((value, element) => value > element ? value : element);
    if ((rawMax - rawMin).abs() < 0.001) {
      return rawMin - 1;
    }
    return rawMin - ((rawMax - rawMin) * 0.15);
  }

  double get _maxY {
    if (data.points.isEmpty) return 1;
    final rawMin = data.points
        .map((point) => point.y)
        .reduce((value, element) => value < element ? value : element);
    final rawMax = data.points
        .map((point) => point.y)
        .reduce((value, element) => value > element ? value : element);
    if ((rawMax - rawMin).abs() < 0.001) {
      return rawMax + 1;
    }
    return rawMax + ((rawMax - rawMin) * 0.15);
  }

  double get _horizontalInterval {
    final span = (_maxY - _minY).abs();
    if (span <= 5) return 1;
    if (span <= 20) return 5;
    if (span <= 50) return 10;
    return span / 4;
  }

  int get _labelInterval {
    final length = data.points.length;
    if (length <= 4) return 1;
    return (length / 4).ceil();
  }

  Widget _buildBottomTitle(double value, TitleMeta meta) {
    final index = value.round();
    if (index < 0 || index >= data.points.length) {
      return const SizedBox.shrink();
    }

    if (index % _labelInterval != 0 && index != data.points.length - 1) {
      return const SizedBox.shrink();
    }

    return SideTitleWidget(
      meta: meta,
      child: Text(
        data.points[index].label,
        style: const TextStyle(fontSize: 10),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final HistoryMetricSummary summary;
  final String unit;

  const _SummaryRow({required this.summary, required this.unit});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _SummaryChip(label: l.historyLatest, value: _format(summary.latest)),
        _SummaryChip(label: l.historyAverage, value: _format(summary.average)),
        _SummaryChip(label: l.historyMin, value: _format(summary.min)),
        _SummaryChip(label: l.historyMax, value: _format(summary.max)),
      ],
    );
  }

  String _format(double value) {
    final decimals = value.abs() >= 100 ? 0 : 1;
    return '${value.toStringAsFixed(decimals)}$unit';
  }
}

class _SummaryChip extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(16),
      ),
      child: RichText(
        text: TextSpan(
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: cs.onSurfaceVariant),
          children: [
            TextSpan(text: '$label: '),
            TextSpan(
              text: value,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: cs.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
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
