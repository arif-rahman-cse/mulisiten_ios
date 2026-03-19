# Theme Centralization & Improvement

## Phase 1 — Foundation
- [x] Add status/connection color constants to [app_colors.dart](file:///Users/kodensya/Project/ms200_companion/lib/core/theme/app_colors.dart)
- [x] Create [status_colors.dart](file:///Users/kodensya/Project/ms200_companion/lib/core/theme/status_colors.dart) ThemeExtension
- [x] Rewrite [app_theme.dart](file:///Users/kodensya/Project/ms200_companion/lib/core/theme/app_theme.dart) to use [AppColors](file:///Users/kodensya/Project/ms200_companion/lib/core/theme/app_colors.dart#3-131) schemes + [StatusColors](file:///Users/kodensya/Project/ms200_companion/lib/core/theme/status_colors.dart#7-155) extension + component themes

## Phase 2 — Wire Theme Into App
- [x] Update [app.dart](file:///Users/kodensya/Project/ms200_companion/lib/app.dart) to add `darkTheme` + `themeMode`

## Phase 3 — Refactor Widgets
- [x] [connection_status_chip.dart](file:///Users/kodensya/Project/ms200_companion/lib/presentation/common/connection_status_chip.dart) — use [StatusColors](file:///Users/kodensya/Project/ms200_companion/lib/core/theme/status_colors.dart#7-155)
- [x] [compact_info_row.dart](file:///Users/kodensya/Project/ms200_companion/lib/presentation/home/widgets/compact_info_row.dart) — use [StatusColors](file:///Users/kodensya/Project/ms200_companion/lib/core/theme/status_colors.dart#7-155) + `colorScheme`
- [x] [heart_rate_card.dart](file:///Users/kodensya/Project/ms200_companion/lib/presentation/home/widgets/heart_rate_card.dart) — use [StatusColors](file:///Users/kodensya/Project/ms200_companion/lib/core/theme/status_colors.dart#7-155)
- [x] [temp_humidity_grid.dart](file:///Users/kodensya/Project/ms200_companion/lib/presentation/home/widgets/temp_humidity_grid.dart) — use [StatusColors](file:///Users/kodensya/Project/ms200_companion/lib/core/theme/status_colors.dart#7-155) + `colorScheme`
- [x] [fall_alert_overlay.dart](file:///Users/kodensya/Project/ms200_companion/lib/presentation/home/widgets/fall_alert_overlay.dart) — use [StatusColors](file:///Users/kodensya/Project/ms200_companion/lib/core/theme/status_colors.dart#7-155) + `colorScheme`
- [x] [ppi_chart.dart](file:///Users/kodensya/Project/ms200_companion/lib/presentation/home/widgets/ppi_chart.dart) — replace `Colors.grey`
- [x] [home_screen.dart](file:///Users/kodensya/Project/ms200_companion/lib/presentation/home/home_screen.dart) — replace `Colors.grey` variants
- [x] [settings_screen.dart](file:///Users/kodensya/Project/ms200_companion/lib/presentation/settings/settings_screen.dart) — replace hardcoded background
- [x] [user_profile_section.dart](file:///Users/kodensya/Project/ms200_companion/lib/presentation/settings/widgets/user_profile_section.dart) — remove 8 private color constants
- [x] [local_db_section.dart](file:///Users/kodensya/Project/ms200_companion/lib/presentation/settings/widgets/local_db_section.dart) — replace `Colors.red`
- [x] [system_settings_section.dart](file:///Users/kodensya/Project/ms200_companion/lib/presentation/settings/widgets/system_settings_section.dart) — replace `Colors.orange`
- [x] [scan_screen.dart](file:///Users/kodensya/Project/ms200_companion/lib/presentation/scan/scan_screen.dart) — replace `Colors.grey` variants
- [x] [db_debug_screen.dart](file:///Users/kodensya/Project/ms200_companion/lib/presentation/settings/db_debug_screen.dart) — replace `Colors.red`

## Verification
- [x] `flutter analyze` passes (0 errors, 3 pre-existing info hints)
- [x] `flutter test` passes (17/17)
- [x] Grep audit — zero hardcoded `Colors.`/[Color(0x](file:///Users/kodensya/Project/ms200_companion/lib/core/theme/app_colors.dart#3-131) in `lib/presentation/`
