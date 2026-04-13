import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:native_glass_navbar/native_glass_navbar.dart';
import 'package:ms200_companion/core/theme/app_theme.dart';
import 'package:ms200_companion/presentation/home/home_screen.dart';
import 'package:ms200_companion/presentation/home/widgets/fall_alert_overlay.dart';
import 'package:ms200_companion/presentation/scan/scan_screen.dart';
import 'package:ms200_companion/presentation/settings/db_debug_screen.dart';
import 'package:ms200_companion/presentation/settings/settings_screen.dart';
import 'package:ms200_companion/providers/providers.dart';
import 'package:ms200_companion/presentation/history/history_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => _ScaffoldWithNav(child: child),
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomeScreen()),
        ),
        GoRoute(
          path: '/history',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HistoryScreen()),
        ),
        GoRoute(
          path: '/settings',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SettingsScreen()),
        ),
      ],
    ),
    GoRoute(
      path: '/scan',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ScanScreen(),
    ),
    GoRoute(
      path: '/db-debug',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const DbDebugScreen(),
    ),
  ],
);

class Ms200App extends ConsumerWidget {
  const Ms200App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Eagerly activate auto-reconnect and auto-resume sensing on app startup
    ref.watch(appBootstrapProvider);

    final fallService = ref.watch(fallDetectionServiceProvider);

    return MaterialApp.router(
      title: 'MS200 Companion',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      //locale: const Locale('ja'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ja'), Locale('en')],
      builder: (context, child) {
        return ListenableBuilder(
          listenable: fallService,
          builder: (context, _) {
            return Stack(
              children: [
                child!,
                if (fallService.alertActive)
                  FallAlertOverlay(
                    onDismiss: () {
                      fallService.dismissAlert();
                    },
                    onEmergency: () {
                      fallService.dismissAlert();
                      // TODO: Trigger emergency call
                    },
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

class _ScaffoldWithNav extends StatelessWidget {
  final Widget child;
  const _ScaffoldWithNav({required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final selectedIndex = location.startsWith('/settings')
        ? 2
        : location.startsWith('/history')
        ? 1
        : 0;
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: NativeGlassNavBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
            case 1:
              context.go('/history');
            case 2:
              context.go('/settings');
          }
        },
        tabs: [
          NativeGlassNavBarItem(label: l.home, symbol: 'house'),
          NativeGlassNavBarItem(label: l.history, symbol: 'chart.bar'),
          NativeGlassNavBarItem(label: l.settings, symbol: 'gear'),
        ],
        fallback: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            switch (index) {
              case 0:
                context.go('/home');
              case 1:
                context.go('/history');
              case 2:
                context.go('/settings');
            }
          },
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home),
              selectedIcon: const Icon(Icons.home),
              label: l.home,
            ),
            NavigationDestination(
              icon: const Icon(Icons.analytics),
              selectedIcon: const Icon(Icons.analytics),
              label: l.history,
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings),
              selectedIcon: const Icon(Icons.settings),
              label: l.settings,
            ),
          ],
        ),
      ),
    );
  }
}
