import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';
import 'package:ms200_companion/providers/providers.dart';

class NameInputDialog extends ConsumerStatefulWidget {
  const NameInputDialog({super.key});

  @override
  ConsumerState<NameInputDialog> createState() => _NameInputDialogState();
}

class _NameInputDialogState extends ConsumerState<NameInputDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveName() {
    final name = _controller.text.trim();
    if (name.isNotEmpty) {
      final prefs = ref.read(appPreferencesProvider);
      prefs.userName = name;
      context.pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(l.enterNameTitle),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: InputDecoration(
          hintText: l.nameHint,
          border: const OutlineInputBorder(),
        ),
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => _saveName(),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(l.cancelBtn), // Wait, let's use the actual cancel/save keys we define
        ),
        FilledButton(
          onPressed: _saveName,
          child: Text(l.saveBtn),
        ),
      ],
    );
  }
}
