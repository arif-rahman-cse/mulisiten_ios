import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
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
  int get schemaVersion => 1;

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
    await (update(sensingDataEntries)..where((t) => t.id.isIn(ids)))
        .write(const SensingDataEntriesCompanion(synced: Value(true)));
  }

  Stream<SensingDataEntry?> watchLatest() => (select(sensingDataEntries)
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
        ..limit(1))
      .watchSingleOrNull();

  Future<int> deleteAllSensingData() => delete(sensingDataEntries).go();

  Future<List<SensingDataEntry>> getAllSensingData() =>
      (select(sensingDataEntries)
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .get();

  // --- FallEvent queries ---

  Future<int> insertFallEvent(FallEventEntriesCompanion entry) =>
      into(fallEventEntries).insert(entry);

  Future<List<FallEventEntry>> getPendingFallEvents() =>
      (select(fallEventEntries)..where((t) => t.uploaded.equals(false))).get();

  Future<void> markFallEventUploaded(int id) async {
    await (update(fallEventEntries)..where((t) => t.id.equals(id)))
        .write(const FallEventEntriesCompanion(uploaded: Value(true)));
  }

  Future<int> deleteAllFallEvents() => delete(fallEventEntries).go();

  Future<List<FallEventEntry>> getAllFallEvents() =>
      (select(fallEventEntries)
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .get();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'ms200.db'));
    return NativeDatabase.createInBackground(file);
  });
}
