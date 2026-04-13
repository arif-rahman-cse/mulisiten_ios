import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ms200_companion/domain/model/connection_state.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';
import 'package:ms200_companion/providers/providers.dart';

class SensingFab extends ConsumerStatefulWidget {
  const SensingFab({super.key});

  @override
  ConsumerState<SensingFab> createState() => _SensingFabState();
}

class _SensingFabState extends ConsumerState<SensingFab> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final connState = ref.watch(connectionStateProvider);
    final isConnected =
        connState.value == BleConnectionState.connected;
    ref.watch(sensingActiveRevisionProvider);
    final prefs = ref.watch(appPreferencesProvider);
    final isSensing = prefs.sensingActive;
    final l = AppLocalizations.of(context)!;

    return FloatingActionButton.extended(
      onPressed: (!isConnected || _loading) ? null : () => _toggle(isSensing),
      icon: _loading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(isSensing ? Icons.stop : Icons.play_arrow),
      label: Text(isSensing ? l.stop : l.start),
      backgroundColor: isSensing
          ? Theme.of(context).colorScheme.error
          : null,
      foregroundColor: isSensing
          ? Theme.of(context).colorScheme.onError
          : null,
    );
  }

  Future<void> _toggle(bool currentlySensing) async {
    if (!currentlySensing) {
      // Show location rationale before the first native permission prompt.
      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        final l = AppLocalizations.of(context)!;
        final proceed = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(l.locationRationaleTitle),
            content: SingleChildScrollView(
              child: Text(l.locationRationaleMessage),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(l.locationRationaleContinue),
              ),
            ],
          ),
        );
        if (proceed != true) return;
      }
    }

    setState(() => _loading = true);
    final repo = ref.read(sensingRepositoryProvider);
    if (currentlySensing) {
      await repo.stopRealtimeSensing();
    } else {
      await repo.startRealtimeSensing();
    }
    if (mounted) setState(() => _loading = false);
  }
}
