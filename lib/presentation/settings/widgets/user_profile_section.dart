import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ms200_companion/core/theme/status_colors.dart';
import 'package:ms200_companion/domain/model/device_config.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';
import 'package:ms200_companion/presentation/common/app_snackbar.dart';
import 'package:ms200_companion/providers/providers.dart';

class UserProfileSection extends ConsumerStatefulWidget {
  final bool sensingActive;

  const UserProfileSection({super.key, required this.sensingActive});

  @override
  ConsumerState<UserProfileSection> createState() => _UserProfileSectionState();
}

class _UserProfileSectionState extends ConsumerState<UserProfileSection> {
  final _ageCtrl = TextEditingController();
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _medicalCtrl = TextEditingController();
  int _exerciseHabit = 0;
  bool _loading = false;

  String? _ageError;
  String? _heightError;
  String? _weightError;
  String? _medicalHistoryError;

  @override
  void initState() {
    super.initState();
    // Auto-populate from cached preferences
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _populateFromPrefs();
    });
  }

  @override
  void dispose() {
    _ageCtrl.dispose();
    _heightCtrl.dispose();
    _weightCtrl.dispose();
    _medicalCtrl.dispose();
    super.dispose();
  }

  void _populateFromPrefs() {
    final prefs = ref.read(appPreferencesProvider);
    final heightCm = prefs.userHeight / 10.0;
    final weightKg = prefs.userWeight / 10.0;
    _ageCtrl.text = '${prefs.userAge}';
    _heightCtrl.text = heightCm.toStringAsFixed(0);
    _weightCtrl.text = weightKg.toStringAsFixed(0);
    _medicalCtrl.text = '${prefs.userMedicalHistory}';
    setState(() => _exerciseHabit = prefs.userExerciseHabit);
  }

  void _populate(DeviceConfig config) {
    _ageCtrl.text = '${config.age}';
    _heightCtrl.text = config.heightCm.toStringAsFixed(0);
    _weightCtrl.text = config.weightKg.toStringAsFixed(0);
    _medicalCtrl.text = '${config.medicalHistory}';
    setState(() => _exerciseHabit = config.exerciseHabit);
  }

  bool _validateInputs() {
    final age = int.tryParse(_ageCtrl.text);
    final height = double.tryParse(_heightCtrl.text);
    final weight = double.tryParse(_weightCtrl.text);
    final medicalHistory = int.tryParse(_medicalCtrl.text);
    final l = AppLocalizations.of(context)!;

    setState(() {
      _ageError = (age == null || age < 0 || age > 120) ? l.ageRange : null;
      _heightError = (height == null || height < 0 || height > 250)
          ? l.heightRange
          : null;
      _weightError = (weight == null || weight < 0 || weight > 250)
          ? l.weightRange
          : null;
      _medicalHistoryError =
          (medicalHistory == null || medicalHistory < 0 || medicalHistory > 10)
          ? l.medicalHistoryRange
          : null;
    });

    return _ageError == null &&
        _heightError == null &&
        _weightError == null &&
        _medicalHistoryError == null;
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
            // Header with Sync button
            Row(
              children: [
                Icon(Icons.person_outline, size: 20, color: cs.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l.userProfile,
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
                  label: Text(l.syncUser),
                  style: TextButton.styleFrom(
                    foregroundColor: cs.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                  onPressed: disabled || _loading ? null : _syncFromDevice,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Warning banner
            if (disabled)
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: sc.warningBg,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: sc.warningText.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lock_outline_rounded,
                      size: 14,
                      color: sc.warningText,
                    ),
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

            // Content (with disabled overlay)
            AbsorbPointer(
              absorbing: disabled,
              child: AnimatedOpacity(
                opacity: disabled ? 0.8 : 1.0,
                duration: const Duration(milliseconds: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 3-column metric row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _MetricField(
                            icon: Icons.person_outline,
                            label: l.age,
                            controller: _ageCtrl,
                            suffix: l.yrs,
                            helperText: l.ageRange,
                            errorText: _ageError,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _MetricField(
                            icon: Icons.straighten,
                            label: l.heightCm,
                            controller: _heightCtrl,
                            suffix: l.cm,
                            helperText: l.heightRange,
                            errorText: _heightError,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _MetricField(
                            icon: Icons.monitor_weight_outlined,
                            label: l.weightKg,
                            controller: _weightCtrl,
                            suffix: l.kg,
                            helperText: l.weightRange,
                            errorText: _weightError,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Exercise Habit
                    Text(
                      l.exerciseHabit,
                      style: TextStyle(
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SegmentedButton<int>(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith((
                          states,
                        ) {
                          return states.contains(WidgetState.selected)
                              ? cs.primary
                              : cs.surface;
                        }),
                        foregroundColor: WidgetStateProperty.resolveWith((
                          states,
                        ) {
                          return states.contains(WidgetState.selected)
                              ? cs.onPrimary
                              : cs.onSurfaceVariant;
                        }),
                        side: WidgetStatePropertyAll(
                          BorderSide(color: cs.outline),
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      segments: [
                        ButtonSegment(
                          value: 0,
                          label: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.bed_outlined, size: 20),
                              const SizedBox(height: 4),
                              //font size 11
                              Text(l.exerciseNone),
                            ],
                          ),
                        ),
                        ButtonSegment(
                          value: 1,
                          label: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.directions_walk, size: 20),
                              const SizedBox(height: 4),
                              Text(l.exerciseLight),
                            ],
                          ),
                        ),
                        ButtonSegment(
                          value: 2,
                          label: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.directions_run, size: 20),
                              const SizedBox(height: 4),
                              Text(l.exerciseModerate),
                            ],
                          ),
                        ),
                        ButtonSegment(
                          value: 3,
                          label: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.fitness_center, size: 20),
                              const SizedBox(height: 4),
                              Text(l.exerciseHeavy),
                            ],
                          ),
                        ),
                      ],
                      selected: {_exerciseHabit},
                      onSelectionChanged: disabled
                          ? null
                          : (v) => setState(() => _exerciseHabit = v.first),
                    ),
                    const SizedBox(height: 20),

                    // Medical History
                    // _MetricField(
                    //   icon: Icons.medical_services_outlined,
                    //   label: l.medicalHistory,
                    //   controller: _medicalCtrl,
                    //   suffix: null,
                    //   helperText: null,
                    //   errorText: _medicalHistoryError,
                    // ),
                    // const SizedBox(height: 20),

                    // Action button (Write only)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 8,
                      children: [
                        FilledButton.icon(
                          icon: const Icon(Icons.upload_outlined, size: 16),
                          label: Text(l.write),
                          style: FilledButton.styleFrom(
                            backgroundColor: cs.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                          ),
                          onPressed: disabled || _loading
                              ? null
                              : _writeToDevice,
                        ),
                        if (_loading)
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
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
    final repo = ref.read(deviceRepositoryProvider);
    final config = await repo.getUserParams();
    if (config != null && mounted) {
      _populate(config);
      // Update cache
      ref.read(appPreferencesProvider).saveUserParams(config);
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _writeToDevice() async {
    if (!_validateInputs()) return;
    setState(() => _loading = true);
    final repo = ref.read(deviceRepositoryProvider);
    final age = int.tryParse(_ageCtrl.text) ?? 0;
    final height = ((double.tryParse(_heightCtrl.text) ?? 0) * 10).round();
    final weight = ((double.tryParse(_weightCtrl.text) ?? 0) * 10).round();
    final medicalHistory = int.tryParse(_medicalCtrl.text) ?? 0;

    final success = await repo.setUserParams(
      age: age,
      height: height,
      weight: weight,
      exerciseHabit: _exerciseHabit,
      medicalHistory: medicalHistory,
    );
    if (mounted) {
      final l = AppLocalizations.of(context)!;
      if (success) {
        // Update cache after successful write
        final prefs = ref.read(appPreferencesProvider);
        prefs.userAge = age;
        prefs.userHeight = height;
        prefs.userWeight = weight;
        prefs.userExerciseHabit = _exerciseHabit;
        prefs.userMedicalHistory = medicalHistory;
        showAppSnackBar(context, message: l.writeSuccess);
      } else {
        showAppSnackBar(context, message: l.writeFailed, isError: true);
      }
      setState(() => _loading = false);
    }
  }
}

class _MetricField extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;
  final String? suffix;
  final String? helperText;
  final String? errorText;

  const _MetricField({
    required this.icon,
    required this.label,
    required this.controller,
    this.suffix,
    this.helperText,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: cs.onSurfaceVariant),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: cs.onSurfaceVariant,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        //Hide the keyboard
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          style: TextStyle(color: cs.onSurface, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            suffixText: suffix,
            suffixStyle: TextStyle(
              color: cs.primary,
              fontWeight: FontWeight.w600,
            ),
            helperText: helperText,
            helperMaxLines: 1,
            errorText: errorText,
          ),
        ),
      ],
    );
  }
}
