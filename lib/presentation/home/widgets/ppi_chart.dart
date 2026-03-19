import 'dart:collection';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ms200_companion/domain/model/sensing_data.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';

class PpiChart extends StatefulWidget {
  final SensingData? latestData;

  const PpiChart({super.key, this.latestData});

  @override
  State<PpiChart> createState() => _PpiChartState();
}

class _PpiChartState extends State<PpiChart> {
  static const _maxPoints = 30;

  final _ppi0 = Queue<FlSpot>();
  final _ppi1 = Queue<FlSpot>();
  final _ppi2 = Queue<FlSpot>();
  int _index = 0;

  @override
  void didUpdateWidget(covariant PpiChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.latestData != null && widget.latestData != oldWidget.latestData) {
      _addPoint(widget.latestData!);
    }
  }

  void _addPoint(SensingData data) {
    final x = _index.toDouble();
    _index++;

    _ppi0.addLast(FlSpot(x, data.ppi0.toDouble()));
    _ppi1.addLast(FlSpot(x, data.ppi1.toDouble()));
    _ppi2.addLast(FlSpot(x, data.ppi2.toDouble()));

    while (_ppi0.length > _maxPoints) { _ppi0.removeFirst(); }
    while (_ppi1.length > _maxPoints) { _ppi1.removeFirst(); }
    while (_ppi2.length > _maxPoints) { _ppi2.removeFirst(); }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Text(
                l.ppiChart,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 160,
              child: _ppi0.isEmpty
                  ? Center(
                      child: Text(l.waitingForData, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                    )
                  : LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: true, drawVerticalLine: false),
                        titlesData: FlTitlesData(
                          leftTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                          ),
                          bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          _line(_ppi0.toList(), cs.primary),
                          _line(_ppi1.toList(), cs.secondary),
                          _line(_ppi2.toList(), cs.tertiary),
                        ],
                        lineTouchData: const LineTouchData(enabled: false),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 4),
              child: Row(
                children: [
                  _Legend(color: cs.primary, label: 'PPI0'),
                  const SizedBox(width: 12),
                  _Legend(color: cs.secondary, label: 'PPI1'),
                  const SizedBox(width: 12),
                  _Legend(color: cs.tertiary, label: 'PPI2'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartBarData _line(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 2,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: true,
        color: color.withValues(alpha: 0.08),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 10, height: 3, color: color),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurfaceVariant)),
      ],
    );
  }
}
