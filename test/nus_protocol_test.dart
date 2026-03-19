import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:ms200_companion/core/constants/command_ids.dart';
import 'package:ms200_companion/data/ble/nus_protocol.dart';

void main() {
  group('NusProtocol.buildCmd', () {
    test('builds frame with correct header, length, checksum', () {
      final data = Uint8List.fromList([0x01, 0x02, 0x03]);
      final frame = NusProtocol.buildCmd(0x28, data);

      expect(frame[0], CommandIds.headerCmd);
      // length = 1 (cmdNo) + 3 (data) = 4
      expect(frame[1], 4); // low byte
      expect(frame[2], 0); // high byte
      expect(frame[3], 0x28);
      expect(frame[4], 0x01);
      expect(frame[5], 0x02);
      expect(frame[6], 0x03);
      // checksum = 0x28 + 0x01 + 0x02 + 0x03 = 0x2E
      expect(frame[7], 0x2E); // low byte
      expect(frame[8], 0x00); // high byte
    });

    test('builds frame with null data', () {
      final frame = NusProtocol.buildCmd(0x0C, null);

      expect(frame[0], CommandIds.headerCmd);
      expect(frame[1], 1); // length = just cmdNo
      expect(frame[2], 0);
      expect(frame[3], 0x0C);
      expect(frame[4], 0x0C); // checksum = cmdNo only
      expect(frame[5], 0x00);
    });
  });

  group('NusProtocol.buildReadCmd', () {
    test('includes MSBandPC magic string', () {
      final frame = NusProtocol.buildReadCmd(CommandIds.cmdGetSerial);
      // header(1) + length(2) + cmd(1) + magic(8) + checksum(2) = 14
      expect(frame.length, 14);
      expect(frame[3], CommandIds.cmdGetSerial);
      expect(frame[4], 0x4D); // 'M'
      expect(frame[5], 0x53); // 'S'
      expect(frame[6], 0x42); // 'B'
    });
  });

  group('NusProtocol.parseAck', () {
    test('parses valid ACK frame', () {
      // Build a fake ACK: 0x7D, length=2 (ackNo + 1 byte data), ackNo=0x47,
      // data=[0x00], checksum = 0x47 + 0x00 = 0x47
      final frame = Uint8List.fromList([
        0x7D, 0x02, 0x00, 0x47, 0x00, 0x47, 0x00,
      ]);
      final ack = NusProtocol.parseAck(frame);

      expect(ack, isNotNull);
      expect(ack!.ackNo, 0x47);
      expect(ack.data.length, 1);
      expect(ack.data[0], 0x00);
    });

    test('returns null for bad checksum', () {
      final frame = Uint8List.fromList([
        0x7D, 0x02, 0x00, 0x47, 0x00, 0xFF, 0xFF,
      ]);
      expect(NusProtocol.parseAck(frame), isNull);
    });

    test('returns null for wrong header', () {
      final frame = Uint8List.fromList([
        0x7E, 0x02, 0x00, 0x47, 0x00, 0x47, 0x00,
      ]);
      expect(NusProtocol.parseAck(frame), isNull);
    });

    test('returns null for frame too short', () {
      expect(NusProtocol.parseAck(Uint8List.fromList([0x7D, 0x01])), isNull);
    });
  });

  group('NusProtocol.parseDetailedData', () {
    Uint8List buildSensingPacket({
      int heartRate = 72,
      int temperature = 2350,
      int humidity = 5500,
      int heatIndex = 1,
      int fallState = 0,
      int batteryLevel = 85,
      int lat = 356541234,
      int lon = 1397654321,
      int ppi0 = 830,
    }) {
      final data = Uint8List(40);
      data[0] = 0xA6;
      // timestamp at bytes 1-4 (LE)
      data[1] = 0x00;
      data[2] = 0x00;
      data[3] = 0x01;
      data[4] = 0x00;
      data[5] = heartRate;
      data[6] = 20; // statusIndex
      data[7] = 1; // statusLevel
      // temperature LE at 8-9
      data[8] = temperature & 0xFF;
      data[9] = (temperature >> 8) & 0xFF;
      // humidity LE at 10-11
      data[10] = humidity & 0xFF;
      data[11] = (humidity >> 8) & 0xFF;
      data[12] = heatIndex;
      data[13] = fallState; // signed int8
      data[14] = 2; // heatIndexMax
      data[15] = batteryLevel;
      // lat LE at 20-23
      data[20] = lat & 0xFF;
      data[21] = (lat >> 8) & 0xFF;
      data[22] = (lat >> 16) & 0xFF;
      data[23] = (lat >> 24) & 0xFF;
      // lon LE at 24-27
      data[24] = lon & 0xFF;
      data[25] = (lon >> 8) & 0xFF;
      data[26] = (lon >> 16) & 0xFF;
      data[27] = (lon >> 24) & 0xFF;
      // ppi0 LE at 30-31
      data[30] = ppi0 & 0xFF;
      data[31] = (ppi0 >> 8) & 0xFF;
      return data;
    }

    test('parses all fields correctly', () {
      final packet = buildSensingPacket();
      final result = NusProtocol.parseDetailedData(packet, 'MSB25200401234');

      expect(result, isNotNull);
      expect(result!.deviceId, 'MSB25200401234');
      expect(result.heartRate, 72);
      expect(result.statusIndex, 20);
      expect(result.statusLevel, 1);
      expect(result.temperature, 2350);
      expect(result.temperatureCelsius, closeTo(23.5, 0.01));
      expect(result.humidity, 5500);
      expect(result.humidityPercent, closeTo(55.0, 0.01));
      expect(result.heatIndex, 1);
      expect(result.fallState, 0);
      expect(result.heatIndexMax, 2);
      expect(result.batteryLevel, 85);
      expect(result.latitude, 356541234);
      expect(result.longitude, 1397654321);
      expect(result.ppi0, 830);
      expect(result.hasGps, true);
    });

    test('returns null for wrong flag', () {
      final data = Uint8List(40);
      data[0] = 0xA5; // wrong flag
      expect(NusProtocol.parseDetailedData(data, 'test'), isNull);
    });

    test('returns null for data too short', () {
      expect(NusProtocol.parseDetailedData(Uint8List(30), 'test'), isNull);
    });

    test('detects fall state', () {
      final packet = buildSensingPacket(fallState: 1);
      final result = NusProtocol.parseDetailedData(packet, 'test');
      expect(result!.isFallDetected, true);
    });

    test('no GPS when lat/lon zero', () {
      final packet = buildSensingPacket(lat: 0, lon: 0);
      final result = NusProtocol.parseDetailedData(packet, 'test');
      expect(result!.hasGps, false);
    });
  });

  group('NusProtocol.parseSerialResponse', () {
    test('parses serial and system state', () {
      final data = Uint8List(17);
      final serial = 'MSB25200401234';
      for (var i = 0; i < serial.length; i++) {
        data[i] = serial.codeUnitAt(i);
      }
      data[14] = 0; // IDLE
      final config = NusProtocol.parseSerialResponse(data);

      expect(config, isNotNull);
      expect(config!.serialNumber, 'MSB25200401234');
      expect(config.systemState, 0);
      expect(config.isIdle, true);
    });
  });

  group('CMD builders produce correct length', () {
    test('buildSetClock produces 14-byte frame', () {
      final frame = NusProtocol.buildSetClock();
      // header(1) + length(2) + cmd(1) + data(9) + checksum(2) = 15
      expect(frame.length, 15);
      expect(frame[0], CommandIds.headerCmd);
      expect(frame[3], CommandIds.cmdSetClock);
    });

    test('buildSetUserParams produces correct frame', () {
      final frame = NusProtocol.buildSetUserParams(
        age: 30,
        height: 1700,
        weight: 650,
        exerciseHabit: 1,
        medicalHistory: 0,
      );
      // header(1) + length(2) + cmd(1) + data(21) + checksum(2) = 27
      expect(frame.length, 27);
      expect(frame[3], CommandIds.cmdSetUserParams);
      expect(frame[4], 30); // age
    });

    test('buildSetSystemParams produces correct frame', () {
      final frame = NusProtocol.buildSetSystemParams(
        extData96ms: 1,
        siMode: 0,
        advertiseSetting: 0,
        storageMode: 0,
        detailedInterval: 1,
        notificationThreshold: 2,
        beltWarning: 10,
      );
      // header(1) + length(2) + cmd(1) + data(24) + checksum(2) = 30
      expect(frame.length, 30);
      expect(frame[3], CommandIds.cmdSetSystemParams);
    });
  });
}
