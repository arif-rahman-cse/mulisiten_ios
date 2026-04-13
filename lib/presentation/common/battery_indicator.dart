import 'package:flutter/material.dart';
import 'package:ms200_companion/core/theme/status_colors.dart';

/// A compact, iPhone-style horizontal battery indicator.
///
/// Draws a rounded battery outline with a filled level bar and
/// the percentage text centered inside. Fill color follows charge
/// level using [StatusColors] (green → yellow → orange → red).
class BatteryIndicator extends StatelessWidget {
  final int level;

  const BatteryIndicator({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    final sc = Theme.of(context).extension<StatusColors>()!;
    final cs = Theme.of(context).colorScheme;
    final clamped = level.clamp(0, 100);
    final fillColor = _batteryFillColor(sc, clamped);
    final borderColor = cs.onSurfaceVariant.withValues(alpha: 0.6);
    final labelColor =
        ThemeData.estimateBrightnessForColor(fillColor) == Brightness.dark
        ? cs.onSurface
        : cs.onSurfaceVariant;

    return CustomPaint(
      painter: _BatteryPainter(
        level: clamped,
        fillColor: fillColor,
        borderColor: borderColor,
      ),
      child: SizedBox(
        width: 36,
        height: 18,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 2),
            child: Text(
              '$level',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: labelColor,
                fontFeatures: const [FontFeature.tabularFigures()],
                height: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Color _batteryFillColor(StatusColors sc, int level) {
  if (level <= 20) return sc.critical;
  if (level <= 40) return sc.warning;
  if (level <= 60) return sc.caution;
  return sc.normal;
}

class _BatteryPainter extends CustomPainter {
  final int level;
  final Color fillColor;
  final Color borderColor;

  _BatteryPainter({
    required this.level,
    required this.fillColor,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final bodyWidth = size.width - 4; // leave room for the tip
    final bodyHeight = size.height;
    final radius = bodyHeight * 0.22;
    final strokeWidth = 1.0;

    // ── Battery body outline ──
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, bodyWidth, bodyHeight),
      Radius.circular(radius),
    );

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawRRect(bodyRect, borderPaint);

    // ── Fill level ──
    final inset = strokeWidth + 1.0;
    final fillWidth = (bodyWidth - inset * 2) * (level / 100.0);

    if (fillWidth > 0) {
      final fillRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(inset, inset, fillWidth, bodyHeight - inset * 2),
        Radius.circular(radius * 0.5),
      );

      final fillPaint = Paint()
        ..color = fillColor
        ..style = PaintingStyle.fill;

      canvas.drawRRect(fillRect, fillPaint);
    }

    // ── Battery tip (positive terminal) ──
    final tipWidth = 3.0;
    final tipHeight = bodyHeight * 0.4;
    final tipTop = (bodyHeight - tipHeight) / 2;

    final tipRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(bodyWidth, tipTop, tipWidth, tipHeight),
      Radius.circular(tipWidth * 0.4),
    );

    final tipPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill;

    canvas.drawRRect(tipRect, tipPaint);
  }

  @override
  bool shouldRepaint(_BatteryPainter oldDelegate) =>
      level != oldDelegate.level ||
      fillColor != oldDelegate.fillColor ||
      borderColor != oldDelegate.borderColor;
}
