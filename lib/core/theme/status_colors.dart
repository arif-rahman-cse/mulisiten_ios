import 'package:flutter/material.dart';
import 'package:ms200_companion/core/theme/app_colors.dart';

/// Domain-specific colors resolvable via [Theme.of(context).extension<StatusColors>()].
///
/// Covers health-status levels, BLE connection states, and inline warning banners.
@immutable
class StatusColors extends ThemeExtension<StatusColors> {
  const StatusColors({
    required this.normal,
    required this.caution,
    required this.warning,
    required this.critical,
    required this.heatExtreme,
    required this.connConnected,
    required this.connConnecting,
    required this.connScanning,
    required this.connDisconnected,
    required this.warningBg,
    required this.warningText,
    required this.tempCoolStart,
    required this.tempCoolEnd,
    required this.tempMildStart,
    required this.tempMildEnd,
    required this.tempWarmStart,
    required this.tempWarmEnd,
    required this.humidityStart,
    required this.humidityEnd,
    required this.altitudeStart,
    required this.altitudeEnd,
    required this.fallSafeStart,
    required this.fallSafeEnd,
    required this.batteryStart,
    required this.batteryEnd,
  });

  // ── Health-status levels ───────────────────────────────────
  final Color normal;
  final Color caution;
  final Color warning;
  final Color critical;
  final Color heatExtreme;

  // ── BLE connection states ──────────────────────────────────
  final Color connConnected;
  final Color connConnecting;
  final Color connScanning;
  final Color connDisconnected;

  // ── Inline warning banners ─────────────────────────────────
  final Color warningBg;
  final Color warningText;

  // ── Sensor Gradients ───────────────────────────────────────
  final Color tempCoolStart;
  final Color tempCoolEnd;
  final Color tempMildStart;
  final Color tempMildEnd;
  final Color tempWarmStart;
  final Color tempWarmEnd;
  final Color humidityStart;
  final Color humidityEnd;
  final Color altitudeStart;
  final Color altitudeEnd;
  final Color fallSafeStart;
  final Color fallSafeEnd;
  final Color batteryStart;
  final Color batteryEnd;

  // ── Helpers ────────────────────────────────────────────────

  /// Returns the colour for a health-status level (0–3).
  Color colorForStatusLevel(int level) {
    switch (level) {
      case 0:
        return normal;
      case 1:
        return caution;
      case 2:
        return warning;
      case 3:
        return critical;
      default:
        return connDisconnected; // grey fallback
    }
  }

  /// Returns the colour for a heat-index level (0–4).
  Color colorForHeatIndex(int index) {
    switch (index) {
      case 0:
        return normal;
      case 1:
        return caution;
      case 2:
        return warning;
      case 3:
        return critical;
      case 4:
        return heatExtreme;
      default:
        return connDisconnected; // grey fallback
    }
  }

  // ── Factory constructors ───────────────────────────────────

  factory StatusColors.light() => const StatusColors(
    normal: AppColors.statusGreen,
    caution: AppColors.statusYellow,
    warning: AppColors.statusOrange,
    critical: AppColors.statusRed,
    heatExtreme: AppColors.statusDarkRed,
    connConnected: AppColors.connectionConnected,
    connConnecting: AppColors.connectionConnecting,
    connScanning: AppColors.connectionScanning,
    connDisconnected: AppColors.connectionDisconnected,
    warningBg: AppColors.warningContainerLight,
    warningText: AppColors.warningLight,
    tempCoolStart: AppColors.tempCoolStart,
    tempCoolEnd: AppColors.tempCoolEnd,
    tempMildStart: AppColors.tempMildStart,
    tempMildEnd: AppColors.tempMildEnd,
    tempWarmStart: AppColors.tempWarmStart,
    tempWarmEnd: AppColors.tempWarmEnd,
    humidityStart: AppColors.humidityStart,
    humidityEnd: AppColors.humidityEnd,
    altitudeStart: AppColors.altitudeStart,
    altitudeEnd: AppColors.altitudeEnd,
    fallSafeStart: AppColors.fallSafeStart,
    fallSafeEnd: AppColors.fallSafeEnd,
    batteryStart: AppColors.batteryStart,
    batteryEnd: AppColors.batteryEnd,
  );

  factory StatusColors.dark() => const StatusColors(
    normal: AppColors.statusGreen,
    caution: AppColors.statusYellow,
    warning: AppColors.statusOrange,
    critical: AppColors.statusRed,
    heatExtreme: AppColors.statusDarkRed,
    connConnected: AppColors.connectionConnected,
    connConnecting: AppColors.connectionConnecting,
    connScanning: AppColors.connectionScanning,
    connDisconnected: AppColors.connectionDisconnected,
    warningBg: AppColors.warningContainerDark,
    warningText: AppColors.warningDark,
    tempCoolStart: AppColors.tempCoolStart,
    tempCoolEnd: AppColors.tempCoolEnd,
    tempMildStart: AppColors.tempMildStart,
    tempMildEnd: AppColors.tempMildEnd,
    tempWarmStart: AppColors.tempWarmStart,
    tempWarmEnd: AppColors.tempWarmEnd,
    humidityStart: AppColors.humidityStart,
    humidityEnd: AppColors.humidityEnd,
    altitudeStart: AppColors.altitudeStart,
    altitudeEnd: AppColors.altitudeEnd,
    fallSafeStart: AppColors.fallSafeStart,
    fallSafeEnd: AppColors.fallSafeEnd,
    batteryStart: AppColors.batteryStart,
    batteryEnd: AppColors.batteryEnd,
  );

