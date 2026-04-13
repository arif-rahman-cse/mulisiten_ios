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
  //late TextEditingController _urlCtrl;
  //late TextEditingController _keyCtrl;

  static const _intervals = [5, 10, 15, 30, 60, 120, 300];

  @override
  void initState() {
    super.initState();
    //final prefs = ref.read(appPreferencesProvider);
    //_urlCtrl = TextEditingController(text: prefs.cloudApiUrl);
    //_keyCtrl = TextEditingController(text: prefs.cloudApiKey);
  }

  @override
  void dispose() {
    //_urlCtrl.dispose();
    //_keyCtrl.dispose();
    super.dispose();
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

    // If user already consented, just enable.
    if (prefs.cloudUploadConsented) {
      setState(() => prefs.realtimeUploadEnabled = true);
      return;
    }

    // Show consent dialog for the first time.
    showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.cloudConsentTitle),
        content: SingleChildScrollView(
          child: Text(l.cloudConsentMessage),
        ),
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

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text(l.cloudUpload, style: Theme.of(context).textTheme.titleSmall),
            // const SizedBox(height: 12),
            // SwitchListTile(
            //   title: Text(l.bufferToCloud),
            //   subtitle: Text(l.bufferDesc),
            //   value: prefs.cloudBufferEnabled,
            //   onChanged: (v) => setState(() => prefs.cloudBufferEnabled = v),
            //   contentPadding: EdgeInsets.zero,
            //   secondary: Icon(Icons.cloud),
            // ),
            // const Divider(height: 0),
            SwitchListTile(
              title: Text(l.realtimeUpload),
              subtitle: Text(l.realtimeDesc),
              value: prefs.realtimeUploadEnabled,
              onChanged: (v) => _onUploadToggled(v, prefs, l),
              contentPadding: EdgeInsets.zero,
              secondary: Icon(Icons.cloud_upload),
            ),
            const SizedBox(height: 8),
            if (prefs.realtimeUploadEnabled) ...[
              const SizedBox(height: 4),
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
                        child: Text(s >= 60 ? '${s ~/ 60} ${l.min}' : '${s}s'),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    setState(() => prefs.realtimeUploadIntervalSec = v);
                  }
                },
              ),
              //const SizedBox(height: 12),
            ],
            // TextField(
            //   controller: _urlCtrl,
            //   decoration: InputDecoration(
            //     labelText: l.apiBaseUrl,
            //     isDense: true,
            //     border: const OutlineInputBorder(),
            //   ),
            //   onChanged: (v) => prefs.cloudApiUrl = v,
            // ),
            // const SizedBox(height: 8),
            // TextField(
            //   controller: _keyCtrl,
            //   decoration: InputDecoration(
            //     labelText: l.apiKey,
            //     isDense: true,
            //     border: const OutlineInputBorder(),
            //   ),
            //   obscureText: true,
            //   onChanged: (v) => prefs.cloudApiKey = v,
            // ),
          ],
        ),
      ),
    );
  }
}
