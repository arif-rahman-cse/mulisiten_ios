import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:logger/logger.dart';
import 'package:ms200_companion/core/constants/ble_uuids.dart';
import 'package:ms200_companion/core/constants/command_ids.dart';
import 'package:ms200_companion/data/ble/nus_protocol.dart';
import 'package:ms200_companion/domain/model/connection_state.dart';
import 'package:ms200_companion/domain/model/sensing_data.dart';
import 'package:flutter/foundation.dart';

typedef AckCallback = void Function(AckFrame ack);
typedef ErrorCallback = void Function(String message);

class _PendingCommand {
  final Uint8List cmd;
  final AckCallback? onAck;
  final ErrorCallback? onError;
  Timer? timeout;

  _PendingCommand(this.cmd, {this.onAck, this.onError});
}

class BleManager {
  static const _scanTimeoutDuration = Duration(seconds: 15);
  static const _connectTimeoutDuration = Duration(seconds: 15);
  static const _cmdTimeoutDuration = Duration(seconds: 5);
  static const _maxFrameSize = 512;

  final _log = Logger(printer: SimplePrinter(printTime: false));

  BluetoothDevice? _device;
  BluetoothCharacteristic? _rxCharacteristic;
  BluetoothCharacteristic? _txCharacteristic;
  StreamSubscription<List<int>>? _txSubscription;
  StreamSubscription<BluetoothConnectionState>? _connectionSub;
  StreamSubscription<List<ScanResult>>? _fbpScanSub;
  Timer? _connectTimer;

  String? connectedDeviceId;
  Uint8List _receiveBuffer = Uint8List(0);

  final _connectionStateController =
      StreamController<BleConnectionState>.broadcast();
  final _sensingDataController = StreamController<SensingData>.broadcast();
  final _scanResultsController = StreamController<List<ScanResult>>.broadcast();
  final _ackController = StreamController<AckFrame>.broadcast();

  BleConnectionState _currentState = BleConnectionState.disconnected;

  final Queue<_PendingCommand> _commandQueue = Queue();
  _PendingCommand? _activeCommand;

  Stream<BleConnectionState> get connectionState =>
      _connectionStateController.stream;
  Stream<SensingData> get sensingData => _sensingDataController.stream;
  Stream<List<ScanResult>> get scanResults => _scanResultsController.stream;
  Stream<AckFrame> get ackStream => _ackController.stream;
  BleConnectionState get currentState => _currentState;
  bool get isConnected => _currentState == BleConnectionState.connected;

  void _setState(BleConnectionState state) {
    _currentState = state;
    _connectionStateController.add(state);
  }

  // --------------- Scan ---------------

  Future<void> startScan() async {
    // On iOS the adapter state starts as `unknown` until CBCentralManager
    // finishes initializing. Wait up to 15s for it to become `.on`.
    // This also covers the first-launch Bluetooth permission dialog.
    var adapterState = FlutterBluePlus.adapterStateNow;
    _log.i('startScan called, adapterState=$adapterState');

    if (adapterState != BluetoothAdapterState.on) {
      _setState(BleConnectionState.scanning);

      // Log every adapter state transition while we wait
      final sub = FlutterBluePlus.adapterState.listen((s) {
        _log.i('Adapter state transition: $s');
      });

      try {
        adapterState = await FlutterBluePlus.adapterState
            .where((s) => s != BluetoothAdapterState.unknown)
            .first
            .timeout(const Duration(seconds: 15));
        _log.i('Adapter resolved to: $adapterState');
      } on TimeoutException {
        _log.w(
          'Bluetooth adapter timed out (stuck at: ${FlutterBluePlus.adapterStateNow})',
        );
        _setState(BleConnectionState.disconnected);
        sub.cancel();
        return;
      }
      sub.cancel();

      if (adapterState != BluetoothAdapterState.on) {
        _log.w('Bluetooth adapter is $adapterState, cannot scan');
        _setState(BleConnectionState.disconnected);
        return;
      }
    }

    _setState(BleConnectionState.scanning);

    // Subscribe to FBP results BEFORE starting the scan so we don't miss any.
    // No name filter (matches Android) - iOS may not support it; filter in code.
    _fbpScanSub?.cancel();
    _fbpScanSub = FlutterBluePlus.onScanResults.listen((results) {
      final withName = results
          .where((r) => r.device.platformName.trim().isNotEmpty)
          .toList();
      final msb = withName
          .where(
            (r) => r.device.platformName.startsWith(
              BleUuids.deviceNamePrefix,
            ),
          )
          .toList();
      // Prefer MSB devices; if none, show all (with names) so user can see if scan works
      final toShow = msb.isNotEmpty ? msb : withName;
      _scanResultsController.add(List.unmodifiable(toShow));
    });

    try {
      await FlutterBluePlus.startScan(timeout: _scanTimeoutDuration);
      _log.i('Scan started');
    } catch (e) {
      _log.w('startScan failed: $e');
      _fbpScanSub?.cancel();
      _setState(BleConnectionState.disconnected);
      return;
    }

    // FBP's isScanning stream can fire false immediately on iOS. Use a timer
    // instead to match FBP's timeout duration.
    Future.delayed(_scanTimeoutDuration).then((_) {
      _fbpScanSub?.cancel();
      if (_currentState == BleConnectionState.scanning) {
        _log.i('Scan finished');
        _setState(BleConnectionState.disconnected);
      }
    });
  }

