import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ms200_companion/domain/model/daily_activity_summary.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';

class DailyActivityCard extends StatelessWidget {
  final DailyActivityState state;
  final VoidCallback onRetry;

  const DailyActivityCard({
    super.key,
    required this.state,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final baseColor = cs.tertiary;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        height: 140,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [
                    baseColor.withValues(alpha: 0.2),
                    baseColor.withValues(alpha: 0.1),
                  ]
                : [baseColor, baseColor.withValues(alpha: 0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // Background Watermark
            Positioned(
              right: -10,
              bottom: -10,
              child: FaIcon(
                FontAwesomeIcons.personWalking,
                size: 120,
                color: isDark
                    ? baseColor.withValues(alpha: 0.1)
                    : cs.onPrimary.withValues(alpha: 0.15),
              ),
            ),

            // Foreground Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: _buildContent(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return switch (state.status) {
      DailyActivityStatus.loading => const _LoadingContent(),
      DailyActivityStatus.ready => _SummaryContent(summary: state.summary!),
      DailyActivityStatus.noData => _MessageContent(
        title: AppLocalizations.of(context)!.todayActivity,
        message: AppLocalizations.of(context)!.noActivityDataToday,
      ),
      DailyActivityStatus.permissionDenied => _ActionContent(
        title: AppLocalizations.of(context)!.todayActivity,
        message: AppLocalizations.of(context)!.appleHealthPermissionCta,
        actionLabel: AppLocalizations.of(context)!.allowAppleHealthAccess,
        onPressed: onRetry,
      ),
      DailyActivityStatus.error => _ActionContent(
        title: AppLocalizations.of(context)!.todayActivity,
        message:
            state.message ?? AppLocalizations.of(context)!.activityLoadFailed,
        actionLabel: AppLocalizations.of(context)!.retry,
        onPressed: onRetry,
      ),
      DailyActivityStatus.unsupported => const SizedBox.shrink(),
    };
  }
}

class _SummaryContent extends StatelessWidget {
  final DailyActivitySummary summary;

  const _SummaryContent({required this.summary});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;
    final formatter = NumberFormat.decimalPattern();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.personWalking,
              color: cs.onPrimary.withValues(alpha: 0.7),
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              l.todayActivity,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: cs.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Data
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _MetricItem(
                value: formatter.format(summary.stepCount),
                icon: FontAwesomeIcons.shoePrints,
                quarterTurns: -1,
              ),
            ),
            Expanded(
              child: _MetricItem(
                value: '${summary.activeCalories.toStringAsFixed(0)} ${l.kcal}',
                icon: FontAwesomeIcons.fire,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MetricItem extends StatelessWidget {
  final String value;
  final FaIconData icon;
  final int quarterTurns;

  const _MetricItem({
    required this.value,
    required this.icon,
    this.quarterTurns = 0,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        RotatedBox(
          quarterTurns: quarterTurns,
          child: FaIcon(
            icon,
            color: cs.onPrimary.withValues(alpha: 0.8),
            size: 16,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: cs.onPrimary,
              fontWeight: FontWeight.w800,
              height: 1.0,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _LoadingContent extends StatelessWidget {
  const _LoadingContent();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final cs = Theme.of(context).colorScheme;

    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: cs.onPrimary,
            backgroundColor: cs.onPrimary.withValues(alpha: 0.2),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            l.activityLoading,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: cs.onPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _MessageContent extends StatelessWidget {
  final String title;
  final String message;

  const _MessageContent({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.personWalking,
              color: cs.onPrimary.withValues(alpha: 0.7),
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: cs.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: cs.onPrimary.withValues(alpha: 0.9),
          ),
        ),
      ],
    );
  }
}

class _ActionContent extends StatelessWidget {
  final String title;
  final String message;
  final String actionLabel;
  final VoidCallback onPressed;

  const _ActionContent({
    required this.title,
    required this.message,
    required this.actionLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FaIcon(
              FontAwesomeIcons.personWalking,
              color: cs.onPrimary.withValues(alpha: 0.7),
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: cs.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: cs.onPrimary.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: cs.onPrimary,
            foregroundColor: cs.tertiary,
            elevation: 0,
          ),
          child: Text(actionLabel),
        ),
      ],
    );
  }
}