  // ── ThemeExtension overrides ───────────────────────────────

  @override
  StatusColors copyWith({
    Color? normal,
    Color? caution,
    Color? warning,
    Color? critical,
    Color? heatExtreme,
    Color? connConnected,
    Color? connConnecting,
    Color? connScanning,
    Color? connDisconnected,
    Color? warningBg,
    Color? warningText,
    Color? tempCoolStart,
    Color? tempCoolEnd,
    Color? tempMildStart,
    Color? tempMildEnd,
    Color? tempWarmStart,
    Color? tempWarmEnd,
    Color? humidityStart,
    Color? humidityEnd,
    Color? altitudeStart,
    Color? altitudeEnd,
    Color? fallSafeStart,
    Color? fallSafeEnd,
    Color? batteryStart,
    Color? batteryEnd,
  }) {
    return StatusColors(
      normal: normal ?? this.normal,
      caution: caution ?? this.caution,
      warning: warning ?? this.warning,
      critical: critical ?? this.critical,
      heatExtreme: heatExtreme ?? this.heatExtreme,
      connConnected: connConnected ?? this.connConnected,
      connConnecting: connConnecting ?? this.connConnecting,
      connScanning: connScanning ?? this.connScanning,
      connDisconnected: connDisconnected ?? this.connDisconnected,
      warningBg: warningBg ?? this.warningBg,
      warningText: warningText ?? this.warningText,
      tempCoolStart: tempCoolStart ?? this.tempCoolStart,
      tempCoolEnd: tempCoolEnd ?? this.tempCoolEnd,
      tempMildStart: tempMildStart ?? this.tempMildStart,
      tempMildEnd: tempMildEnd ?? this.tempMildEnd,
      tempWarmStart: tempWarmStart ?? this.tempWarmStart,
      tempWarmEnd: tempWarmEnd ?? this.tempWarmEnd,
      humidityStart: humidityStart ?? this.humidityStart,
      humidityEnd: humidityEnd ?? this.humidityEnd,
      altitudeStart: altitudeStart ?? this.altitudeStart,
      altitudeEnd: altitudeEnd ?? this.altitudeEnd,
      fallSafeStart: fallSafeStart ?? this.fallSafeStart,
      fallSafeEnd: fallSafeEnd ?? this.fallSafeEnd,
      batteryStart: batteryStart ?? this.batteryStart,
      batteryEnd: batteryEnd ?? this.batteryEnd,
    );
  }

  @override
  StatusColors lerp(StatusColors? other, double t) {
    if (other is! StatusColors) return this;
    return StatusColors(
      normal: Color.lerp(normal, other.normal, t)!,
      caution: Color.lerp(caution, other.caution, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      critical: Color.lerp(critical, other.critical, t)!,
      heatExtreme: Color.lerp(heatExtreme, other.heatExtreme, t)!,
      connConnected: Color.lerp(connConnected, other.connConnected, t)!,
      connConnecting: Color.lerp(connConnecting, other.connConnecting, t)!,
      connScanning: Color.lerp(connScanning, other.connScanning, t)!,
      connDisconnected: Color.lerp(
        connDisconnected,
        other.connDisconnected,
        t,
      )!,
      warningBg: Color.lerp(warningBg, other.warningBg, t)!,
      warningText: Color.lerp(warningText, other.warningText, t)!,
      tempCoolStart: Color.lerp(tempCoolStart, other.tempCoolStart, t)!,
      tempCoolEnd: Color.lerp(tempCoolEnd, other.tempCoolEnd, t)!,
      tempMildStart: Color.lerp(tempMildStart, other.tempMildStart, t)!,
      tempMildEnd: Color.lerp(tempMildEnd, other.tempMildEnd, t)!,
      tempWarmStart: Color.lerp(tempWarmStart, other.tempWarmStart, t)!,
      tempWarmEnd: Color.lerp(tempWarmEnd, other.tempWarmEnd, t)!,
      humidityStart: Color.lerp(humidityStart, other.humidityStart, t)!,
      humidityEnd: Color.lerp(humidityEnd, other.humidityEnd, t)!,
      altitudeStart: Color.lerp(altitudeStart, other.altitudeStart, t)!,
      altitudeEnd: Color.lerp(altitudeEnd, other.altitudeEnd, t)!,
      fallSafeStart: Color.lerp(fallSafeStart, other.fallSafeStart, t)!,
      fallSafeEnd: Color.lerp(fallSafeEnd, other.fallSafeEnd, t)!,
      batteryStart: Color.lerp(batteryStart, other.batteryStart, t)!,
      batteryEnd: Color.lerp(batteryEnd, other.batteryEnd, t)!,
    );
  }
}
