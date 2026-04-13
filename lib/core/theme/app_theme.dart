import 'package:flutter/material.dart';
import 'package:ms200_companion/core/theme/app_colors.dart';
import 'package:ms200_companion/core/theme/status_colors.dart';

class AppTheme {
  AppTheme._();

  // ── Light ──────────────────────────────────────────────────

  static ThemeData get lightTheme => _build(
    colorScheme: AppColors.lightScheme,
    statusColors: StatusColors.light(),
  );

  // ── Dark ───────────────────────────────────────────────────

  static ThemeData get darkTheme => _build(
    colorScheme: AppColors.darkScheme,
    statusColors: StatusColors.dark(),
  );

  // ── Shared builder ─────────────────────────────────────────

  static ThemeData _build({
    required ColorScheme colorScheme,
    required StatusColors statusColors,
  }) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,

      // ── Extensions ─────────────────────────────────────────
      extensions: <ThemeExtension>[statusColors],

      // ── AppBar ─────────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),

      // ── Scaffold ───────────────────────────────────────────
      scaffoldBackgroundColor: colorScheme.surfaceContainerLowest,

      // ── NavigationBar ──────────────────────────────────────
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: colorScheme.primaryContainer,
        backgroundColor: colorScheme.surfaceContainerHigh,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,

        //indicatorShape: CircleBorder(),
        //Add icon color to the navigation bar
        iconTheme: WidgetStateProperty.all(
          IconThemeData(color: colorScheme.primary),
        ),

        //overlayColor: WidgetStateProperty.all(colorScheme.tertiary),
        //labelTextStyle: WidgetStateProperty.all(TextStyle(color: colorScheme.primary)),
      ),

      // ── Card ───────────────────────────────────────────────
      cardTheme: CardThemeData(
        elevation: 2,
        shadowColor: colorScheme.shadow.withValues(alpha: 0.3),
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
          //side: BorderSide(color: colorScheme.outline, width: 0.5),
        ),
      ),

      // ── ListTile (list items, e.g. in ListView) ────────────
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        tileColor: colorScheme.surface,
      ),

      // ── FAB ────────────────────────────────────────────────
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),

      // ── Input decoration ───────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerLow,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant),
        helperStyle: TextStyle(
          color: colorScheme.onSurfaceVariant,
          fontSize: 11,
        ),
        errorStyle: TextStyle(color: colorScheme.error, fontSize: 10),
      ),

      // ── Chip ───────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        labelStyle: TextStyle(color: colorScheme.onSurface, fontSize: 12),
        side: BorderSide(color: colorScheme.outlineVariant),
      ),

      // ── Divider ────────────────────────────────────────────
      dividerTheme: DividerThemeData(color: colorScheme.outlineVariant),

      // ── Switch / SwitchListTile ─────────────────────────────
      // OFF: track fill vs outline must contrast (default M3 often blends
      // surfaceContainerHighest with outline on light blue-gray schemes).
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.onPrimary;
          }
          if (states.contains(WidgetState.disabled)) {
            return colorScheme.onSurface.withValues(alpha: 0.38);
          }
          return colorScheme.onSurfaceVariant;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          if (states.contains(WidgetState.disabled)) {
            return colorScheme.onSurface.withValues(alpha: 0.12);
          }
          // Interior: mid surface so it reads clearly inside the outline
          return colorScheme.surfaceContainer;
        }),
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.transparent;
          }
          if (states.contains(WidgetState.disabled)) {
            return colorScheme.onSurface.withValues(alpha: 0.12);
          }
          // Darker rim than track fill for clear OFF silhouette
          return colorScheme.onSurfaceVariant;
        }),
        trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return 0.0;
          }
          return 1.5;
        }),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary.withValues(alpha: 0.12);
          }
          return colorScheme.onSurfaceVariant.withValues(alpha: 0.08);
        }),
      ),

      // ── Slider (Material 3 track, thumb, discrete value label) ─
      sliderTheme: SliderThemeData(trackHeight: 10),
    );
  }
}
