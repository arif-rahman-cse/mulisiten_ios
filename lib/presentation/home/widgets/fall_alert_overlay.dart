import 'package:flutter/material.dart';
import 'package:ms200_companion/core/theme/status_colors.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';

class FallAlertOverlay extends StatefulWidget {
  final VoidCallback onDismiss;
  final VoidCallback onEmergency;

  const FallAlertOverlay({
    super.key,
    required this.onDismiss,
    required this.onEmergency,
  });

  @override
  State<FallAlertOverlay> createState() => _FallAlertOverlayState();
}

class _FallAlertOverlayState extends State<FallAlertOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sc = Theme.of(context).extension<StatusColors>()!;
    final cs = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;

    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Container(
          color: sc.critical.withValues(alpha: _pulseAnimation.value * 0.9),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_rounded,
                  size: 100,
                  color: cs.onError,
                ),
                const SizedBox(height: 24),
                Text(
                  l.fallDetected,
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: cs.onError,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  l.fallMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: cs.onError.withValues(alpha: 0.9),
                      ),
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _AlertButton(
                      label: l.imOk,
                      icon: Icons.check_circle,
                      color: sc.normal,
                      onPressed: widget.onDismiss,
                    ),
                    const SizedBox(width: 24),
                    _AlertButton(
                      label: l.emergency,
                      icon: Icons.emergency,
                      color: cs.onError,
                      textColor: sc.critical,
                      onPressed: widget.onEmergency,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AlertButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color? textColor;
  final VoidCallback onPressed;

  const _AlertButton({
    required this.label,
    required this.icon,
    required this.color,
    this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final fg = textColor ?? cs.onError;
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: fg),
      label:
          Text(label, style: TextStyle(color: fg, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
