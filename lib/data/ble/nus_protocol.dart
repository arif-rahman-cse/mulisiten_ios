
import 'package:ms200_companion/core/constants/ble_uuids.dart';
import 'package:ms200_companion/core/constants/command_ids.dart';
import 'package:ms200_companion/core/utils/byte_utils.dart';
import 'package:ms200_companion/domain/model/device_config.dart';
import 'package:ms200_companion/domain/model/sensing_data.dart';
import 'package:flutter/foundation.dart';

class AckFrame {
  final int ackNo;
  final Uint8List data;

  const AckFrame(this.ackNo, this.data);
}

class NusProtocol {
  NusProtocol._();

  // --------------- Frame Builder ---------------

  /// Build CMD frame: [0x7E][LenLo][LenHi][CmdNo][Data...][CsLo][CsHi]
  static Uint8List buildCmd(int cmdNo, Uint8List? data) {
    final dataLen = data?.length ?? 0;
    final length = 1 + dataLen;
    final frame = Uint8List(1 + 2 + 1 + dataLen + 2);
    frame[0] = CommandIds.headerCmd;
    frame[1] = length & 0xFF;
    frame[2] = (length >> 8) & 0xFF;
    frame[3] = cmdNo & 0xFF;
    if (data != null) {
      frame.setRange(4, 4 + dataLen, data);
    }
    var checksum = cmdNo & 0xFF;
    if (data != null) {
      for (final b in data) {
        checksum += b & 0xFF;
      }
    }
    frame[4 + dataLen] = checksum & 0xFF;
    frame[5 + dataLen] = (checksum >> 8) & 0xFF;
    return frame;
  }

  /// Build a read CMD with the "MSBandPC" magic string.
  static Uint8List buildReadCmd(int cmdNo) => buildCmd(cmdNo, BleUuids.magic);

  // --------------- Frame Parser ---------------

  /// Parse an ACK frame. Returns null if invalid.
  static AckFrame? parseAck(Uint8List frame) {
    if (frame.length < 6) return null;
    if (frame[0] != CommandIds.headerAck) return null;

    final length = (frame[1] & 0xFF) | ((frame[2] & 0xFF) << 8);
    final ackNo = frame[3] & 0xFF;
    final dataLen = length - 1;
    if (dataLen < 0 || frame.length < 4 + dataLen + 2) return null;

    final data = Uint8List.sublistView(frame, 4, 4 + dataLen);

    final expectedCs =
        (frame[4 + dataLen] & 0xFF) | ((frame[5 + dataLen] & 0xFF) << 8);
    var actualCs = ackNo;
    for (final b in data) {
      actualCs += b & 0xFF;
    }
    if ((actualCs & 0xFFFF) != (expectedCs & 0xFFFF)) return null;

    return AckFrame(ackNo, Uint8List.fromList(data));
  }

  // --------------- CMD Builders ---------------

  static Uint8List buildGetSerial() =>
      buildReadCmd(CommandIds.cmdGetSerial);

  static Uint8List buildSetClock() {
    final now = DateTime.now();
    final offset = now.timeZoneOffset;
    final offsetMinutes = offset.inMinutes;

    final data = Uint8List(9);
    ByteUtils.writeUint16LE(data, 0, now.year);
    ByteUtils.writeUint8(data, 2, now.month);
    ByteUtils.writeUint8(data, 3, now.day);
    ByteUtils.writeUint8(data, 4, now.hour);
    ByteUtils.writeUint8(data, 5, now.minute);
    ByteUtils.writeUint8(data, 6, now.second);
    ByteUtils.writeInt16LE(data, 7, -offsetMinutes);
    return buildCmd(CommandIds.cmdSetClock, data);
  }

  static Uint8List buildStartSensing() =>
      buildReadCmd(CommandIds.cmdStartSensing);

  static Uint8List buildStopSensing() =>
      buildReadCmd(CommandIds.cmdStopSensing);

  static Uint8List buildStartDataStream() {
    final data = Uint8List(9);
    data[0] = 1;
    return buildCmd(CommandIds.cmdSendData, data);
  }

  static Uint8List buildStopDataStream() {
    final data = Uint8List(9);
    data[0] = 0;
    return buildCmd(CommandIds.cmdSendData, data);
  }

  static Uint8List buildGetUserParams() =>
      buildReadCmd(CommandIds.cmdGetUserParams);

  static Uint8List buildSetUserParams({
    required int age,
    required int height,
    required int weight,
    required int exerciseHabit,
    required int medicalHistory,
  }) {
    final data = Uint8List(21);
    ByteUtils.writeUint8(data, 0, age);
    ByteUtils.writeUint16LE(data, 1, height);
    ByteUtils.writeUint16LE(data, 3, weight);
    ByteUtils.writeUint8(data, 5, exerciseHabit);
    ByteUtils.writeUint8(data, 6, medicalHistory);
    return buildCmd(CommandIds.cmdSetUserParams, data);
  }

