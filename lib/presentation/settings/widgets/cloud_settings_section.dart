import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ms200_companion/data/preferences/app_preferences.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';
import 'package:ms200_companion/providers/providers.dart';

class CloudSettingsSection extends ConsumerStatefulWidget {
  const CloudSettingsSection({super.key});

  @override
  ConsumerState<CloudSettingsSection> createState() =>
      _CloudSettingsSectionState();
}

class _CloudSettingsSectionState extends ConsumerState<CloudSettingsSection> {
  late TextEditingController _keyCtrl;
  bool _obscure = true;

  static const _intervals = [5, 10, 15, 30, 60, 120, 300];

  @override
  void initState() {
    super.initState();
    final prefs = ref.read(appPreferencesProvider);
    _keyCtrl = TextEditingController(text: prefs.cloudApiKey);
    _keyCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _keyCtrl.dispose();
    super.dispose();
  }

  void _setKey(AppPreferences prefs) {
    final key = _keyCtrl.text.trim();
    prefs.cloudApiKey = key;
    ref.read(apiServiceProvider).updateConfig(apiKey: key);
    setState(() {});
  }

  void _clearKey(AppPreferences prefs) {
    prefs.cloudApiKey = '';
    prefs.realtimeUploadEnabled = false;
    ref.read(apiServiceProvider).updateConfig(apiKey: '');
    _keyCtrl.clear();
    // listener calls setState
  }

  void _onUploadToggled(
    bool enabled,
    AppPreferences prefs,
    AppLocalizations l,
  ) {
    if (!enabled) {
      setState(() => prefs.realtimeUploadEnabled = false);
      return;
    }

    if (prefs.cloudUploadConsented) {
      setState(() => prefs.realtimeUploadEnabled = true);
      return;
    }

    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.cloudConsentTitle),
        content: SingleChildScrollView(child: Text(l.cloudConsentMessage)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l.cloudConsentDecline),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l.cloudConsentAgree),
          ),
        ],
      ),
    ).then((accepted) {
      if (accepted == true) {
        setState(() {
          prefs.cloudUploadConsented = true;
          prefs.realtimeUploadEnabled = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final prefs = ref.watch(appPreferencesProvider);
    final l = AppLocalizations.of(context)!;
    final hasKey = prefs.cloudApiKey.isNotEmpty;
    final fieldText = _keyCtrl.text.trim();
    final isDirty = fieldText != prefs.cloudApiKey;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _keyCtrl,
              decoration: InputDecoration(
                labelText: l.apiKey,
                isDense: true,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => setState(() => _obscure = !_obscure),
                ),
              ),
              obscureText: _obscure,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (hasKey)
                  Chip(
                    avatar: const Icon(Icons.check_circle, size: 16),
                    label: Text(l.apiKeyActive),
                    visualDensity: VisualDensity.compact,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                const Spacer(),
                OutlinedButton.icon(
                  onPressed: fieldText.isNotEmpty || hasKey
                      ? () => _clearKey(prefs)
                      : null,
                  icon: const Icon(Icons.clear, size: 16),
                  label: Text(l.clear),
                  style: OutlinedButton.styleFrom(
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                if (isDirty && fieldText.isNotEmpty) ...[
                  const SizedBox(width: 8),
                  FilledButton.icon(
                    onPressed: () => _setKey(prefs),
                    icon: const Icon(Icons.check, size: 16),
                    label: Text(l.saveBtn),
                    style: FilledButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ],
              ],
            ),
            if (hasKey) ...[
              const Divider(height: 24),
              SwitchListTile(
                title: Text(l.realtimeUpload),
                subtitle: Text(l.realtimeDesc),
                value: prefs.realtimeUploadEnabled,
                onChanged: (v) => _onUploadToggled(v, prefs, l),
                contentPadding: EdgeInsets.zero,
                secondary: const Icon(Icons.cloud_upload),
              ),
              if (prefs.realtimeUploadEnabled) ...[
                const SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  initialValue:
                      _intervals.contains(prefs.realtimeUploadIntervalSec)
                      ? prefs.realtimeUploadIntervalSec
                      : 30,
                  decoration: InputDecoration(
                    labelText: l.uploadInterval,
                    isDense: true,
                    border: const OutlineInputBorder(),
                  ),
                  items: _intervals
                      .map(
                        (s) => DropdownMenuItem(
                          value: s,
                          child: Text(
                            s >= 60 ? '${s ~/ 60} ${l.min}' : '${s}s',
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (v) {
                    if (v != null) {
                      setState(() => prefs.realtimeUploadIntervalSec = v);
                    }
                  },
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
