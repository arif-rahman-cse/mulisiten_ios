import 'package:flutter/material.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  Future<void> _launchPrivacyPolicy(BuildContext context) async {
    final url = Uri.parse(
      'https://arif-rahman-cse.github.io/mulisiten_privecy_policy/',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open privacy policy URL')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.info_outline_rounded, size: 20, color: cs.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l.aboutLegal,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Content
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.shield_outlined, color: cs.onSurfaceVariant),
              title: Text(l.privacyPolicy),
              trailing: Icon(
                Icons.open_in_new_rounded,
                size: 16,
                color: cs.onSurfaceVariant,
              ),
              onTap: () => _launchPrivacyPolicy(context),
            ),
          ],
        ),
      ),
    );
  }
}
