import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ms200_companion/domain/model/connection_state.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';
import 'package:ms200_companion/presentation/settings/widgets/clock_sync_section.dart';
import 'package:ms200_companion/presentation/settings/widgets/cloud_settings_section.dart';
import 'package:ms200_companion/presentation/settings/widgets/device_connection_section.dart';
import 'package:ms200_companion/presentation/settings/widgets/local_db_section.dart';
import 'package:ms200_companion/presentation/settings/widgets/system_settings_section.dart';
import 'package:ms200_companion/presentation/settings/widgets/user_profile_section.dart';
import 'package:ms200_companion/providers/providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connState =
        ref.watch(connectionStateProvider).value ??
        BleConnectionState.disconnected;
    final prefs = ref.watch(appPreferencesProvider);
    final sensing = prefs.sensingActive;
    final isConnected = connState.isConnected;
    final l = AppLocalizations.of(context)!;

    // Eagerly activate auto-sync of device params on connection
    ref.watch(deviceParamsSyncProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          //_SectionHeader(title: 'Device', icon: Icons.watch),
          const DeviceConnectionSection(),
          if (isConnected) ...[
            const SizedBox(height: 16),
            UserProfileSection(sensingActive: sensing),
            const SizedBox(height: 16),
            SystemSettingsSection(sensingActive: sensing),
            const SizedBox(height: 16),
            ClockSyncSection(sensingActive: sensing),
          ],
          const SizedBox(height: 16),
          _SectionHeader(title: l.appSettings, icon: Icons.settings),
          const LocalDbSection(),
          const SizedBox(height: 16),
          const CloudSettingsSection(),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