  void stopScan() {
    _fbpScanSub?.cancel();
    _fbpScanSub = null;
    FlutterBluePlus.stopScan();
    if (_currentState == BleConnectionState.scanning) {
      _setState(BleConnectionState.disconnected);
    }
  }

  // --------------- Connect ---------------

  Future<void> connect(BluetoothDevice device) async {
    stopScan();
    _connectTimer?.cancel();
    _setState(BleConnectionState.connecting);
    _device = device;

    _connectionSub?.cancel();
    _connectionSub = device.connectionState.listen(_onConnectionStateChange);

    try {
      await device.connect(
        license: License.free,
        autoConnect: false,
        timeout: _connectTimeoutDuration,
      );
    } catch (e) {
      _log.w('Connect failed: $e');
      _setState(BleConnectionState.disconnected);
      return;
    }

    _connectTimer = Timer(_connectTimeoutDuration, () {
      if (_currentState == BleConnectionState.connecting) {
        _log.w('Connection timeout');
        disconnect();
      }
    });
  }

  /// Reconnect using autoConnect (OS-managed whitelist scan).
  Future<void> reconnect(BluetoothDevice device) async {
    _device = device;
    _setState(BleConnectionState.connecting);

    _connectionSub?.cancel();
    _connectionSub = device.connectionState.listen(_onConnectionStateChange);

    try {
      await device.connect(license: License.free, autoConnect: true, mtu: null);
    } catch (e) {
      _log.w('Reconnect failed: $e');
      _setState(BleConnectionState.disconnected);
    }
  }

  void _onConnectionStateChange(BluetoothConnectionState state) async {
    if (state == BluetoothConnectionState.connected) {
      _connectTimer?.cancel();
      _log.i('GATT connected, discovering services...');
      await _setupNus();
    } else if (state == BluetoothConnectionState.disconnected) {
      _connectTimer?.cancel();
      _cleanup(keepDevice: true);
      _setState(BleConnectionState.disconnected);
    }
  }

  Future<void> _setupNus() async {
    final device = _device;
    if (device == null) return;

    try {
      await device.requestMtu(512);
    } catch (_) {}

    final services = await device.discoverServices();
    BluetoothService? nusService;
    for (final s in services) {
      if (s.uuid == BleUuids.nusService) {
        nusService = s;
        break;
      }
    }

    if (nusService == null) {
      _log.e('NUS service not found');
      disconnect();
      return;
    }

    for (final c in nusService.characteristics) {
      if (c.uuid == BleUuids.nusRx) _rxCharacteristic = c;
      if (c.uuid == BleUuids.nusTx) _txCharacteristic = c;
    }

    if (_rxCharacteristic == null || _txCharacteristic == null) {
      _log.e('NUS characteristics not found');
      disconnect();
      return;
    }

    await _txCharacteristic!.setNotifyValue(true);
    _txSubscription?.cancel();
    _txSubscription = _txCharacteristic!.onValueReceived.listen(
      (value) => _handleReceivedData(Uint8List.fromList(value)),
    );

    connectedDeviceId = device.platformName.trim().isEmpty
        ? 'Unknown'
        : device.platformName;
    _setState(BleConnectionState.connected);
    _log.i('NUS ready, device: $connectedDeviceId');
  }

  // --------------- Disconnect ---------------

  Future<void> disconnect() async {
    _cleanup();
    try {
      await _device?.disconnect();
    } catch (_) {}
    _device = null;
    _setState(BleConnectionState.disconnected);
  }

