import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:ms200_companion/core/theme/app_theme.dart';
import 'package:ms200_companion/presentation/home/home_screen.dart';
import 'package:ms200_companion/presentation/scan/scan_screen.dart';
import 'package:ms200_companion/presentation/settings/db_debug_screen.dart';
import 'package:ms200_companion/presentation/settings/settings_screen.dart';

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

class Ms200App extends StatelessWidget {
  const Ms200App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MS200 Companion',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      locale: const Locale('ja'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ja'), Locale('en')],
    );
  }
}

class _ScaffoldWithNav extends StatelessWidget {
  final Widget child;
  const _ScaffoldWithNav({required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final selectedIndex = location.startsWith('/settings') ? 1 : 0;
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              context.go('/home');
            // case 1:
            //   context.go('/analytics');
            case 1:
              context.go('/settings');
          }
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: l.home,
          ),
          // NavigationDestination(
          //   icon: const Icon(Icons.insert_chart),
          //   selectedIcon: const Icon(Icons.insert_chart),
          //   label: l.analytics,
          // ),
          NavigationDestination(
            icon: const Icon(Icons.settings),
            selectedIcon: const Icon(Icons.settings),
            label: l.settings,
          ),
        ],
      ),
    );
  }
}
