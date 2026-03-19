import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';
import 'package:ms200_companion/providers/providers.dart';

class LocalDbSection extends ConsumerStatefulWidget {
  const LocalDbSection({super.key});

  @override
  ConsumerState<LocalDbSection> createState() => _LocalDbSectionState();
}

class _LocalDbSectionState extends ConsumerState<LocalDbSection> {
  @override
  Widget build(BuildContext context) {
    final prefs = ref.watch(appPreferencesProvider);
    final l = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text(l.localDatabase, style: Theme.of(context).textTheme.titleSmall),
            //const SizedBox(height: 8),
            SwitchListTile(
              title: Text(l.saveToLocalDb),
              subtitle: Text(l.saveDesc),
              value: prefs.localDbEnabled,
              onChanged: (v) => setState(() => prefs.localDbEnabled = v),
              contentPadding: EdgeInsets.zero,
              secondary: Icon(Icons.storage_outlined),
            ),
            // const SizedBox(height: 4),
            // if (kDebugMode)
            //   OutlinedButton.icon(
            //     onPressed: () => context.push('/db-debug'),
            //     icon: const Icon(Icons.storage),
            //     label: Text(l.viewDb),
            //   ),
            // if (kDebugMode) const SizedBox(height: 4),
            // OutlinedButton.icon(
            //   onPressed: () => _clearDb(context),
            //   icon: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.error),
            //   label: Text(l.clearDatabase,
            //       style: TextStyle(color: Theme.of(context).colorScheme.error)),
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> _clearDb(BuildContext context) async {
    final l = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.clearDbTitle),
        content: Text(l.clearDbMessage),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l.cancel)),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
            child: Text(l.clear),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      final db = ref.read(appDatabaseProvider);
      await db.deleteAllSensingData();
      await db.deleteAllFallEvents();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l.databaseCleared)),
        );
      }
    }
  }
}
