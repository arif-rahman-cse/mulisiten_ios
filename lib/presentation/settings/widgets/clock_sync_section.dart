import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';
import 'package:ms200_companion/providers/providers.dart';

class ClockSyncSection extends ConsumerStatefulWidget {
  final bool sensingActive;

  const ClockSyncSection({super.key, required this.sensingActive});

  @override
  ConsumerState<ClockSyncSection> createState() => _ClockSyncSectionState();
}

class _ClockSyncSectionState extends ConsumerState<ClockSyncSection> {
  bool _loading = false;
  bool? _syncResult;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.access_time_rounded, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.clockSync, style: Theme.of(context).textTheme.titleSmall),
                  if (_syncResult != null)
                    Text(
                      _syncResult! ? l.syncedSuccess : l.syncFailed,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: widget.sensingActive || _loading ? null : _sync,
              child: _loading
                  ? const SizedBox(
                      width: 16, height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(l.syncNow),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sync() async {
    setState(() {
      _loading = true;
      _syncResult = null;
    });
    final ok = await ref.read(deviceRepositoryProvider).syncClock();
    if (mounted) {
      setState(() {
        _loading = false;
        _syncResult = ok;
      });
    }
  }
}
