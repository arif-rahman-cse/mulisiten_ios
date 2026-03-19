import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ms200_companion/domain/model/connection_state.dart';
import 'package:ms200_companion/l10n/app_localizations.dart';
import 'package:ms200_companion/providers/providers.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  List<ScanResult> _results = [];
  String? _statusKey; // tracks which l10n key to show
  StreamSubscription? _scanSub;
  StreamSubscription? _connSub;

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  @override
  void dispose() {
    _scanSub?.cancel();
    _connSub?.cancel();
    super.dispose();
  }

  Future<void> _startScan() async {
    setState(() {
      _results = [];
      _statusKey = 'initBluetooth';
    });

    final ble = ref.read(bleManagerProvider);

    _scanSub?.cancel();
    _scanSub = ble.scanResults.listen((results) {
      if (mounted) setState(() => _results = results);
    });

    _connSub?.cancel();
    _connSub = ble.connectionState.listen((state) {
      if (!mounted) return;
      if (state == BleConnectionState.connected) {
        context.pop();
      } else if (state == BleConnectionState.scanning) {
        setState(() => _statusKey = 'scanningDevices');
      } else if (state == BleConnectionState.disconnected) {
        setState(() {
          if (_results.isEmpty) {
            _statusKey = 'scanComplete';
          }
        });
      }
    });

    await ble.startScan();
  }

  String _resolveStatus(AppLocalizations l) {
    switch (_statusKey) {
      case 'initBluetooth':
        return l.initBluetooth;
      case 'scanningDevices':
        return l.scanningDevices;
      case 'scanComplete':
        return l.scanComplete;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch connection state to trigger rebuilds
    final connAsync = ref.watch(connectionStateProvider);
    final isScanning = connAsync.value == BleConnectionState.scanning;
    final l = AppLocalizations.of(context)!;
    final statusMessage = _resolveStatus(l);

    return Scaffold(
      appBar: AppBar(
        title: Text(l.scanTitle),
        actions: [
          if (isScanning)
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
        ],
      ),
      body: _results.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isScanning) ...[
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(statusMessage, textAlign: TextAlign.center),
                    ] else ...[
                      Icon(
                        Icons.bluetooth_disabled,
                        size: 64,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        statusMessage.isNotEmpty
                            ? statusMessage
                            : l.noDevicesFound,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      FilledButton(onPressed: _startScan, child: Text(l.retry)),
                    ],
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: _results.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final result = _results[index];
                final device = result.device;
                return ListTile(
                  leading: const Icon(Icons.watch),
                  title: Text(device.platformName),
                  trailing: Text('${result.rssi} dBm'),
                  onTap: () => _connect(device),
                );
              },
            ),
      floatingActionButton: !isScanning
          ? FloatingActionButton(
              onPressed: _startScan,
              child: const Icon(Icons.refresh),
            )
          : null,
    );
  }

  Future<void> _connect(BluetoothDevice device) async {
    final ble = ref.read(bleManagerProvider);
    final prefs = ref.read(appPreferencesProvider);

    prefs.pairedDeviceAddress = device.remoteId.str;
    prefs.pairedDeviceName = device.platformName;

    await ble.connect(device);
  }
}