  static Uint8List buildGetSystemParams() =>
      buildReadCmd(CommandIds.cmdGetSystemParams);

  static Uint8List buildSetSystemParams({
    required int extData96ms,
    required int siMode,
    required int advertiseSetting,
    required int storageMode,
    required int detailedInterval,
    required int notificationThreshold,
    required int beltWarning,
  }) {
    final data = Uint8List(24);
    ByteUtils.writeUint8(data, 0, extData96ms);
    ByteUtils.writeUint8(data, 1, siMode);
    ByteUtils.writeUint8(data, 2, advertiseSetting);
    ByteUtils.writeUint8(data, 3, storageMode);
    ByteUtils.writeUint8(data, 4, detailedInterval);
    ByteUtils.writeUint8(data, 5, notificationThreshold);
    ByteUtils.writeUint16LE(data, 6, beltWarning);
    return buildCmd(CommandIds.cmdSetSystemParams, data);
  }

  // --------------- ACK Parsers ---------------

  /// Parse 40-byte detailed sensing data (flag 0xA6).
  static SensingData? parseDetailedData(Uint8List data, String deviceId) {
    if (data.length < 40) return null;
    if (data[0] != CommandIds.flagDetailedData) return null;
    debugPrint('parseDetailedData: $data');

    return SensingData(
      deviceId: deviceId,
      timestamp: ByteUtils.readUint32LE(data, 1),
      heartRate: ByteUtils.readUint8(data, 5),
      statusIndex: ByteUtils.readUint8(data, 6),
      statusLevel: ByteUtils.readUint8(data, 7),
      temperature: ByteUtils.readInt16LE(data, 8),
      humidity: ByteUtils.readUint16LE(data, 10),
      heatIndex: ByteUtils.readUint8(data, 12),
      fallState: ByteUtils.readInt8(data, 13),
      heatIndexMax: ByteUtils.readUint8(data, 14),
      batteryLevel: ByteUtils.readUint8(data, 15),
      latitude: ByteUtils.readInt32LE(data, 20),
      longitude: ByteUtils.readInt32LE(data, 24),
      altitudeDiff: ByteUtils.readInt16LE(data, 28),
      ppi0: ByteUtils.readUint16LE(data, 30),
      ppi1: ByteUtils.readUint16LE(data, 32),
      ppi2: ByteUtils.readUint16LE(data, 34),
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
  }

  static DeviceConfig? parseSerialResponse(Uint8List data) {
    if (data.length < 15) return null;
    return DeviceConfig(
      serialNumber: String.fromCharCodes(data.sublist(0, 14)).trim(),
      systemState: data[14] & 0xFF,
    );
  }

  static DeviceConfig? parseUserParams(Uint8List data) {
    if (data.length < 8) return null;
    final config = DeviceConfig(
      age: data[0] & 0xFF,
      height: ByteUtils.readUint16LE(data, 1),
      weight: ByteUtils.readUint16LE(data, 3),
    );
    if (data.length >= 21) {
      // Old format might be contain bugs, so we don't use it
      //config.notificationThreshold = data[5] & 0xFF;
      //config.exerciseHabit = data[6] & 0xFF;
      //config.medicalHistory = data[7] & 0xFF;
      // Unofficial format, need to confirm it form TOSHIBA.

      config.exerciseHabit = data[5] & 0xFF;
      config.medicalHistory = data[6] & 0xFF;

    } else {
      config.exerciseHabit = data[5] & 0xFF;
      config.medicalHistory = data[6] & 0xFF;
    }
    debugPrint('Device Info Parsed from device: age: ${config.age}, height: ${config.heightCm}, weight: ${config.weightKg}, threshold: ${config.notificationThreshold}, exerciseHabit: ${config.exerciseHabit}, medicalHistory: ${config.medicalHistory}');
    return config;
  }

  static DeviceConfig? parseSystemParams(Uint8List data) {
    if (data.length < 8) return null;
    return DeviceConfig(
      extendedData96ms: data[0] & 0xFF,
      statusIndexMode: data[1] & 0xFF,
      advertiseSetting: data[2] & 0xFF,
      storageMode: data[3] & 0xFF,
      detailedDataInterval: data[4] & 0xFF,
      sysNotificationThreshold: data[5] & 0xFF,
      beltWarning: ByteUtils.readUint16LE(data, 6),
    );
  }

  static int parseAckCode(Uint8List data) {
    if (data.isEmpty) return -1;
    return data[0] & 0xFF;
  }
}
