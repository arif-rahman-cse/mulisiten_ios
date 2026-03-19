import 'package:drift/drift.dart';

class SensingDataEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get deviceId => text().withDefault(const Constant(''))();
  IntColumn get timestamp => integer().withDefault(const Constant(0))();
  IntColumn get heartRate => integer().withDefault(const Constant(0))();
  IntColumn get statusIndex => integer().withDefault(const Constant(0))();
  IntColumn get statusLevel => integer().withDefault(const Constant(0))();
  IntColumn get temperature => integer().withDefault(const Constant(0))();
  IntColumn get humidity => integer().withDefault(const Constant(0))();
  IntColumn get heatIndex => integer().withDefault(const Constant(0))();
  IntColumn get heatIndexMax => integer().withDefault(const Constant(0))();
  IntColumn get fallState => integer().withDefault(const Constant(-1))();
  IntColumn get batteryLevel => integer().withDefault(const Constant(0))();
  IntColumn get latitude => integer().withDefault(const Constant(0))();
  IntColumn get longitude => integer().withDefault(const Constant(0))();
  IntColumn get altitudeDiff => integer().withDefault(const Constant(0))();
  IntColumn get ppi0 => integer().withDefault(const Constant(0))();
  IntColumn get ppi1 => integer().withDefault(const Constant(0))();
  IntColumn get ppi2 => integer().withDefault(const Constant(0))();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  IntColumn get createdAt => integer().withDefault(const Constant(0))();
  TextColumn get locationSource =>
      text().withDefault(const Constant('MS200'))();
}
