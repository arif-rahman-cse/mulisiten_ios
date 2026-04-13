import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ms200_companion/domain/model/connection_state.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';
import 'package:ms200_companion/presentation/common/app_snackbar.dart';
import 'package:ms200_companion/core/theme/status_colors.dart';
import 'package:ms200_companion/providers/providers.dart';

class DeviceConnectionSection extends ConsumerStatefulWidget {
  const DeviceConnectionSection({super.key});

  @override
  ConsumerState<DeviceConnectionSection> createState() =>
      _DeviceConnectionSectionState();
}

class _DeviceConnectionSectionState
    extends ConsumerState<DeviceConnectionSection> {
  bool _disconnecting = false;

  Future<void> _confirmDisconnect() async {
    final l = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(ctx).colorScheme.surface,
        icon: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Theme.of(ctx).colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Image.asset(
            'assets/icons/toshiba_band.png',
            width: 48,
            height: 48,
          ),
        ),
        title: Text(
          l.disconnectDialogTitle,
          style: Theme.of(ctx).textTheme.titleMedium,
        ),
        content: Text(l.disconnectDialogMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
            ),
            child: Text(l.disconnect),
          ),
        ],
      ),
    );

    if (confirm != true || !mounted) return;

    setState(() => _disconnecting = true);
    try {
      await ref.read(bleManagerProvider).disconnect();
      ref.read(appPreferencesProvider).clearPairedDevice();
    } catch (_) {
      if (mounted) {
        showAppSnackBar(context, message: l.disconnectFailed, isError: true);
      }
    } finally {
      if (mounted) setState(() => _disconnecting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final connState =
        ref.watch(connectionStateProvider).value ??
        BleConnectionState.disconnected;
    final prefs = ref.watch(appPreferencesProvider);
    final l = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final sc = theme.extension<StatusColors>()!;

    final (statusLabel, statusColor) = switch (connState) {
      BleConnectionState.connected => (l.connected, sc.connConnected),
      BleConnectionState.connecting => (l.connecting, sc.connConnecting),
      BleConnectionState.scanning => (l.scanning, sc.connScanning),
      BleConnectionState.disconnected => (l.disconnected, sc.connDisconnected),
    };

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/icons/toshiba_band.png',
                    width: 32,
                    height: 32,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.colorScheme.surface,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
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
                    style: theme.textTheme.titleMedium,
                  ),
                  Text(
                    statusLabel,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (!connState.isConnected)
              FilledButton(
                onPressed: () => context.push('/scan'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: Text(l.scanConnect),
              )
            else
              OutlinedButton(
                onPressed: _disconnecting ? null : _confirmDisconnect,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: _disconnecting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l.disconnect),
              ),
          ],
        ),
      ),
    );
  }
}
