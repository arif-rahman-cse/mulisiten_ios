import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ms200_companion/domain/model/connection_state.dart';
import 'package:ms200_companion/domain/model/sensing_data.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';
import 'package:ms200_companion/presentation/common/connection_status_chip.dart';
import 'package:ms200_companion/presentation/common/sensing_fab.dart';
import 'package:ms200_companion/presentation/home/widgets/compact_info_row.dart';
import 'package:ms200_companion/presentation/home/widgets/fall_alert_overlay.dart';
import 'package:ms200_companion/presentation/home/widgets/heart_rate_card.dart';
import 'package:ms200_companion/presentation/home/widgets/ppi_chart.dart';
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
    final fallService = ref.watch(fallDetectionServiceProvider);
    final l = AppLocalizations.of(context)!;

    ref.listen(sensingDataStreamProvider, (_, next) {
      final sensingData = next.value;
      if (sensingData != null) {
        fallService.onSensingData(sensingData);
      }
    });

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              l.appTitle,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ConnectionStatusChip(state: connState),
              ),
            ],
            centerTitle: false,
          ),
          body:
              connState == BleConnectionState.disconnected &&
                  !prefs.hasPairedDevice
              ? _NoPairedDeviceView(onScan: () => context.push('/scan'))
              : _DashboardView(data: data),
          floatingActionButton: connState.isConnected
              ? const SensingFab()
              : null,
        ),
        if (fallService.alertActive)
          FallAlertOverlay(
            onDismiss: () => fallService.dismissAlert(),
            onEmergency: () {
              fallService.dismissAlert();
            },
          ),
      ],
    );
  }
}

class _NoPairedDeviceView extends StatelessWidget {
  final VoidCallback onScan;
  const _NoPairedDeviceView({required this.onScan});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.watch,
            size: 80,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
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

class _DashboardView extends StatelessWidget {
  final SensingData? data;
  const _DashboardView({this.data});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        HeartRateCard(data: data),
        const SizedBox(height: 8),
        TempHumidityGrid(data: data),
        const SizedBox(height: 8),
        CompactInfoRow(data: data),
        const SizedBox(height: 8),
        PpiChart(latestData: data),
      ],
    );
  }
}
