import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:ms200_companion/domain/model/history_models.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:ms200_companion/data/local/sensing_data_table.dart';
import 'package:ms200_companion/data/local/fall_event_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [SensingDataEntries, FallEventEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await _createHistoryIndexes();
    },
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await _createHistoryIndexes();
      }
    },
  );

  // --- SensingData queries ---

  Future<int> insertSensingData(SensingDataEntriesCompanion entry) =>
      into(sensingDataEntries).insert(entry);

  Future<List<SensingDataEntry>> getUnsyncedRecords(int limit) =>
      (select(sensingDataEntries)
            ..where((t) => t.synced.equals(false))
            ..limit(limit)
            ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
          .get();

  Future<void> markAsSynced(List<int> ids) async {
    await (update(sensingDataEntries)..where((t) => t.id.isIn(ids))).write(
      const SensingDataEntriesCompanion(synced: Value(true)),
    );
  }

  Stream<SensingDataEntry?> watchLatest() =>
      (select(sensingDataEntries)
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
            ..limit(1))
          .watchSingleOrNull();

  Future<int> deleteAllSensingData() => delete(sensingDataEntries).go();

  Future<List<SensingDataEntry>> getAllSensingData() => (select(
    sensingDataEntries,
  )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();

  Future<List<HistoryAggregateRow>> getHistoryAggregates(
    HistoryWindow window,
  ) async {
    final bucketExpr = switch (window.range) {
      HistoryRange.day =>
        '((created_at - ${window.startMs}) / ${const Duration(minutes: 5).inMilliseconds})',
      HistoryRange.week || HistoryRange.month =>
        "strftime('%Y-%m-%d', datetime(created_at / 1000, 'unixepoch', 'localtime'))",
      HistoryRange.year =>
        "strftime('%Y-%m', datetime(created_at / 1000, 'unixepoch', 'localtime'))",
    };

    final result = await customSelect(
      '''
      SELECT
        MIN(created_at) AS bucket_start,
        COUNT(*) AS sample_count,
        AVG(heart_rate) AS heart_rate_avg,
        MIN(heart_rate) AS heart_rate_min,
        MAX(heart_rate) AS heart_rate_max,
        AVG(temperature) AS temperature_avg,
        MIN(temperature) AS temperature_min,
        MAX(temperature) AS temperature_max,
        AVG(humidity) AS humidity_avg,
        MIN(humidity) AS humidity_min,
        MAX(humidity) AS humidity_max,
        AVG(altitude_diff) AS altitude_avg,
        MIN(altitude_diff) AS altitude_min,
        MAX(altitude_diff) AS altitude_max
      FROM sensing_data_entries
      WHERE created_at >= ? AND created_at < ?
      GROUP BY $bucketExpr
      ORDER BY bucket_start ASC
      ''',
      variables: [
        Variable.withInt(window.startMs),
        Variable.withInt(window.endExclusiveMs),
      ],
      readsFrom: {sensingDataEntries},
    ).get();

    return result.map((row) {
      return HistoryAggregateRow(
        bucketStartMs: row.read<int>('bucket_start'),
        sampleCount: row.read<int>('sample_count'),
        heartRateAvg: _readDouble(row, 'heart_rate_avg'),
        heartRateMin: _readDouble(row, 'heart_rate_min'),
        heartRateMax: _readDouble(row, 'heart_rate_max'),
        temperatureAvg: _readDouble(row, 'temperature_avg'),
        temperatureMin: _readDouble(row, 'temperature_min'),
        temperatureMax: _readDouble(row, 'temperature_max'),
        humidityAvg: _readDouble(row, 'humidity_avg'),
        humidityMin: _readDouble(row, 'humidity_min'),
        humidityMax: _readDouble(row, 'humidity_max'),
        altitudeAvg: _readDouble(row, 'altitude_avg'),
        altitudeMin: _readDouble(row, 'altitude_min'),
        altitudeMax: _readDouble(row, 'altitude_max'),
      );
    }).toList();
  }

  // --- FallEvent queries ---

  Future<int> insertFallEvent(FallEventEntriesCompanion entry) =>
      into(fallEventEntries).insert(entry);

  Future<List<FallEventEntry>> getPendingFallEvents() =>
      (select(fallEventEntries)..where((t) => t.uploaded.equals(false))).get();

  Future<void> markFallEventUploaded(int id) async {
    await (update(fallEventEntries)..where((t) => t.id.equals(id))).write(
      const FallEventEntriesCompanion(uploaded: Value(true)),
    );
  }

  Future<int> deleteAllFallEvents() => delete(fallEventEntries).go();

  Future<List<FallEventEntry>> getAllFallEvents() => (select(
    fallEventEntries,
  )..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();

  Future<List<HistoryFallAggregateRow>> getFallHistoryAggregates(
    HistoryWindow window,
  ) async {
    final bucketExpr = switch (window.range) {
      HistoryRange.day =>
        '((created_at - ${window.startMs}) / ${const Duration(minutes: 5).inMilliseconds})',
      HistoryRange.week || HistoryRange.month =>
        "strftime('%Y-%m-%d', datetime(created_at / 1000, 'unixepoch', 'localtime'))",
      HistoryRange.year =>
        "strftime('%Y-%m', datetime(created_at / 1000, 'unixepoch', 'localtime'))",
    };

    final result = await customSelect(
      '''
      SELECT
        MIN(created_at) AS bucket_start,
        COUNT(*) AS event_count
      FROM fall_event_entries
      WHERE created_at >= ? AND created_at < ?
      GROUP BY $bucketExpr
      ORDER BY bucket_start ASC
      ''',
      variables: [
        Variable.withInt(window.startMs),
        Variable.withInt(window.endExclusiveMs),
      ],
      readsFrom: {fallEventEntries},
    ).get();

    return result.map((row) {
      return HistoryFallAggregateRow(
        bucketStartMs: row.read<int>('bucket_start'),
        eventCount: row.read<int>('event_count'),
      );
    }).toList();
  }

  Future<List<FallEventEntry>> getRecentFallEvents(
    HistoryWindow window, {
    int limit = 5,
  }) {
    return (select(fallEventEntries)
          ..where(
            (t) =>
                t.createdAt.isBiggerOrEqualValue(window.startMs) &
                t.createdAt.isSmallerThanValue(window.endExclusiveMs),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .get();
  }

  Future<void> _createHistoryIndexes() async {
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_sensing_data_created_at '
      'ON sensing_data_entries (created_at)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_fall_event_created_at '
      'ON fall_event_entries (created_at)',
    );
  }

  double _readDouble(QueryRow row, String key) {
    final value = row.data[key];
    if (value is num) {
      return value.toDouble();
    }
    return 0;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'ms200.db'));
    return NativeDatabase.createInBackground(file);
  });
}