  void _cleanup({bool keepDevice = false}) {
    _connectTimer?.cancel();
    _txSubscription?.cancel();
    _txSubscription = null;
    _rxCharacteristic = null;
    _txCharacteristic = null;
    if (!keepDevice) connectedDeviceId = null;
    _receiveBuffer = Uint8List(0);
    _clearCommandQueue();
  }

  // --------------- Command Queue ---------------

  Future<bool> sendCommand(
    Uint8List cmd, {
    AckCallback? onAck,
    ErrorCallback? onError,
  }) async {
    if (_rxCharacteristic == null) {
      onError?.call('Not connected');
      return false;
    }

    final pending = _PendingCommand(cmd, onAck: onAck, onError: onError);

    if (_activeCommand != null) {
      _commandQueue.add(pending);
      return true;
    }
    _activeCommand = pending;
    await _executeCommand(pending);
    return true;
  }

  Future<void> _executeCommand(_PendingCommand pending) async {
    try {
      await _rxCharacteristic!.write(
        pending.cmd.toList(),
        withoutResponse: false,
      );
    } catch (e) {
      _activeCommand = null;
      pending.onError?.call('Write failed: $e');
      _processNextCommand();
      return;
    }

    pending.timeout = Timer(_cmdTimeoutDuration, () {
      if (_activeCommand == pending) {
        _activeCommand = null;
        pending.onError?.call('Command timed out');
        _processNextCommand();
      }
    });
  }

  void _processNextCommand() {
    if (_commandQueue.isEmpty) return;
    final next = _commandQueue.removeFirst();
    _activeCommand = next;
    _executeCommand(next);
  }

  void _clearCommandQueue() {
    _activeCommand?.timeout?.cancel();
    for (final c in _commandQueue) {
      c.timeout?.cancel();
    }
    _commandQueue.clear();
    _activeCommand = null;
  }

  // --------------- Receive Buffer ---------------

  void _handleReceivedData(Uint8List data) {
    final combined = Uint8List(_receiveBuffer.length + data.length);
    combined.setRange(0, _receiveBuffer.length, _receiveBuffer);
    combined.setRange(_receiveBuffer.length, combined.length, data);
    _receiveBuffer = combined;

    while (_receiveBuffer.length >= 6) {
      if (_receiveBuffer[0] != CommandIds.headerAck) {
        final offset = _findAckHeader(_receiveBuffer);
        if (offset < 0) {
          _receiveBuffer = Uint8List(0);
          return;
        }
        _receiveBuffer = Uint8List.sublistView(_receiveBuffer, offset);
        continue;
      }

      final length =
          (_receiveBuffer[1] & 0xFF) | ((_receiveBuffer[2] & 0xFF) << 8);
      final frameSize = 1 + 2 + length + 2;

      if (frameSize < 5 || frameSize > _maxFrameSize) {
        _receiveBuffer = _receiveBuffer.length > 1
            ? Uint8List.sublistView(_receiveBuffer, 1)
            : Uint8List(0);
        continue;
      }
      if (_receiveBuffer.length < frameSize) return;

      final frame = Uint8List.fromList(_receiveBuffer.sublist(0, frameSize));
      _receiveBuffer = _receiveBuffer.length > frameSize
          ? Uint8List.sublistView(_receiveBuffer, frameSize)
          : Uint8List(0);

      final ack = NusProtocol.parseAck(frame);
      if (ack != null) _processAck(ack);
    }
  }

  int _findAckHeader(Uint8List buffer) {
    for (var i = 0; i < buffer.length; i++) {
      if (buffer[i] == CommandIds.headerAck) return i;
    }
    return -1;
  }

  void _processAck(AckFrame ack) {
    _ackController.add(ack);

    if (ack.ackNo == CommandIds.ackSendData &&
        ack.data.length >= 40 &&
        ack.data[0] == CommandIds.flagDetailedData) {
      final sensing = NusProtocol.parseDetailedData(
        ack.data,
        connectedDeviceId ?? '',
      );
      if (sensing != null) _sensingDataController.add(sensing);
      return;
    }

    final completed = _activeCommand;
    if (completed != null) {
      completed.timeout?.cancel();
      _activeCommand = null;
      completed.onAck?.call(ack);
    }
    _processNextCommand();
  }

  // --------------- Dispose ---------------

  Future<void> dispose() async {
    await disconnect();
    _connectionSub?.cancel();
    _fbpScanSub?.cancel();
    await _connectionStateController.close();
    await _sensingDataController.close();
    await _scanResultsController.close();
    await _ackController.close();
  }
}
