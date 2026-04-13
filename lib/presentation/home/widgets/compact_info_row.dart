import 'package:flutter/material.dart';
import 'package:ms200_companion/core/theme/status_colors.dart';
import 'package:ms200_companion/domain/model/sensing_data.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';

class CompactInfoRow extends StatelessWidget {
  final SensingData? data;

  const CompactInfoRow({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final fallState = data?.fallState ?? -1;
    final bat = data?.batteryLevel ?? 0;
    final hasGps = data?.hasGps ?? false;
    final locSrc = data?.locationSource ?? 'MS200';
    final altitudeDiff = data?.altitudeDiff ?? 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: isDark
            ? cs.surfaceContainerHigh.withValues(alpha: 0.5)
            : cs.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? cs.outlineVariant.withValues(alpha: 0.2)
              : cs.outlineVariant.withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: cs.shadow.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Altitude: $altitudeDiff"),
                ),
              ),
              _buildDivider(cs, isDark),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _FallSegment(fallState: fallState),
                ),
              ),
              _buildDivider(cs, isDark),
              Expanded(
                flex: 4,
                child: Center(
                  child: _GpsSegment(
                    hasGps: hasGps,
                    source: locSrc,
                    data: data,
                  ),
                ),
              ),
              _buildDivider(cs, isDark),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: _BatterySegment(level: bat),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(ColorScheme cs, bool isDark) {
    return Container(
      width: 1,
      height: 24,
      color: isDark
          ? cs.outlineVariant.withValues(alpha: 0.5)
          : cs.outlineVariant,
    );
  }
}

class _FallSegment extends StatelessWidget {
  final int fallState;
  const _FallSegment({required this.fallState});

  @override
  Widget build(BuildContext context) {
    final sc = Theme.of(context).extension<StatusColors>()!;
    final cs = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;

    final detected = fallState >= 1;
    final color = detected ? sc.critical : sc.normal;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          detected ? Icons.warning_rounded : Icons.shield_rounded,
          size: 18,
          color: color,
        ),
        const SizedBox(width: 6),
        Text(
          detected ? l.fall : l.safe,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: detected ? color : cs.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _GpsSegment extends StatelessWidget {
  final bool hasGps;
  final String source;
  final SensingData? data;
  const _GpsSegment({required this.hasGps, required this.source, this.data});

  //No need to show the location coordinate value show only which location is active (MS200 or PHONE)
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;

    if (!hasGps) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_off_rounded,
            size: 16,
            color: cs.onSurfaceVariant.withValues(alpha: 0.6),
          ),
          const SizedBox(width: 6),
          Text(
            l.noGps,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: cs.onSurfaceVariant.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }

    final isPhone = source == 'PHONE';
    //final icon = isPhone ? Icons.phone_android_rounded : Icons.watch_rounded;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.location_on_rounded, size: 16, color: cs.primary),
        //const SizedBox(width: 2),
        //Icon(icon, size: 12, color: cs.primary.withValues(alpha: 0.8)),
        const SizedBox(width: 6),
        Text(
          isPhone ? l.phoneGps : l.ms200Gps,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: cs.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _BatterySegment extends StatelessWidget {
  final int level;
  const _BatterySegment({required this.level});

  @override
  Widget build(BuildContext context) {
    final sc = Theme.of(context).extension<StatusColors>()!;
    final cs = Theme.of(context).colorScheme;

    final isLow = level <= 20;
    final color = isLow ? sc.critical : sc.normal;

    IconData getBatteryIcon() {
      if (level > 90) return Icons.battery_full_rounded;
      if (level > 60) return Icons.battery_5_bar_rounded;
      if (level > 30) return Icons.battery_3_bar_rounded;
      if (level > 10) return Icons.battery_1_bar_rounded;
      return Icons.battery_0_bar_rounded;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(getBatteryIcon(), size: 20, color: color),
        const SizedBox(width: 4),
        Text(
          '$level%',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: isLow ? color : cs.onSurfaceVariant,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}
