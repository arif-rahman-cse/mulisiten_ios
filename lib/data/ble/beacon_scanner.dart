import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:logger/logger.dart';


/// Parsed iBeacon advertisement from an MS200 device.
class BeaconFallEvent {
  final String deviceAddress;
  final int dataNo;
  final int fallValue;
  final DateTime timestamp;

  const BeaconFallEvent({
    required this.deviceAddress,
    required this.dataNo,
    required this.fallValue,
    required this.timestamp,
  });

  bool get isFallDetected => fallValue != 0xFFF && fallValue != 0;
}

/// Scans for MS200 iBeacon advertisements and parses the Minor field
/// to detect fall events (DataNo=15, value != 0xFFF).
///
/// iBeacon frame (from MS200 spec):
///   Minor = (DataNo << 12) | Value  (16 bits)
///   DataNo = 15 (0x0F) => fall detection
///   Value = actual fall state (0xFFF = no fall)
class BeaconScanner {
  final _log = Logger(printer: SimplePrinter(printTime: false));
  final _fallController = StreamController<BeaconFallEvent>.broadcast();
  StreamSubscription? _scanSub;

  Stream<BeaconFallEvent> get fallEvents => _fallController.stream;

  /// Start scanning for iBeacon advertisements.
  void startScanning() {
    _scanSub?.cancel();

    FlutterBluePlus.startScan(
      continuousUpdates: true,
      removeIfGone: const Duration(seconds: 30),
    );

    _scanSub = FlutterBluePlus.onScanResults.listen((results) {
      for (final result in results) {
        _processAdvertisement(result);
      }
    });

    _log.i('Beacon scanner started');
  }

  void stopScanning() {
    _scanSub?.cancel();
    _scanSub = null;
    FlutterBluePlus.stopScan();
    _log.i('Beacon scanner stopped');
  }

  void _processAdvertisement(ScanResult result) {
    final mfgData = result.advertisementData.manufacturerData;
    if (mfgData.isEmpty) return;

    for (final entry in mfgData.entries) {
      final companyId = entry.key;
      final data = entry.value;

      // Apple iBeacon company ID = 0x004C
      if (companyId != 0x004C) continue;
      // iBeacon data: type(1) + length(1) + UUID(16) + Major(2) + Minor(2) + TxPower(1) = 22+ bytes
      if (data.length < 22) continue;
      // iBeacon type = 0x02, length = 0x15
      if (data[0] != 0x02 || data[1] != 0x15) continue;

      final minor = _readMinor(Uint8List.fromList(data));
      final dataNo = (minor >> 12) & 0x0F;
      final value = minor & 0x0FFF;

      if (dataNo == 15) {
        final event = BeaconFallEvent(
          deviceAddress: result.device.remoteId.str,
          dataNo: dataNo,
          fallValue: value,
          timestamp: DateTime.now(),
        );

        if (event.isFallDetected) {
          _log.w('iBeacon fall detected: device=${event.deviceAddress}, value=$value');
          _fallController.add(event);
        }
      }
    }
  }

  int _readMinor(Uint8List data) {
    // Minor is at offset 20-21 (big-endian in iBeacon spec)
    return ((data[20] & 0xFF) << 8) | (data[21] & 0xFF);
  }

  void dispose() {
    stopScanning();
    _fallController.close();
  }
}
