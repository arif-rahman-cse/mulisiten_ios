import 'dart:async';

import 'package:drift/drift.dart';
import 'package:ms200_companion/data/ble/ble_manager.dart';
import 'package:ms200_companion/data/ble/nus_protocol.dart';
import 'package:ms200_companion/data/local/app_database.dart';
import 'package:ms200_companion/data/location/device_location_provider.dart';
import 'package:ms200_companion/data/preferences/app_preferences.dart';
import 'package:ms200_companion/data/remote/cloud_uploader.dart';
import 'package:ms200_companion/domain/model/sensing_data.dart';
import 'package:flutter/foundation.dart';

class SensingRepository {
  final BleManager _ble;
  final AppDatabase _db;
  final CloudUploader _uploader;
  final AppPreferences _prefs;
  final DeviceLocationProvider _location;

  DateTime? _lastUploadTime;
  Timer? _uploadTimer;
  SensingData? _bufferedData;
  final _sensingDataController = StreamController<SensingData>.broadcast();
  StreamSubscription<SensingData>? _bleSub;

  Stream<SensingData> get sensingData => _sensingDataController.stream;

  SensingRepository(
    this._ble,
    this._db,
    this._uploader,
    this._prefs,
    this._location,
  );

  void startListening() {
    _bleSub?.cancel();
    _bleSub = _ble.sensingData.listen(_onSensingData);
  }

  void stopListening() {
    _bleSub?.cancel();
    _bleSub = null;
    _uploadTimer?.cancel();
    _uploadTimer = null;
    _bufferedData = null;
  }

  Future<void> _onSensingData(SensingData data) async {
    var enriched = data;
    if (!data.hasGps) {
      final pos = await _location.getCurrentPosition();
      if (pos != null) {
        enriched = data.copyWith(
          latitude: _location.latToE7(pos),
          longitude: _location.lonToE7(pos),
          locationSource: 'PHONE',
        );
      }
    }

    _sensingDataController.add(enriched);

    if (_prefs.localDbEnabled) {
      await _saveToDB(enriched);
    }

    if (_prefs.realtimeUploadEnabled) {
      final now = DateTime.now();
      final interval = Duration(seconds: _prefs.realtimeUploadIntervalSec);

      if (_lastUploadTime == null ||
          now.difference(_lastUploadTime!) >= interval) {
        debugPrint('Uploading sensing data');
        _uploadTimer?.cancel();
        _lastUploadTime = now;
        _bufferedData = null;
        await _uploader.uploadSingleSensingData(enriched, _prefs.userName);
      } else {
        debugPrint('Buffering sensing data');
        _bufferedData = enriched;
        if (_uploadTimer == null || !_uploadTimer!.isActive) {
          final delay = interval - now.difference(_lastUploadTime!);
          _uploadTimer = Timer(delay, _processBufferedUpload);
        }
      }
    }
  }

  Future<void> _processBufferedUpload() async {
    if (_bufferedData != null && _prefs.realtimeUploadEnabled) {
      final dataToUpload = _bufferedData!;
      _bufferedData = null;
      _lastUploadTime = DateTime.now();
      await _uploader.uploadSingleSensingData(dataToUpload, _prefs.userName);
    }
  }

  Future<void> _saveToDB(SensingData data) async {
    await _db.insertSensingData(
      SensingDataEntriesCompanion.insert(
        deviceId: Value(data.deviceId),
        timestamp: Value(data.timestamp),
        heartRate: Value(data.heartRate),
        statusIndex: Value(data.statusIndex),
        statusLevel: Value(data.statusLevel),
        temperature: Value(data.temperature),
        humidity: Value(data.humidity),
        heatIndex: Value(data.heatIndex),
        heatIndexMax: Value(data.heatIndexMax),
        fallState: Value(data.fallState),
        batteryLevel: Value(data.batteryLevel),
        latitude: Value(data.latitude),
        longitude: Value(data.longitude),
        altitudeDiff: Value(data.altitudeDiff),
        ppi0: Value(data.ppi0),
        ppi1: Value(data.ppi1),
        ppi2: Value(data.ppi2),
        createdAt: Value(data.createdAt),
        locationSource: Value(data.locationSource),
      ),
    );
  }

  Future<bool> startRealtimeSensing() async {
    final completer = Completer<bool>();
    await _ble.sendCommand(
      NusProtocol.buildStartSensing(),
      onAck: (ack) {
        final code = NusProtocol.parseAckCode(ack.data);
        if (code == 0) {
          _ble.sendCommand(NusProtocol.buildStartDataStream());
          _prefs.sensingActive = true;
          startListening();
          completer.complete(true);
        } else {
          completer.complete(false);
        }
      },
      onError: (_) => completer.complete(false),
    );
    return completer.future;
  }

  Future<void> stopRealtimeSensing() async {
    await _ble.sendCommand(NusProtocol.buildStopDataStream());
    await _ble.sendCommand(NusProtocol.buildStopSensing());
    _prefs.sensingActive = false;
    stopListening();
  }

  Future<void> syncUnsentRecords() async {
    final records = await _db.getUnsyncedRecords(100);
    if (records.isEmpty) return;

    final domainRecords = records
        .map(
          (r) => SensingData(
            id: r.id,
            deviceId: r.deviceId,
            timestamp: r.timestamp,
            heartRate: r.heartRate,
            statusIndex: r.statusIndex,
            statusLevel: r.statusLevel,
            temperature: r.temperature,
            humidity: r.humidity,
            heatIndex: r.heatIndex,
            heatIndexMax: r.heatIndexMax,
            fallState: r.fallState,
            batteryLevel: r.batteryLevel,
            latitude: r.latitude,
            longitude: r.longitude,
            altitudeDiff: r.altitudeDiff,
            ppi0: r.ppi0,
            ppi1: r.ppi1,
            ppi2: r.ppi2,
            synced: r.synced,
            createdAt: r.createdAt,
            locationSource: r.locationSource,
          ),
        )
        .toList();

    final success = await _uploader.uploadBatch(domainRecords, _prefs.userName);
    if (success) {
      await _db.markAsSynced(records.map((r) => r.id).toList());
    }
  }

  void dispose() {
    stopListening();
    _sensingDataController.close();
  }
}
