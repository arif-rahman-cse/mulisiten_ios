import 'package:flutter/material.dart';
import 'package:ms200_companion/core/theme/status_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ms200_companion/domain/model/device_config.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';
import 'package:ms200_companion/presentation/common/app_snackbar.dart';
import 'package:ms200_companion/providers/providers.dart';

class SystemSettingsSection extends ConsumerStatefulWidget {
  final bool sensingActive;

  const SystemSettingsSection({super.key, required this.sensingActive});

  @override
  ConsumerState<SystemSettingsSection> createState() =>
      _SystemSettingsSectionState();
}

class _SystemSettingsSectionState extends ConsumerState<SystemSettingsSection> {
  // ── State (typed instead of TextEditingControllers) ─────────
  bool _ext96ms = false; // 0=OFF, 1=ON
  bool _siMode = false; // 0=PPI, 1=SI
  int _advertise = 0; // 0–3
  bool _storageMode = false; // 0=Keep, 1=Overwrite
  int _interval = 0; // 0=1s, 1=30s, 2=1min
  int _threshold = 0; // 0–4
  int _beltWarning = 3; // 3–30 minutes

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    // Auto-populate from cached preferences
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _populateFromPrefs();
    });
  }

  void _populateFromPrefs() {
    final prefs = ref.read(appPreferencesProvider);
    setState(() {
      _ext96ms = prefs.sysExt96ms != 0;
      _siMode = prefs.sysStatusIndexMode != 0;
      _advertise = prefs.sysAdvertiseSetting.clamp(0, 3);
      _storageMode = prefs.sysStorageMode != 0;
      _interval = prefs.sysDetailedDataInterval.clamp(0, 2);
      _threshold = prefs.sysNotificationThreshold.clamp(0, 4);
      _beltWarning = prefs.sysBeltWarning.clamp(3, 30);
    });
  }

  void _populate(DeviceConfig config) {
    setState(() {
      _ext96ms = config.extendedData96ms != 0;
      _siMode = config.statusIndexMode != 0;
      _advertise = config.advertiseSetting.clamp(0, 3);
      _storageMode = config.storageMode != 0;
      _interval = config.detailedDataInterval.clamp(0, 2);
      _threshold = config.sysNotificationThreshold.clamp(0, 4);
      _beltWarning = config.beltWarning.clamp(3, 30);
    });
  }

  @override
  Widget build(BuildContext context) {
    final disabled = widget.sensingActive;
    final cs = Theme.of(context).colorScheme;
    final sc = Theme.of(context).extension<StatusColors>()!;
    final l = AppLocalizations.of(context)!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header with Sync button ──────────────────────────
            Row(
              children: [
                Icon(Icons.settings_outlined, size: 20, color: cs.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l.systemSettings,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: cs.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                TextButton.icon(
                  icon: _loading
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.sync, size: 16),
                  label: Text(l.syncSystem),
                  style: TextButton.styleFrom(
                    foregroundColor: cs.primary,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                  onPressed: disabled || _loading ? null : _syncFromDevice,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ── Warning banner ──────────────────────────────────
            if (disabled)
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.only(bottom: 12),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: sc.warningBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: sc.warningText.withValues(alpha: 0.4)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.lock_outline_rounded,
                        size: 14, color: sc.warningText),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                      l.stopSensingWarning,
                        style: TextStyle(
                          color: sc.warningText,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // ── Content ─────────────────────────────────────────
            AbsorbPointer(
              absorbing: disabled,
              child: AnimatedOpacity(
                opacity:    1.0,
                duration: const Duration(milliseconds: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Switches ──────────────────────────────────
                    SwitchListTile(
                      title: Text(l.ext96msData),
                      subtitle: Text(l.ext96msDesc),
                      value: _ext96ms,
                      onChanged: disabled
                          ? null
                          : (v) => setState(() => _ext96ms = v),
                      contentPadding: EdgeInsets.zero,
                      secondary: Icon(Icons.info_outline),
                    ),
                    const Divider(height: 0),
                    SwitchListTile(
                      title: Text(l.statusIndexMode),
                      subtitle: Text(_siMode
                          ? l.siMode
                          : l.ppiMode),
                      value: _siMode,
                      onChanged: disabled
                          ? null
                          : (v) => setState(() => _siMode = v),
                      contentPadding: EdgeInsets.zero,
                      secondary: Icon(Icons.insert_chart_outlined_rounded),
                    ),
                    const Divider(height: 0),
                    SwitchListTile(
                      title: Text(l.storageMode),
                      subtitle: Text(_storageMode
                          ? l.overwriteMode
                          : l.keepRecords),
                      value: _storageMode,
                      onChanged: disabled
                          ? null
                          : (v) => setState(() => _storageMode = v),
                      contentPadding: EdgeInsets.zero,
                      secondary: Icon(Icons.sd_storage_outlined),
                    ),

                    const SizedBox(height: 12),

                    // ── Advertise Dropdown ────────────────────────
                    DropdownButtonFormField<int>(
                      initialValue: _advertise,
                      decoration: InputDecoration(
                        labelText: l.advertiseSetting,
                      ),
                      items: [
                        DropdownMenuItem(value: 0, child: Text(l.off)),
                        const DropdownMenuItem(value: 1, child: Text('Beacon 1')),
                        const DropdownMenuItem(value: 2, child: Text('Beacon 2')),
                        const DropdownMenuItem(value: 3, child: Text('Beacon 3')),
                      ],
                      onChanged: disabled
                          ? null
                          : (v) {
                              if (v != null) {
                                setState(() => _advertise = v);
                              }
                            },
                    ),

                    const SizedBox(height: 20),

                    // ── Data Sensing Interval ─────────────────────
                    Text(
                      l.dataSensingInterval,
                      style: TextStyle(
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: SegmentedButton<int>(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.resolveWith((states) {
                            return states.contains(WidgetState.selected)
                                ? cs.primary
                                : cs.surface;
                          }),
                          foregroundColor:
                              WidgetStateProperty.resolveWith((states) {
                            return states.contains(WidgetState.selected)
                                ? cs.onPrimary
                                : cs.onSurfaceVariant;
                          }),
                          side: WidgetStatePropertyAll(BorderSide(color: cs.outline)),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        segments: [
                          const ButtonSegment(
                            value: 0,
                            label: Text('1s'),
                            icon: Icon(Icons.timer_outlined),
                          ),
                          const ButtonSegment(
                            value: 1,
                            label: Text('30s'),
                            icon: Icon(Icons.timer_outlined),
                          ),
                          ButtonSegment(
                            value: 2,
                            label: Text('1${l.min}'),
                            icon: Icon(Icons.timer_outlined),
                          ),
                        ],
                        selected: {_interval},
                        onSelectionChanged: disabled
                            ? null
                            : (v) => setState(() => _interval = v.first),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Notification Threshold Slider ─────────────
                    Text(
                      l.notificationThreshold,
                      style: TextStyle(
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Slider(
                      value: _threshold.toDouble(),
                      min: 0,
                      max: 4,
                      divisions: 4,
                      label: '$_threshold',
                      onChanged: disabled
                          ? null
                          : (v) =>
                              setState(() => _threshold = v.round()),
                    ),

                    const SizedBox(height: 12),

                    // ── Belt Warning Slider ───────────────────────
                    Text(
                      l.beltWarning,
                      style: TextStyle(
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Slider(
                      value: _beltWarning.toDouble(),
                      min: 3,
                      max: 30,
                      divisions: 27,
                      label: '$_beltWarning ${l.min}',
                      onChanged: disabled
                          ? null
                          : (v) =>
                              setState(() => _beltWarning = v.round()),
                    ),

                    const SizedBox(height: 12),

                    // ── Action button (Write only) ────────────────
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 8,
                      children: [
                        FilledButton.icon(
                          icon:
                              const Icon(Icons.upload_outlined, size: 16),
                          label: Text(l.write),
                          style: FilledButton.styleFrom(
                            backgroundColor: cs.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                          ),
                          onPressed:
                              disabled || _loading ? null : _write,
                        ),
                        if (_loading)
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child:
                                CircularProgressIndicator(strokeWidth: 2),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _syncFromDevice() async {
    setState(() => _loading = true);
    final config = await ref.read(deviceRepositoryProvider).getSystemParams();
    if (config != null && mounted) {
      _populate(config);
      // Update cache
      ref.read(appPreferencesProvider).saveSystemParams(config);
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _write() async {
    setState(() => _loading = true);
    final extData96ms = _ext96ms ? 1 : 0;
    final siMode = _siMode ? 1 : 0;
    final storageMode = _storageMode ? 1 : 0;

    final success = await ref.read(deviceRepositoryProvider).setSystemParams(
          extData96ms: extData96ms,
          siMode: siMode,
          advertiseSetting: _advertise,
          storageMode: storageMode,
          detailedInterval: _interval,
          notificationThreshold: _threshold,
          beltWarning: _beltWarning,
        );
    if (mounted) {
      final l = AppLocalizations.of(context)!;
      if (success) {
        // Update cache after successful write
        final prefs = ref.read(appPreferencesProvider);
        prefs.sysExt96ms = extData96ms;
        prefs.sysStatusIndexMode = siMode;
        prefs.sysAdvertiseSetting = _advertise;
        prefs.sysStorageMode = storageMode;
        prefs.sysDetailedDataInterval = _interval;
        prefs.sysNotificationThreshold = _threshold;
        prefs.sysBeltWarning = _beltWarning;
        showAppSnackBar(context, message: l.writeSuccess);
      } else {
        showAppSnackBar(context, message: l.writeFailed, isError: true);
      }
      setState(() => _loading = false);
    }
  }
}
