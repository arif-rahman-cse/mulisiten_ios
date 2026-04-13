import 'package:drift/drift.dart';
import 'package:ms200_companion/data/local/app_database.dart';
import 'package:ms200_companion/data/preferences/app_preferences.dart';
import 'package:ms200_companion/data/remote/cloud_uploader.dart';
import 'package:ms200_companion/domain/model/fall_event.dart';
import 'package:ms200_companion/domain/model/sensing_data.dart';

class FallEventRepository {
  final AppDatabase _db;
  final CloudUploader _uploader;
  final AppPreferences _prefs;

  FallEventRepository(this._db, this._uploader, this._prefs);

  Future<void> saveFallEvent(FallEvent event) async {
    await _db.insertFallEvent(
      FallEventEntriesCompanion.insert(
        deviceId: Value(event.deviceId),
        timestamp: Value(event.timestamp),
        latitude: Value(event.latitude),
        longitude: Value(event.longitude),
        elapsedSeconds: Value(event.elapsedSeconds),
        statusLevel: Value(event.statusLevel),
        heatIndex: Value(event.heatIndex),
        source: Value(event.source),
        heartRate: Value(event.heartRate),
        temperature: Value(event.temperature),
        humidity: Value(event.humidity),
        heatIndexMax: Value(event.heatIndexMax),
        fallState: Value(event.fallState),
        batteryLevel: Value(event.batteryLevel),
        altitudeDiff: Value(event.altitudeDiff),
        statusIndex: Value(event.statusIndex),
        ppi0: Value(event.ppi0),
        ppi1: Value(event.ppi1),
        ppi2: Value(event.ppi2),
        userName: Value(event.userName),
        locationSource: Value(event.locationSource),
        createdAt: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  Future<bool> uploadImmediately(FallEvent event) async {
    print("uploadImmediately: $event");
    return _uploader.uploadFallEvent(event);
  }

  Future<void> uploadPendingEvents() async {
    final pending = await _db.getPendingFallEvents();
    for (final entry in pending) {
      print("uploadPendingEvents: $entry");
      final event = _entryToFallEvent(entry);
      final success = await _uploader.uploadFallEvent(event);
      if (success) {
        await _db.markFallEventUploaded(entry.id);
      }
    }
  }

  FallEvent fromSensingData(
    SensingData data, {
    String source = FallEvent.sourceRealtime,
  }) {
    return FallEvent(
      deviceId: data.deviceId,
      timestamp: data.timestamp,
      latitude: data.latitude,
      longitude: data.longitude,
      statusLevel: data.statusLevel,
      heatIndex: data.heatIndex,
      source: source,
      heartRate: data.heartRate,
      temperature: data.temperature,
      humidity: data.humidity,
      heatIndexMax: data.heatIndexMax,
      fallState: data.fallState,
      batteryLevel: data.batteryLevel,
      altitudeDiff: data.altitudeDiff,
      statusIndex: data.statusIndex,
      ppi0: data.ppi0,
      ppi1: data.ppi1,
      ppi2: data.ppi2,
      userName: _prefs.userName,
      locationSource: data.locationSource,
    );
  }

  FallEvent _entryToFallEvent(FallEventEntry e) {
    return FallEvent(
      id: e.id,
      deviceId: e.deviceId,
      timestamp: e.timestamp,
      latitude: e.latitude,
      longitude: e.longitude,
      elapsedSeconds: e.elapsedSeconds,
      statusLevel: e.statusLevel,
      heatIndex: e.heatIndex,
      source: e.source,
      uploaded: e.uploaded,
      heartRate: e.heartRate,
      temperature: e.temperature,
      humidity: e.humidity,
      heatIndexMax: e.heatIndexMax,
      fallState: e.fallState,
      batteryLevel: e.batteryLevel,
      altitudeDiff: e.altitudeDiff,
      statusIndex: e.statusIndex,
      ppi0: e.ppi0,
      ppi1: e.ppi1,
      ppi2: e.ppi2,
      userName: e.userName,
      locationSource: e.locationSource,
    );
  }
}
