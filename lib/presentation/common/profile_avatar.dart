import 'package:flutter/material.dart';

String profileInitials(String userName) {
  final parts = userName.trim().split(RegExp(r'\s+')).where((s) => s.isNotEmpty);
  final list = parts.toList();
  if (list.isEmpty) return '';
  if (list.length == 1) {
    final s = list.single;
    return s.length >= 2
        ? s.substring(0, 2).toUpperCase()
        : s.toUpperCase();
  }
  return ('${list[0][0]}${list[1][0]}').toUpperCase();
}

class ProfileAvatar extends StatelessWidget {
  final String userName;
  final double radius;

  const ProfileAvatar({
    super.key,
    required this.userName,
    this.radius = 20,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final initials = profileInitials(userName);

    return CircleAvatar(
      radius: radius,
      backgroundColor: cs.primaryContainer,
      foregroundColor: cs.onPrimaryContainer,
      child: initials.isEmpty
          ? Icon(Icons.person, size: radius * 1.1)
          : Text(
              initials,
              style: TextStyle(
                fontSize: radius * 0.85,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}
