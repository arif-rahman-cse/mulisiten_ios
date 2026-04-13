import 'package:flutter/material.dart';
import 'package:ms200_companion/core/theme/status_colors.dart';
import 'package:ms200_companion/domain/model/sensing_data.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';

class TempHumidityGrid extends StatelessWidget {
  final SensingData? data;

  const TempHumidityGrid({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _TempTile(data: data)),
          const SizedBox(width: 8),
          Expanded(child: _HumidityTile(data: data)),
        ],
      ),
    );
  }
}

class _TempTile extends StatelessWidget {
  final SensingData? data;
  const _TempTile({this.data});

  @override
  Widget build(BuildContext context) {
    final sc = Theme.of(context).extension<StatusColors>()!;
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final temp = data?.temperatureCelsius ?? 0;
    final hi = data?.heatIndex ?? 0;

    String getHiText(int val) {
      switch (val) {
        case 0:
          return l.hiSafe;
        case 1:
          return l.hiCaution;
        case 2:
          return l.hiWarning;
        case 3:
          return l.hiDanger;
        case 4:
          return l.hiExtremeDanger;
        default:
          return l.statusUnknown;
      }
    }

    // Determine gradient based on temp (Cool -> Mild -> Warm)
    Color startColor;
    Color endColor;
    if (temp < 15) {
      startColor = sc.tempCoolStart;
      endColor = sc.tempCoolEnd;
    } else if (temp < 30) {
      startColor = sc.tempMildStart;
      endColor = sc.tempMildEnd;
    } else {
      startColor = sc.tempWarmStart;
      endColor = sc.tempWarmEnd;
    }

    // Gauge value between 0C and 50C
    final progress = (temp.clamp(0.0, 100.0) / 100.0);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      clipBehavior: Clip.antiAlias,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    startColor.withValues(alpha: 0.2),
                    endColor.withValues(alpha: 0.2),
                  ]
                : [startColor, endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Watermark Icon
            Positioned(
              right: -10,
              bottom: -10,
              child: Icon(
                Icons.thermostat,
                size: 80,
                color: isDark
                    ? endColor.withValues(alpha: 0.1)
                    : cs.surface.withValues(alpha: 0.4),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.temperature,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: cs.onSurfaceVariant,
                            ),
                      ),
                      // Gauge Ring
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 3,
                              strokeCap: StrokeCap.round,
                              backgroundColor: cs.onSurface.withValues(
                                alpha: 0.15,
                              ),
                              color: cs.onSurface,
                            ),
                            const Center(
                              child: Icon(Icons.thermostat, size: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Data
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${temp.toStringAsFixed(1)}°',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: cs.onSurface,
                              height: 1.0,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: cs.onPrimary.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: cs.onPrimary.withValues(alpha: 0.4),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              getHiText(hi),
                              style: TextStyle(
                                color: cs.onPrimary,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HumidityTile extends StatelessWidget {
  final SensingData? data;
  const _HumidityTile({this.data});

  @override
  Widget build(BuildContext context) {
    final sc = Theme.of(context).extension<StatusColors>()!;
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final hum = data?.humidityPercent ?? 0;

    // Deep blue to cyan gradient
    final startColor = sc.humidityStart;
    final endColor = sc.humidityEnd;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Gauge value between 0% and 100%
    final progress = (hum.clamp(0.0, 100.0) / 100.0);

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    startColor.withValues(alpha: 0.15),
                    endColor.withValues(alpha: 0.25),
                  ]
                : [startColor, endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Watermark Icon
            Positioned(
              right: -10,
              bottom: -15,
              child: Icon(
                Icons.water_drop,
                size: 80,
                color: isDark
                    ? endColor.withValues(alpha: 0.1)
                    : cs.surface.withValues(alpha: 0.4),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.humidity,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: cs.onSurfaceVariant,
                            ),
                      ),
                      // Gauge Ring
                      SizedBox(
                        width: 28,
                        height: 28,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 3,
                              strokeCap: StrokeCap.round,
                              backgroundColor: cs.onSurface.withValues(
                                alpha: 0.15,
                              ),
                              color: cs.onSurface,
                            ),
                            const Center(
                              child: Icon(Icons.water_drop, size: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Data
                  Text(
                    '${hum.toStringAsFixed(1)}%',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: cs.onSurface,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
