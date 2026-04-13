import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ms200_companion/domain/model/connection_state.dart';
import 'package:ms200_companion/domain/model/sensing_data.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';
import 'package:ms200_companion/presentation/common/battery_indicator.dart';
import 'package:ms200_companion/presentation/common/profile_avatar.dart';
import 'package:ms200_companion/presentation/common/sensing_fab.dart';
import 'package:ms200_companion/presentation/home/widgets/daily_activity_card.dart';
import 'package:ms200_companion/presentation/home/widgets/heart_rate_card.dart';
import 'package:ms200_companion/presentation/home/widgets/altitude_fall_grid.dart';
import 'package:ms200_companion/presentation/home/widgets/temp_humidity_grid.dart';
import 'package:ms200_companion/providers/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connState =
        ref.watch(connectionStateProvider).value ??
        BleConnectionState.disconnected;
    final sensingAsync = ref.watch(sensingDataStreamProvider);
    final data = sensingAsync.value;
    final prefs = ref.watch(appPreferencesProvider);
    ref.watch(profileIdentityRevisionProvider);
    final fallService = ref.watch(fallDetectionServiceProvider);
    final l = AppLocalizations.of(context)!;

    ref.listen(sensingDataStreamProvider, (_, next) {
      final sensingData = next.value;
      if (sensingData != null) {
        fallService.onSensingData(sensingData);
      }
    });

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 52,
        leading: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: ProfileAvatar(userName: prefs.userName, radius: 18),
          ),
        ),

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l.appTitle,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          if (data != null && connState != BleConnectionState.disconnected)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: BatteryIndicator(level: data.batteryLevel),
            ),
        ],
        centerTitle: false,
      ),
      body:
          connState == BleConnectionState.disconnected && !prefs.hasPairedDevice
          ? _NoPairedDeviceView(onScan: () => context.push('/scan'))
          : _DashboardView(data: data),
      floatingActionButton: connState.isConnected
          ? const Padding(
              padding: EdgeInsets.only(bottom: 90.0),
              child: SensingFab(),
            )
          : null,
    );
  }
}

class _NoPairedDeviceView extends StatelessWidget {
  final VoidCallback onScan;
  const _NoPairedDeviceView({required this.onScan});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Add cicrcle bg with gredient color
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.colorScheme.primaryContainer,
              // gradient: LinearGradient(
              //   begin: Alignment.topLeft,
              //   end: Alignment.bottomRight,
              //   colors: [
              //     Color(0xFF1A1A6C), // deep blue
              //     Color(0xFF5B2C83), // purple
              //     Color(0xFFD7263D), // reddish pink
              //     Color(0xFFF49D37), // warm orangewatch
              //   ],
              //   stops: [0.0, 0.35, 0.7, 1.0],
              // ),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/icons/toshiba_band.png',
                width: 128,
                height: 128,
              ),
            ),
          ),
          // Icon(
          //   Icons.watch,
          //   size: 128,
          //   color: Theme.of(context).colorScheme.onSurfaceVariant,
          // ),
          const SizedBox(height: 16),
          Text(
            l.noDevicePaired,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l.scanHint,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: onScan,
            icon: const Icon(Icons.bluetooth_searching),
            label: Text(l.scanForDevices),
          ),
        ],
      ),
    );
  }
}

class _DashboardView extends ConsumerWidget {
  final SensingData? data;
  const _DashboardView({this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityState = ref.watch(dailyActivityProvider);

    return ListView(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 120),
      children: [
        if (activityState.isVisible) ...[
          DailyActivityCard(
            state: activityState,
            onRetry: () => ref.read(dailyActivityProvider.notifier).load(),
          ),
          const SizedBox(height: 8),
        ],
        HeartRateCard(data: data),
        const SizedBox(height: 8),
        TempHumidityGrid(data: data),
        const SizedBox(height: 8),
        AltitudeFallGrid(data: data),
        const SizedBox(height: 8),
        //PpiChart(latestData: data),
      ],
    );
  }
}
