import 'dart:async';

import 'package:ms200_companion/data/ble/ble_manager.dart';
import 'package:ms200_companion/data/ble/nus_protocol.dart';
import 'package:ms200_companion/domain/model/device_config.dart';

class DeviceRepository {
  final BleManager _ble;

  DeviceRepository(this._ble);

  Future<DeviceConfig?> getSerialAndState() {
    final completer = Completer<DeviceConfig?>();
    _ble.sendCommand(
      NusProtocol.buildGetSerial(),
      onAck: (ack) => completer.complete(NusProtocol.parseSerialResponse(ack.data)),
      onError: (_) => completer.complete(null),
    );
    return completer.future;
  }

  Future<bool> syncClock() {
    final completer = Completer<bool>();
    _ble.sendCommand(
      NusProtocol.buildSetClock(),
      onAck: (ack) => completer.complete(NusProtocol.parseAckCode(ack.data) == 0),
      onError: (_) => completer.complete(false),
    );
    return completer.future;
  }

  Future<DeviceConfig?> getUserParams() {
    final completer = Completer<DeviceConfig?>();
    _ble.sendCommand(
      NusProtocol.buildGetUserParams(),
      onAck: (ack) => completer.complete(NusProtocol.parseUserParams(ack.data)),
      onError: (_) => completer.complete(null),
    );
    return completer.future;
  }

  Future<bool> setUserParams({
    required int age,
    required int height,
    required int weight,
    required int exerciseHabit,
    required int medicalHistory,
  }) {
    final completer = Completer<bool>();
    _ble.sendCommand(
      NusProtocol.buildSetUserParams(
        age: age,
        height: height,
        weight: weight,
        exerciseHabit: exerciseHabit,
        medicalHistory: medicalHistory,
      ),
      onAck: (ack) => completer.complete(NusProtocol.parseAckCode(ack.data) == 0),
      onError: (_) => completer.complete(false),
    );
    return completer.future;
  }

  Future<DeviceConfig?> getSystemParams() {
    final completer = Completer<DeviceConfig?>();
    _ble.sendCommand(
      NusProtocol.buildGetSystemParams(),
      onAck: (ack) => completer.complete(NusProtocol.parseSystemParams(ack.data)),
      onError: (_) => completer.complete(null),
    );
    return completer.future;
  }

  Future<bool> setSystemParams({
    required int extData96ms,
    required int siMode,
    required int advertiseSetting,
    required int storageMode,
    required int detailedInterval,
    required int notificationThreshold,
    required int beltWarning,
  }) {
    final completer = Completer<bool>();
    _ble.sendCommand(
      NusProtocol.buildSetSystemParams(
        extData96ms: extData96ms,
        siMode: siMode,
        advertiseSetting: advertiseSetting,
        storageMode: storageMode,
        detailedInterval: detailedInterval,
        notificationThreshold: notificationThreshold,
        beltWarning: beltWarning,
      ),
      onAck: (ack) => completer.complete(NusProtocol.parseAckCode(ack.data) == 0),
      onError: (_) => completer.complete(false),
    );
    return completer.future;
  }
}
