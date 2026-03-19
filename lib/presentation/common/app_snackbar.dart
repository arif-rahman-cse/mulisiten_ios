import 'package:flutter/material.dart';
import 'package:ms200_companion/core/theme/status_colors.dart';

/// Common SnackBar helper for consistent feedback across the app.
void showAppSnackBar(
  BuildContext context, {
  required String message,
  bool isError = false,
}) {
  final sc = Theme.of(context).extension<StatusColors>()!;
  final cs = Theme.of(context).colorScheme;

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: isError ? cs.onError : cs.onPrimary,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: isError ? cs.onError : cs.onPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: isError ? sc.critical : sc.normal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        duration: Duration(seconds: isError ? 4 : 2),
      ),
    );
}
