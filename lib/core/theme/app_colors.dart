import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Brand anchor (never use directly in widgets) ──────────
  static const Color brand = Color(0xFF014898);

  // ── Semantic extras (access via AppColors.successLight etc) ─
  static const Color successLight       = Color(0xFF16A34A);
  static const Color successContainerLight = Color(0xFFE7F5EE);
  static const Color successDark        = Color(0xFF4ADE80);
  static const Color successContainerDark  = Color(0xFF0F2E1E);

  static const Color warningLight       = Color(0xFFD97706);
  static const Color warningContainerLight = Color(0xFFFEF3E0);
  static const Color warningDark        = Color(0xFFFBBF24);
  static const Color warningContainerDark  = Color(0xFF2B1E06);

  // ── Status levels (health monitoring) ─────────────────────
  static const Color statusGreen   = Color(0xFF4CAF50); // level 0 — Normal
  static const Color statusYellow  = Color(0xFFFFC107); // level 1 — Caution
  static const Color statusOrange  = Color(0xFFFF9800); // level 2 — Warning
  static const Color statusRed     = Color(0xFFF44336); // level 3 — Critical
  static const Color statusDarkRed = Color(0xFFB71C1C); // heat index 4

  // ── Sensor gradients ───────────────────────────────────────
  static const Color tempCoolStart = Color(0xFFBBDEFB); // Colors.blue.shade100
  static const Color tempCoolEnd   = Color(0xFF64B5F6); // Colors.blue.shade300
  static const Color tempMildStart = Color(0xFFC8E6C9); // Colors.green.shade100
  static const Color tempMildEnd   = Color(0xFF81C784); // Colors.green.shade300
  static const Color tempWarmStart = Color(0xFFFFE0B2); // Colors.orange.shade100
  static const Color tempWarmEnd   = Color(0xFFFFB74D); // Colors.orange.shade300
  static const Color humidityStart = Color(0xFFB2EBF2); // Colors.cyan.shade100
  static const Color humidityEnd   = Color(0xFF64B5F6); // Colors.blue.shade300

  // ── Connection states ─────────────────────────────────────
  static const Color connectionConnected    = Color(0xFF4CAF50);
  static const Color connectionConnecting   = Color(0xFFFF9800);
  static const Color connectionScanning     = Color(0xFF1976D2);
  static const Color connectionDisconnected = Color(0xFF9E9E9E);

  // ── Light ColorScheme ─────────────────────────────────────
  static const ColorScheme lightScheme = ColorScheme(
    brightness:               Brightness.light,

    // Primary — brand blue
    primary:                  Color(0xFF0558B4),
    onPrimary:                Color(0xFFFFFFFF),
    primaryContainer:         Color(0xFFE8F0FA),
    onPrimaryContainer:       Color(0xFF014898),

    // Secondary — teal (cardio / HR)
    secondary:                Color(0xFF0D9488),
    onSecondary:              Color(0xFFFFFFFF),
    secondaryContainer:       Color(0xFFE0F4F3),
    onSecondaryContainer:     Color(0xFF065F56),

    // Tertiary — orange (calories / energy)
    tertiary:                 Color(0xFFF97316),
    onTertiary:               Color(0xFFFFFFFF),
    tertiaryContainer:        Color(0xFFFEF0E6),
    onTertiaryContainer:      Color(0xFFC2500A),

    // Error
    error:                    Color(0xFFDC2626),
    onError:                  Color(0xFFFFFFFF),
    errorContainer:           Color(0xFFFEE8E8),
    onErrorContainer:         Color(0xFF991B1B),

    // Surfaces (replaces deprecated background / surfaceVariant)
    surface:                  Color(0xFFFFFFFF),  // cards, dialogs
    onSurface:                Color(0xFF1A2536),  // primary text
    surfaceContainerLowest:   Color(0xFFF2F2F7),  // scaffold / page bg #F2F2F7
    surfaceContainerLow:      Color(0xFFEDF1F6),  // list alt rows
    surfaceContainer:         Color(0xFFE8EEF5),  // input fields
    surfaceContainerHigh:     Color(0xFFDDE5EF),  // bottom nav bg
    surfaceContainerHighest:  Color(0xFFD0DAE8),  // chips, dividers
    onSurfaceVariant:         Color(0xFF5F6B7A),  // labels, captions
    outline:                  Color(0xFFC4D0DE),  // input borders
    outlineVariant:           Color(0xFFDDE5EF),  // dividers

    // Inverse (snackbars, tooltips)
    inverseSurface:           Color(0xFF1A2536),
    onInverseSurface:         Color(0xFFEDF1F6),
    inversePrimary:           Color(0xFF93C5FD),

    scrim:                    Color(0xFF000000),
    shadow:                   Color(0xFF000000),
  );

  // ── Dark ColorScheme ──────────────────────────────────────
  static const ColorScheme darkScheme = ColorScheme(
    brightness:               Brightness.dark,

    // Primary
    primary:                  Color(0xFF3B82C4),
    onPrimary:                Color(0xFFFFFFFF),
    primaryContainer:         Color(0xFF122843),
    onPrimaryContainer:       Color(0xFF93C5FD),

    // Secondary — teal
    secondary:                Color(0xFF2DD4BF),
    onSecondary:              Color(0xFF003733),
    secondaryContainer:       Color(0xFF065F56),
    onSecondaryContainer:     Color(0xFF99F6E4),

    // Tertiary — orange
    tertiary:                 Color(0xFFFB923C),
    onTertiary:               Color(0xFF4A1A00),
    tertiaryContainer:        Color(0xFF7C3210),
    onTertiaryContainer:      Color(0xFFFFD8B4),

    // Error
    error:                    Color(0xFFF87171),
    onError:                  Color(0xFF5C0A0A),
    errorContainer:           Color(0xFF2B0E0E),
    onErrorContainer:         Color(0xFFFCA5A5),

    // Surfaces
    surface:                  Color(0xFF0D1B2E),  // cards, dialogs
    onSurface:                Color(0xFFE2EAF3),  // primary text
    surfaceContainerLowest:   Color(0xFF0A1624),  // scaffold / page bg
    surfaceContainerLow:      Color(0xFF112236),  // list alt rows
    surfaceContainer:         Color(0xFF152840),  // input fields
    surfaceContainerHigh:     Color(0xFF1A3250),  // bottom nav bg
    surfaceContainerHighest:  Color(0xFF1C3353),  // chips, dividers
    onSurfaceVariant:         Color(0xFF6B8BA8),  // labels, captions
    outline:                  Color(0xFF1C3353),  // input borders
    outlineVariant:           Color(0xFF152840),  // dividers

    // Inverse
    inverseSurface:           Color(0xFFE2EAF3),
    onInverseSurface:         Color(0xFF1A2536),
    inversePrimary:           Color(0xFF0558B4),

    scrim:                    Color(0xFF000000),
    shadow:                   Color(0xFF000000),
  );
}