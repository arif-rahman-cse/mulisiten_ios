import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ms200_companion/domain/model/connection_state.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';
import 'package:ms200_companion/presentation/common/connection_status_chip.dart';
import 'package:ms200_companion/providers/providers.dart';

class DeviceConnectionSection extends ConsumerWidget {
  const DeviceConnectionSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connState =
        ref.watch(connectionStateProvider).value ??
        BleConnectionState.disconnected;
    final prefs = ref.watch(appPreferencesProvider);
    final l = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.watch,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prefs.pairedDeviceName.isNotEmpty
                            ? prefs.pairedDeviceName
                            : l.noDevice,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                ConnectionStatusChip(state: connState),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (!connState.isConnected)
                  FilledButton.icon(
                    onPressed: () => context.push('/scan'),
                    icon: const Icon(Icons.bluetooth_searching),
                    label: Text(l.scanConnect),
                  ),
                if (connState.isConnected) ...[
                  OutlinedButton.icon(
                    onPressed: () async {
                      await ref.read(bleManagerProvider).disconnect();
                      prefs.clearPairedDevice();
                    },
                    icon: const Icon(Icons.bluetooth_disabled),
                    label: Text(l.disconnect),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
