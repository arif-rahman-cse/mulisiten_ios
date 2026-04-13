import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ms200_companion/core/theme/status_colors.dart';
import 'package:ms200_companion/domain/model/sensing_data.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';

class AltitudeFallGrid extends StatelessWidget {
  final SensingData? data;

  const AltitudeFallGrid({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _AltitudeTile(data: data)),
          const SizedBox(width: 8),
          Expanded(child: _FallStateTile(data: data)),
        ],
      ),
    );
  }
}

// ─── Altitude Tile ──────────────────────────────────────────

class _AltitudeTile extends StatelessWidget {
  final SensingData? data;
  const _AltitudeTile({this.data});

  @override
  Widget build(BuildContext context) {
    final sc = Theme.of(context).extension<StatusColors>()!;
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final alt = data?.altitudeDiffMetres ?? 0.0;

    // Gauge: 0..1 based on absolute altitude relative to max range
    final progress = (alt.abs().clamp(0.0, 2047.0) / 2047.0);

    // Direction badge
    String badgeText;
    if (alt > 0.5) {
      badgeText = l.altRising;
    } else if (alt < -0.5) {
      badgeText = l.altDescending;
    } else {
      badgeText = l.altLevel;
    }

    final startColor = sc.altitudeStart;
    final endColor = sc.altitudeEnd;

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
                Icons.height,
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
                      Flexible(
                        child: Text(
                          l.altitude,
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: cs.onSurfaceVariant,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
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
                            const Center(child: Icon(Icons.height, size: 14)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Value
                  Text(
                    '${alt >= 0 ? '+' : ''}${alt.toStringAsFixed(1)}m',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: cs.onSurface,
                      height: 1.0,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: cs.onPrimary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: cs.onPrimary.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      badgeText,
                      style: TextStyle(
                        color: cs.onPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
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

// ─── Fall State Tile ────────────────────────────────────────

class _FallStateTile extends StatelessWidget {
  final SensingData? data;
  const _FallStateTile({this.data});

  @override
  Widget build(BuildContext context) {
    final sc = Theme.of(context).extension<StatusColors>()!;
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final fallState = data?.fallState ?? -1;

    // Labels & colors per state
    String valueText;
    String badgeText;
    Color startColor;
    Color endColor;
    FaIconData icon;

    switch (fallState) {
      case -1:
        valueText = l.fallStopped;
        badgeText = l.fallInactive;
        startColor = const Color(0xFFCFD8DC); // grey
        endColor = const Color(0xFF90A4AE);
        icon = FontAwesomeIcons.userShield;
        break;
      case 0:
        valueText = l.safe;
        badgeText = l.fallMonitoringLow;
        startColor = sc.fallSafeStart;
        endColor = sc.fallSafeEnd;
        icon = FontAwesomeIcons.userShield;
        break;
      case 1:
        valueText = l.safe;
        badgeText = l.fallMonitoringHigh;
        startColor = const Color(0xFFFFF9C4); // amber light
        endColor = const Color(0xFFFFCA28); // amber
        icon = FontAwesomeIcons.user;
        break;
      default: // >= 2
        valueText = l.fallAlarm;
        badgeText = l.fallDetectedBadge;
        startColor = const Color(0xFFFFCDD2); // red light
        endColor = const Color(0xFFEF5350); // red
        icon = FontAwesomeIcons.personFallingBurst;
        break;
    }

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
            // Watermark
            Positioned(
              right: -10,
              bottom: 0,
              child: FaIcon(
                icon,
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
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          l.fallStatus,
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: cs.onSurfaceVariant,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      //Icon(icon, size: 20, color: cs.onSurfaceVariant),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Value
                  Text(
                    valueText,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: cs.onSurface,
                      height: 1.0,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: cs.onPrimary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: cs.onPrimary.withValues(alpha: 0.4),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      badgeText,
                      style: TextStyle(
                        color: cs.onPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                      ),
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
