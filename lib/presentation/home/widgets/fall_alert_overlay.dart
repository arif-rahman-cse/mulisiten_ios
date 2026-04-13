import 'package:flutter/material.dart';
import 'package:ms200_companion/core/theme/status_colors.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Full-screen fall-alert overlay modelled after iOS emergency / alarm screens.
///
/// Shows a dramatic pulsing red screen with large action buttons.
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
    with TickerProviderStateMixin {
  late AnimationController _bgPulseController;
  late Animation<double> _bgPulseAnimation;
  late AnimationController _iconPulseController;
  late Animation<double> _iconScaleAnimation;

  @override
  void initState() {
    super.initState();

    // Background red pulse
    _bgPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _bgPulseAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _bgPulseController, curve: Curves.easeInOut),
    );

    // Icon scale pulse
    _iconPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
    _iconScaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _iconPulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _bgPulseController.dispose();
    _iconPulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sc = Theme.of(context).extension<StatusColors>()!;
    final cs = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;
    final size = MediaQuery.sizeOf(context);

    return AnimatedBuilder(
      animation: _bgPulseAnimation,
      builder: (context, _) {
        return Container(
          width: size.width,
          height: size.height,
          color: sc.critical.withValues(alpha: _bgPulseAnimation.value),
          child: SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),

                // Pulsing icon
                AnimatedBuilder(
                  animation: _iconScaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _iconScaleAnimation.value,
                      child: child,
                    );
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.15),
                    ),
                    alignment: Alignment.center,
                    child: FaIcon(
                      FontAwesomeIcons.personFallingBurst,
                      size: 56,
                      color: cs.onError,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // Title
                Text(
                  l.fallDetected,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: cs.onError,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                ),

                const SizedBox(height: 12),

                // Subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    l.fallMessage,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: cs.onError.withValues(alpha: 0.85),
                          height: 1.5,
                        ),
                  ),
                ),

                const Spacer(flex: 3),

                // Action buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Row(
                    children: [
                      Expanded(
                        child: _AlarmActionButton(
                          label: l.imOk,
                          icon: Icons.check_circle_outline,
                          backgroundColor: sc.normal,
                          foregroundColor: Colors.white,
                          onPressed: widget.onDismiss,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _AlarmActionButton(
                          label: l.emergency,
                          icon: Icons.sos_rounded,
                          backgroundColor: Colors.white,
                          foregroundColor: sc.critical,
                          onPressed: widget.onEmergency,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 48),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AlarmActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;

  const _AlarmActionButton({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
