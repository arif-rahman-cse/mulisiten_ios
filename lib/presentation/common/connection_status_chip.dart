import 'package:flutter/material.dart';
import 'package:ms200_companion/core/theme/status_colors.dart';
import 'package:ms200_companion/domain/model/connection_state.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';

class ConnectionStatusChip extends StatelessWidget {
  final BleConnectionState state;

  const ConnectionStatusChip({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    final sc = Theme.of(context).extension<StatusColors>()!;
    final l = AppLocalizations.of(context)!;

    final (label, color, icon) = switch (state) {
      BleConnectionState.connected => (
          l.connected,
          sc.connConnected,
          Icons.bluetooth_connected,
        ),
      BleConnectionState.connecting => (
          l.connecting,
          sc.connConnecting,
          Icons.bluetooth_searching,
        ),
      BleConnectionState.scanning => (
          l.scanning,
          sc.connScanning,
          Icons.bluetooth_searching,
        ),
      BleConnectionState.disconnected => (
          l.disconnected,
          sc.connDisconnected,
          Icons.bluetooth_disabled,
        ),
    };

    return Chip(
      avatar: Icon(icon, size: 16, color: color),
      label: Text(label, style: TextStyle(color: color, fontSize: 12)),
      backgroundColor: color.withValues(alpha: 0.1),
      side: BorderSide(color: color.withValues(alpha: 0.3)),
      visualDensity: VisualDensity.compact,
    );
  }
}
