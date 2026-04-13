import 'package:flutter/material.dart';
import 'package:ms200_companion/core/theme/status_colors.dart';
import 'package:ms200_companion/domain/model/sensing_data.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';

class HeartRateCard extends StatefulWidget {
  final SensingData? data;

  const HeartRateCard({super.key, this.data});

  @override
  State<HeartRateCard> createState() => _HeartRateCardState();
}

class _HeartRateCardState extends State<HeartRateCard>
/* with SingleTickerProviderStateMixin */ {
  // late AnimationController _pulseController;
  // late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    /*
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _updatePulseDuration();
    */
  }

  @override
  void didUpdateWidget(covariant HeartRateCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    /*
    if (oldWidget.data?.heartRate != widget.data?.heartRate) {
      _updatePulseDuration();
    }
    */
  }

  /*
  void _updatePulseDuration() {
    final hr = widget.data?.heartRate ?? 0;
    if (hr > 0) {
      // 60 BPM = 1 beat per second
      final durationMs = (60000 / hr).round();
      // Keep within reasonable bounds (e.g., 30bpm to 200bpm)
      final safeDurationMs = durationMs.clamp(300, 2000);
      _pulseController.duration = Duration(milliseconds: safeDurationMs);
      if (!_pulseController.isAnimating) {
        _pulseController.repeat(reverse: true);
      }
    } else {
      _pulseController.duration = const Duration(seconds: 1);
    }
  }
  */

  @override
  void dispose() {
    // _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sc = Theme.of(context).extension<StatusColors>()!;
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final hr = widget.data?.heartRate ?? 0;
    final level = widget.data?.statusLevel ?? -1;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final baseColor = level >= 0
        ? sc.colorForStatusLevel(level)
        : sc.connDisconnected;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    baseColor.withValues(alpha: 0.2),
                    baseColor.withValues(alpha: 0.1),
                  ]
                : [baseColor, baseColor.withValues(alpha: 0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Background Watermark Pulse
            Positioned(
              right: -20,
              bottom: -30,
              // Animation commented out to keep it static
              /*
              child: ScaleTransition(
                scale: _pulseAnimation,
                child: Icon(
                  Icons.favorite,
                  size: 160,
                  color: cs.onPrimary.withValues(alpha: 0.15),
                ),
              ),
              */
              child: Icon(
                Icons.favorite,
                size: 120,
                color: isDark
                    ? baseColor.withValues(alpha: 0.1)
                    : cs.onPrimary.withValues(alpha: 0.15),
              ),
            ),

            // Foreground Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.monitor_heart,
                            color: cs.onPrimary.withValues(alpha: 0.7),
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l.heartRate,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: cs.onPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      if (level >= 0) _StatusBadge(level: level),
                    ],
                  ),

                  // Data
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '$hr',
                        style: Theme.of(context).textTheme.displayLarge
                            ?.copyWith(
                              color: cs.onPrimary,
                              fontSize: 60,
                              fontWeight: FontWeight.w800,
                              height: 1.0,
                            ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l.bpm,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: cs.onPrimary.withValues(alpha: 0.7),
                              fontWeight: FontWeight.w600,
                            ),
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

class _StatusBadge extends StatelessWidget {
  final int level;
  const _StatusBadge({required this.level});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final label = switch (level) {
      0 => l.statusNormal,
      1 => l.statusCaution,
      2 => l.statusWarning,
      3 => l.statusCritical,
      _ => l.statusUnknown,
    };
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: cs.onPrimary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.onPrimary.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: cs.onPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}
