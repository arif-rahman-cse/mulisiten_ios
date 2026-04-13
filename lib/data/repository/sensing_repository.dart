import 'dart:async';

import 'package:drift/drift.dart';
import 'package:ms200_companion/core/constants/command_ids.dart';
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
  final void Function()? onSensingActivePersisted;

  DateTime? _lastUploadTime;
  Timer? _uploadTimer;
  Timer? _syncTimer;
  SensingData? _bufferedData;
  int? _bufferedRowId;
  final _sensingDataController = StreamController<SensingData>.broadcast();
  StreamSubscription<SensingData>? _bleSub;

  Stream<SensingData> get sensingData => _sensingDataController.stream;

  SensingRepository(
    this._ble,
    this._db,
    this._uploader,
    this._prefs,
    this._location, {
    this.onSensingActivePersisted,
  });

  void _persistSensingActive(bool value) {
    if (_prefs.sensingActive == value) return;
    _prefs.sensingActive = value;
    onSensingActivePersisted?.call();
  }

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
    _bufferedRowId = null;
  }

  Future<void> _onSensingData(SensingData data) async {
    // Prefs may be false while the band still streams (e.g. after clearing data).
    _persistSensingActive(true);

    //print('onSensingData: ${data.deviceId}');
    if (!data.hasGps) {
      final pos = await _location.getCurrentPosition();
      if (pos != null) {
        data = data.copyWith(
          latitude: _location.latToE7(pos),
          longitude: _location.lonToE7(pos),
          locationSource: 'PHONE',
        );
      }
    }

    _sensingDataController.add(data);

    // Always buffer to local DB as a data safety net for batch sync
    final rowId = await _saveToDB(data);

    if (_prefs.realtimeUploadEnabled) {
      final now = DateTime.now();
      final interval = Duration(seconds: _prefs.realtimeUploadIntervalSec);

      if (_lastUploadTime == null ||
          now.difference(_lastUploadTime!) >= interval) {
        _uploadTimer?.cancel();
        _lastUploadTime = now;
        _bufferedData = null;
        _bufferedRowId = null;
        final ok = await _uploader.uploadSingleSensingData(
          data,
          _prefs.userName,
        );
        if (ok) {
          await _db.markAsSynced([rowId]);
        }
      } else {
        _bufferedData = data;
        _bufferedRowId = rowId;
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
      final rowId = _bufferedRowId;
      _bufferedData = null;
      _bufferedRowId = null;
      _lastUploadTime = DateTime.now();
      final ok = await _uploader.uploadSingleSensingData(
        dataToUpload,
        _prefs.userName,
      );
      if (ok && rowId != null) {
        await _db.markAsSynced([rowId]);
      }
    }
  }

  Future<int> _saveToDB(SensingData data) async {
    return _db.insertSensingData(
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
    // Ensure location permission is obtained and background stream is active
    // before sensing starts — location is used to tag readings when the
    // wristband has no GPS fix.
    await _location.initialize();
    _location.startBackgroundLocationStream();

    // Subscribe before waiting for start ACK: if the band is already sensing
    // (e.g. prefs were cleared while it kept streaming), ACK may be non-zero
    // but notifications still arrive — without this, the home UI stays stale.
    startListening();
    final completer = Completer<bool>();
    await _ble.sendCommand(
      NusProtocol.buildStartSensing(),
      onAck: (ack) {
        if (ack.ackNo != CommandIds.ackStartSensing) {
          completer.complete(false);
          return;
        }
        final code = NusProtocol.parseAckCode(ack.data);
        if (code == 0) {
          _ble.sendCommand(NusProtocol.buildStartDataStream());
          _persistSensingActive(true);
          completer.complete(true);
          return;
        }
        // Already in realtime or busy: still enable app-side state and data
        // stream so the FAB matches the band and Stop works.
        _ble.sendCommand(NusProtocol.buildStartDataStream());
        _persistSensingActive(true);
        completer.complete(true);
      },
      onError: (_) => completer.complete(false),
    );
    return completer.future;
  }

  Future<void> stopRealtimeSensing() async {
    await _ble.sendCommand(NusProtocol.buildStopDataStream());
    await _ble.sendCommand(NusProtocol.buildStopSensing());
    _persistSensingActive(false);
    stopListening();
  }

  /// Start periodic batch sync of unuploaded records.
  /// Runs an immediate sync, then repeats every 15 minutes.
  void startPeriodicSync() {
    _syncTimer?.cancel();
    syncUnsentRecords();
    _syncTimer = Timer.periodic(const Duration(minutes: 15), (_) {
      syncUnsentRecords();
    });
  }

  Future<void> syncUnsentRecords() async {
    try {
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

      final success = await _uploader.uploadBatch(
        domainRecords,
        _prefs.userName,
      );
      if (success) {
        await _db.markAsSynced(records.map((r) => r.id).toList());
      }
    } catch (e) {
      debugPrint('syncUnsentRecords failed: $e');
    }
  }

  void dispose() {
    stopListening();
    _syncTimer?.cancel();
    _sensingDataController.close();
  }
}
