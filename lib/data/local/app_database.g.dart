// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SensingDataEntriesTable extends SensingDataEntries
    with TableInfo<$SensingDataEntriesTable, SensingDataEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SensingDataEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<int> timestamp = GeneratedColumn<int>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _heartRateMeta = const VerificationMeta(
    'heartRate',
  );
  @override
  late final GeneratedColumn<int> heartRate = GeneratedColumn<int>(
    'heart_rate',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusIndexMeta = const VerificationMeta(
    'statusIndex',
  );
  @override
  late final GeneratedColumn<int> statusIndex = GeneratedColumn<int>(
    'status_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusLevelMeta = const VerificationMeta(
    'statusLevel',
  );
  @override
  late final GeneratedColumn<int> statusLevel = GeneratedColumn<int>(
    'status_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _temperatureMeta = const VerificationMeta(
    'temperature',
  );
  @override
  late final GeneratedColumn<int> temperature = GeneratedColumn<int>(
    'temperature',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _humidityMeta = const VerificationMeta(
    'humidity',
  );
  @override
  late final GeneratedColumn<int> humidity = GeneratedColumn<int>(
    'humidity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _heatIndexMeta = const VerificationMeta(
    'heatIndex',
  );
  @override
  late final GeneratedColumn<int> heatIndex = GeneratedColumn<int>(
    'heat_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _heatIndexMaxMeta = const VerificationMeta(
    'heatIndexMax',
  );
  @override
  late final GeneratedColumn<int> heatIndexMax = GeneratedColumn<int>(
    'heat_index_max',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fallStateMeta = const VerificationMeta(
    'fallState',
  );
  @override
  late final GeneratedColumn<int> fallState = GeneratedColumn<int>(
    'fall_state',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(-1),
  );
  static const VerificationMeta _batteryLevelMeta = const VerificationMeta(
    'batteryLevel',
  );
  @override
  late final GeneratedColumn<int> batteryLevel = GeneratedColumn<int>(
    'battery_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<int> latitude = GeneratedColumn<int>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<int> longitude = GeneratedColumn<int>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _altitudeDiffMeta = const VerificationMeta(
    'altitudeDiff',
  );
  @override
  late final GeneratedColumn<int> altitudeDiff = GeneratedColumn<int>(
    'altitude_diff',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _ppi0Meta = const VerificationMeta('ppi0');
  @override
  late final GeneratedColumn<int> ppi0 = GeneratedColumn<int>(
    'ppi0',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _ppi1Meta = const VerificationMeta('ppi1');
  @override
  late final GeneratedColumn<int> ppi1 = GeneratedColumn<int>(
    'ppi1',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _ppi2Meta = const VerificationMeta('ppi2');
  @override
  late final GeneratedColumn<int> ppi2 = GeneratedColumn<int>(
    'ppi2',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _locationSourceMeta = const VerificationMeta(
    'locationSource',
  );
  @override
  late final GeneratedColumn<String> locationSource = GeneratedColumn<String>(
    'location_source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('MS200'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    deviceId,
    timestamp,
    heartRate,
    statusIndex,
    statusLevel,
    temperature,
    humidity,
    heatIndex,
    heatIndexMax,
    fallState,
    batteryLevel,
    latitude,
    longitude,
    altitudeDiff,
    ppi0,
    ppi1,
    ppi2,
    synced,
    createdAt,
    locationSource,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sensing_data_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<SensingDataEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    if (data.containsKey('heart_rate')) {
      context.handle(
        _heartRateMeta,
        heartRate.isAcceptableOrUnknown(data['heart_rate']!, _heartRateMeta),
      );
    }
    if (data.containsKey('status_index')) {
      context.handle(
        _statusIndexMeta,
        statusIndex.isAcceptableOrUnknown(
          data['status_index']!,
          _statusIndexMeta,
        ),
      );
    }
    if (data.containsKey('status_level')) {
      context.handle(
        _statusLevelMeta,
        statusLevel.isAcceptableOrUnknown(
          data['status_level']!,
          _statusLevelMeta,
        ),
      );
    }
    if (data.containsKey('temperature')) {
      context.handle(
        _temperatureMeta,
        temperature.isAcceptableOrUnknown(
          data['temperature']!,
          _temperatureMeta,
        ),
      );
    }
    if (data.containsKey('humidity')) {
      context.handle(
        _humidityMeta,
        humidity.isAcceptableOrUnknown(data['humidity']!, _humidityMeta),
      );
    }
    if (data.containsKey('heat_index')) {
      context.handle(
        _heatIndexMeta,
        heatIndex.isAcceptableOrUnknown(data['heat_index']!, _heatIndexMeta),
      );
    }
    if (data.containsKey('heat_index_max')) {
      context.handle(
        _heatIndexMaxMeta,
        heatIndexMax.isAcceptableOrUnknown(
          data['heat_index_max']!,
          _heatIndexMaxMeta,
        ),
      );
    }
    if (data.containsKey('fall_state')) {
      context.handle(
        _fallStateMeta,
        fallState.isAcceptableOrUnknown(data['fall_state']!, _fallStateMeta),
      );
    }
    if (data.containsKey('battery_level')) {
      context.handle(
        _batteryLevelMeta,
        batteryLevel.isAcceptableOrUnknown(
          data['battery_level']!,
          _batteryLevelMeta,
        ),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('altitude_diff')) {
      context.handle(
        _altitudeDiffMeta,
        altitudeDiff.isAcceptableOrUnknown(
          data['altitude_diff']!,
          _altitudeDiffMeta,
        ),
      );
    }
    if (data.containsKey('ppi0')) {
      context.handle(
        _ppi0Meta,
        ppi0.isAcceptableOrUnknown(data['ppi0']!, _ppi0Meta),
      );
    }
    if (data.containsKey('ppi1')) {
      context.handle(
        _ppi1Meta,
        ppi1.isAcceptableOrUnknown(data['ppi1']!, _ppi1Meta),
      );
    }
    if (data.containsKey('ppi2')) {
      context.handle(
        _ppi2Meta,
        ppi2.isAcceptableOrUnknown(data['ppi2']!, _ppi2Meta),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('location_source')) {
      context.handle(
        _locationSourceMeta,
        locationSource.isAcceptableOrUnknown(
          data['location_source']!,
          _locationSourceMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SensingDataEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SensingDataEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp'],
      )!,
      heartRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}heart_rate'],
      )!,
      statusIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status_index'],
      )!,
      statusLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status_level'],
      )!,
      temperature: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}temperature'],
      )!,
      humidity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}humidity'],
      )!,
      heatIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}heat_index'],
      )!,
      heatIndexMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}heat_index_max'],
      )!,
      fallState: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fall_state'],
      )!,
      batteryLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}battery_level'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}longitude'],
      )!,
      altitudeDiff: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}altitude_diff'],
      )!,
      ppi0: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ppi0'],
      )!,
      ppi1: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ppi1'],
      )!,
      ppi2: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ppi2'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      locationSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_source'],
      )!,
    );
  }

  @override
  $SensingDataEntriesTable createAlias(String alias) {
    return $SensingDataEntriesTable(attachedDatabase, alias);
  }
}

class SensingDataEntry extends DataClass
    implements Insertable<SensingDataEntry> {
  final int id;
  final String deviceId;
  final int timestamp;
  final int heartRate;
  final int statusIndex;
  final int statusLevel;
  final int temperature;
  final int humidity;
  final int heatIndex;
  final int heatIndexMax;
  final int fallState;
  final int batteryLevel;
  final int latitude;
  final int longitude;
  final int altitudeDiff;
  final int ppi0;
  final int ppi1;
  final int ppi2;
  final bool synced;
  final int createdAt;
  final String locationSource;
  const SensingDataEntry({
    required this.id,
    required this.deviceId,
    required this.timestamp,
    required this.heartRate,
    required this.statusIndex,
    required this.statusLevel,
    required this.temperature,
    required this.humidity,
    required this.heatIndex,
    required this.heatIndexMax,
    required this.fallState,
    required this.batteryLevel,
    required this.latitude,
    required this.longitude,
    required this.altitudeDiff,
    required this.ppi0,
    required this.ppi1,
    required this.ppi2,
    required this.synced,
    required this.createdAt,
    required this.locationSource,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['device_id'] = Variable<String>(deviceId);
    map['timestamp'] = Variable<int>(timestamp);
    map['heart_rate'] = Variable<int>(heartRate);
    map['status_index'] = Variable<int>(statusIndex);
    map['status_level'] = Variable<int>(statusLevel);
    map['temperature'] = Variable<int>(temperature);
    map['humidity'] = Variable<int>(humidity);
    map['heat_index'] = Variable<int>(heatIndex);
    map['heat_index_max'] = Variable<int>(heatIndexMax);
    map['fall_state'] = Variable<int>(fallState);
    map['battery_level'] = Variable<int>(batteryLevel);
    map['latitude'] = Variable<int>(latitude);
    map['longitude'] = Variable<int>(longitude);
    map['altitude_diff'] = Variable<int>(altitudeDiff);
    map['ppi0'] = Variable<int>(ppi0);
    map['ppi1'] = Variable<int>(ppi1);
    map['ppi2'] = Variable<int>(ppi2);
    map['synced'] = Variable<bool>(synced);
    map['created_at'] = Variable<int>(createdAt);
    map['location_source'] = Variable<String>(locationSource);
    return map;
  }

  SensingDataEntriesCompanion toCompanion(bool nullToAbsent) {
    return SensingDataEntriesCompanion(
      id: Value(id),
      deviceId: Value(deviceId),
      timestamp: Value(timestamp),
      heartRate: Value(heartRate),
      statusIndex: Value(statusIndex),
      statusLevel: Value(statusLevel),
      temperature: Value(temperature),
      humidity: Value(humidity),
      heatIndex: Value(heatIndex),
      heatIndexMax: Value(heatIndexMax),
      fallState: Value(fallState),
      batteryLevel: Value(batteryLevel),
      latitude: Value(latitude),
      longitude: Value(longitude),
      altitudeDiff: Value(altitudeDiff),
      ppi0: Value(ppi0),
      ppi1: Value(ppi1),
      ppi2: Value(ppi2),
      synced: Value(synced),
      createdAt: Value(createdAt),
      locationSource: Value(locationSource),
    );
  }

  factory SensingDataEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SensingDataEntry(
      id: serializer.fromJson<int>(json['id']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      heartRate: serializer.fromJson<int>(json['heartRate']),
      statusIndex: serializer.fromJson<int>(json['statusIndex']),
      statusLevel: serializer.fromJson<int>(json['statusLevel']),
      temperature: serializer.fromJson<int>(json['temperature']),
      humidity: serializer.fromJson<int>(json['humidity']),
      heatIndex: serializer.fromJson<int>(json['heatIndex']),
      heatIndexMax: serializer.fromJson<int>(json['heatIndexMax']),
      fallState: serializer.fromJson<int>(json['fallState']),
      batteryLevel: serializer.fromJson<int>(json['batteryLevel']),
      latitude: serializer.fromJson<int>(json['latitude']),
      longitude: serializer.fromJson<int>(json['longitude']),
      altitudeDiff: serializer.fromJson<int>(json['altitudeDiff']),
      ppi0: serializer.fromJson<int>(json['ppi0']),
      ppi1: serializer.fromJson<int>(json['ppi1']),
      ppi2: serializer.fromJson<int>(json['ppi2']),
      synced: serializer.fromJson<bool>(json['synced']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      locationSource: serializer.fromJson<String>(json['locationSource']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'deviceId': serializer.toJson<String>(deviceId),
      'timestamp': serializer.toJson<int>(timestamp),
      'heartRate': serializer.toJson<int>(heartRate),
      'statusIndex': serializer.toJson<int>(statusIndex),
      'statusLevel': serializer.toJson<int>(statusLevel),
      'temperature': serializer.toJson<int>(temperature),
      'humidity': serializer.toJson<int>(humidity),
      'heatIndex': serializer.toJson<int>(heatIndex),
      'heatIndexMax': serializer.toJson<int>(heatIndexMax),
      'fallState': serializer.toJson<int>(fallState),
      'batteryLevel': serializer.toJson<int>(batteryLevel),
      'latitude': serializer.toJson<int>(latitude),
      'longitude': serializer.toJson<int>(longitude),
      'altitudeDiff': serializer.toJson<int>(altitudeDiff),
      'ppi0': serializer.toJson<int>(ppi0),
      'ppi1': serializer.toJson<int>(ppi1),
      'ppi2': serializer.toJson<int>(ppi2),
      'synced': serializer.toJson<bool>(synced),
      'createdAt': serializer.toJson<int>(createdAt),
      'locationSource': serializer.toJson<String>(locationSource),
    };
  }

  SensingDataEntry copyWith({
    int? id,
    String? deviceId,
    int? timestamp,
    int? heartRate,
    int? statusIndex,
    int? statusLevel,
    int? temperature,
    int? humidity,
    int? heatIndex,
    int? heatIndexMax,
    int? fallState,
    int? batteryLevel,
    int? latitude,
    int? longitude,
    int? altitudeDiff,
    int? ppi0,
    int? ppi1,
    int? ppi2,
    bool? synced,
    int? createdAt,
    String? locationSource,
  }) => SensingDataEntry(
    id: id ?? this.id,
    deviceId: deviceId ?? this.deviceId,
    timestamp: timestamp ?? this.timestamp,
    heartRate: heartRate ?? this.heartRate,
    statusIndex: statusIndex ?? this.statusIndex,
    statusLevel: statusLevel ?? this.statusLevel,
    temperature: temperature ?? this.temperature,
    humidity: humidity ?? this.humidity,
    heatIndex: heatIndex ?? this.heatIndex,
    heatIndexMax: heatIndexMax ?? this.heatIndexMax,
    fallState: fallState ?? this.fallState,
    batteryLevel: batteryLevel ?? this.batteryLevel,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    altitudeDiff: altitudeDiff ?? this.altitudeDiff,
    ppi0: ppi0 ?? this.ppi0,
    ppi1: ppi1 ?? this.ppi1,
    ppi2: ppi2 ?? this.ppi2,
    synced: synced ?? this.synced,
    createdAt: createdAt ?? this.createdAt,
    locationSource: locationSource ?? this.locationSource,
  );
  SensingDataEntry copyWithCompanion(SensingDataEntriesCompanion data) {
    return SensingDataEntry(
      id: data.id.present ? data.id.value : this.id,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      heartRate: data.heartRate.present ? data.heartRate.value : this.heartRate,
      statusIndex: data.statusIndex.present
          ? data.statusIndex.value
          : this.statusIndex,
      statusLevel: data.statusLevel.present
          ? data.statusLevel.value
          : this.statusLevel,
      temperature: data.temperature.present
          ? data.temperature.value
          : this.temperature,
      humidity: data.humidity.present ? data.humidity.value : this.humidity,
      heatIndex: data.heatIndex.present ? data.heatIndex.value : this.heatIndex,
      heatIndexMax: data.heatIndexMax.present
          ? data.heatIndexMax.value
          : this.heatIndexMax,
      fallState: data.fallState.present ? data.fallState.value : this.fallState,
      batteryLevel: data.batteryLevel.present
          ? data.batteryLevel.value
          : this.batteryLevel,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      altitudeDiff: data.altitudeDiff.present
          ? data.altitudeDiff.value
          : this.altitudeDiff,
      ppi0: data.ppi0.present ? data.ppi0.value : this.ppi0,
      ppi1: data.ppi1.present ? data.ppi1.value : this.ppi1,
      ppi2: data.ppi2.present ? data.ppi2.value : this.ppi2,
      synced: data.synced.present ? data.synced.value : this.synced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      locationSource: data.locationSource.present
          ? data.locationSource.value
          : this.locationSource,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SensingDataEntry(')
          ..write('id: $id, ')
          ..write('deviceId: $deviceId, ')
          ..write('timestamp: $timestamp, ')
          ..write('heartRate: $heartRate, ')
          ..write('statusIndex: $statusIndex, ')
          ..write('statusLevel: $statusLevel, ')
          ..write('temperature: $temperature, ')
          ..write('humidity: $humidity, ')
          ..write('heatIndex: $heatIndex, ')
          ..write('heatIndexMax: $heatIndexMax, ')
          ..write('fallState: $fallState, ')
          ..write('batteryLevel: $batteryLevel, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('altitudeDiff: $altitudeDiff, ')
          ..write('ppi0: $ppi0, ')
          ..write('ppi1: $ppi1, ')
          ..write('ppi2: $ppi2, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt, ')
          ..write('locationSource: $locationSource')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    deviceId,
    timestamp,
    heartRate,
    statusIndex,
    statusLevel,
    temperature,
    humidity,
    heatIndex,
    heatIndexMax,
    fallState,
    batteryLevel,
    latitude,
    longitude,
    altitudeDiff,
    ppi0,
    ppi1,
    ppi2,
    synced,
    createdAt,
    locationSource,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SensingDataEntry &&
          other.id == this.id &&
          other.deviceId == this.deviceId &&
          other.timestamp == this.timestamp &&
          other.heartRate == this.heartRate &&
          other.statusIndex == this.statusIndex &&
          other.statusLevel == this.statusLevel &&
          other.temperature == this.temperature &&
          other.humidity == this.humidity &&
          other.heatIndex == this.heatIndex &&
          other.heatIndexMax == this.heatIndexMax &&
          other.fallState == this.fallState &&
          other.batteryLevel == this.batteryLevel &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.altitudeDiff == this.altitudeDiff &&
          other.ppi0 == this.ppi0 &&
          other.ppi1 == this.ppi1 &&
          other.ppi2 == this.ppi2 &&
          other.synced == this.synced &&
          other.createdAt == this.createdAt &&
          other.locationSource == this.locationSource);
}

class SensingDataEntriesCompanion extends UpdateCompanion<SensingDataEntry> {
  final Value<int> id;
  final Value<String> deviceId;
  final Value<int> timestamp;
  final Value<int> heartRate;
  final Value<int> statusIndex;
  final Value<int> statusLevel;
  final Value<int> temperature;
  final Value<int> humidity;
  final Value<int> heatIndex;
  final Value<int> heatIndexMax;
  final Value<int> fallState;
  final Value<int> batteryLevel;
  final Value<int> latitude;
  final Value<int> longitude;
  final Value<int> altitudeDiff;
  final Value<int> ppi0;
  final Value<int> ppi1;
  final Value<int> ppi2;
  final Value<bool> synced;
  final Value<int> createdAt;
  final Value<String> locationSource;
  const SensingDataEntriesCompanion({
    this.id = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.heartRate = const Value.absent(),
    this.statusIndex = const Value.absent(),
    this.statusLevel = const Value.absent(),
    this.temperature = const Value.absent(),
    this.humidity = const Value.absent(),
    this.heatIndex = const Value.absent(),
    this.heatIndexMax = const Value.absent(),
    this.fallState = const Value.absent(),
    this.batteryLevel = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.altitudeDiff = const Value.absent(),
    this.ppi0 = const Value.absent(),
    this.ppi1 = const Value.absent(),
    this.ppi2 = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.locationSource = const Value.absent(),
  });
  SensingDataEntriesCompanion.insert({
    this.id = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.heartRate = const Value.absent(),
    this.statusIndex = const Value.absent(),
    this.statusLevel = const Value.absent(),
    this.temperature = const Value.absent(),
    this.humidity = const Value.absent(),
    this.heatIndex = const Value.absent(),
    this.heatIndexMax = const Value.absent(),
    this.fallState = const Value.absent(),
    this.batteryLevel = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.altitudeDiff = const Value.absent(),
    this.ppi0 = const Value.absent(),
    this.ppi1 = const Value.absent(),
    this.ppi2 = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.locationSource = const Value.absent(),
  });
  static Insertable<SensingDataEntry> custom({
    Expression<int>? id,
    Expression<String>? deviceId,
    Expression<int>? timestamp,
    Expression<int>? heartRate,
    Expression<int>? statusIndex,
    Expression<int>? statusLevel,
    Expression<int>? temperature,
    Expression<int>? humidity,
    Expression<int>? heatIndex,
    Expression<int>? heatIndexMax,
    Expression<int>? fallState,
    Expression<int>? batteryLevel,
    Expression<int>? latitude,
    Expression<int>? longitude,
    Expression<int>? altitudeDiff,
    Expression<int>? ppi0,
    Expression<int>? ppi1,
    Expression<int>? ppi2,
    Expression<bool>? synced,
    Expression<int>? createdAt,
    Expression<String>? locationSource,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deviceId != null) 'device_id': deviceId,
      if (timestamp != null) 'timestamp': timestamp,
      if (heartRate != null) 'heart_rate': heartRate,
      if (statusIndex != null) 'status_index': statusIndex,
      if (statusLevel != null) 'status_level': statusLevel,
      if (temperature != null) 'temperature': temperature,
      if (humidity != null) 'humidity': humidity,
      if (heatIndex != null) 'heat_index': heatIndex,
      if (heatIndexMax != null) 'heat_index_max': heatIndexMax,
      if (fallState != null) 'fall_state': fallState,
      if (batteryLevel != null) 'battery_level': batteryLevel,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (altitudeDiff != null) 'altitude_diff': altitudeDiff,
      if (ppi0 != null) 'ppi0': ppi0,
      if (ppi1 != null) 'ppi1': ppi1,
      if (ppi2 != null) 'ppi2': ppi2,
      if (synced != null) 'synced': synced,
      if (createdAt != null) 'created_at': createdAt,
      if (locationSource != null) 'location_source': locationSource,
    });
  }

  SensingDataEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? deviceId,
    Value<int>? timestamp,
    Value<int>? heartRate,
    Value<int>? statusIndex,
    Value<int>? statusLevel,
    Value<int>? temperature,
    Value<int>? humidity,
    Value<int>? heatIndex,
    Value<int>? heatIndexMax,
    Value<int>? fallState,
    Value<int>? batteryLevel,
    Value<int>? latitude,
    Value<int>? longitude,
    Value<int>? altitudeDiff,
    Value<int>? ppi0,
    Value<int>? ppi1,
    Value<int>? ppi2,
    Value<bool>? synced,
    Value<int>? createdAt,
    Value<String>? locationSource,
  }) {
    return SensingDataEntriesCompanion(
      id: id ?? this.id,
      deviceId: deviceId ?? this.deviceId,
      timestamp: timestamp ?? this.timestamp,
      heartRate: heartRate ?? this.heartRate,
      statusIndex: statusIndex ?? this.statusIndex,
      statusLevel: statusLevel ?? this.statusLevel,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      heatIndex: heatIndex ?? this.heatIndex,
      heatIndexMax: heatIndexMax ?? this.heatIndexMax,
      fallState: fallState ?? this.fallState,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      altitudeDiff: altitudeDiff ?? this.altitudeDiff,
      ppi0: ppi0 ?? this.ppi0,
      ppi1: ppi1 ?? this.ppi1,
      ppi2: ppi2 ?? this.ppi2,
      synced: synced ?? this.synced,
      createdAt: createdAt ?? this.createdAt,
      locationSource: locationSource ?? this.locationSource,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (heartRate.present) {
      map['heart_rate'] = Variable<int>(heartRate.value);
    }
    if (statusIndex.present) {
      map['status_index'] = Variable<int>(statusIndex.value);
    }
    if (statusLevel.present) {
      map['status_level'] = Variable<int>(statusLevel.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<int>(temperature.value);
    }
    if (humidity.present) {
      map['humidity'] = Variable<int>(humidity.value);
    }
    if (heatIndex.present) {
      map['heat_index'] = Variable<int>(heatIndex.value);
    }
    if (heatIndexMax.present) {
      map['heat_index_max'] = Variable<int>(heatIndexMax.value);
    }
    if (fallState.present) {
      map['fall_state'] = Variable<int>(fallState.value);
    }
    if (batteryLevel.present) {
      map['battery_level'] = Variable<int>(batteryLevel.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<int>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<int>(longitude.value);
    }
    if (altitudeDiff.present) {
      map['altitude_diff'] = Variable<int>(altitudeDiff.value);
    }
    if (ppi0.present) {
      map['ppi0'] = Variable<int>(ppi0.value);
    }
    if (ppi1.present) {
      map['ppi1'] = Variable<int>(ppi1.value);
    }
    if (ppi2.present) {
      map['ppi2'] = Variable<int>(ppi2.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (locationSource.present) {
      map['location_source'] = Variable<String>(locationSource.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SensingDataEntriesCompanion(')
          ..write('id: $id, ')
          ..write('deviceId: $deviceId, ')
          ..write('timestamp: $timestamp, ')
          ..write('heartRate: $heartRate, ')
          ..write('statusIndex: $statusIndex, ')
          ..write('statusLevel: $statusLevel, ')
          ..write('temperature: $temperature, ')
          ..write('humidity: $humidity, ')
          ..write('heatIndex: $heatIndex, ')
          ..write('heatIndexMax: $heatIndexMax, ')
          ..write('fallState: $fallState, ')
          ..write('batteryLevel: $batteryLevel, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('altitudeDiff: $altitudeDiff, ')
          ..write('ppi0: $ppi0, ')
          ..write('ppi1: $ppi1, ')
          ..write('ppi2: $ppi2, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt, ')
          ..write('locationSource: $locationSource')
          ..write(')'))
        .toString();
  }
}

class $FallEventEntriesTable extends FallEventEntries
    with TableInfo<$FallEventEntriesTable, FallEventEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FallEventEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<int> timestamp = GeneratedColumn<int>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<int> latitude = GeneratedColumn<int>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<int> longitude = GeneratedColumn<int>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _elapsedSecondsMeta = const VerificationMeta(
    'elapsedSeconds',
  );
  @override
  late final GeneratedColumn<int> elapsedSeconds = GeneratedColumn<int>(
    'elapsed_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusLevelMeta = const VerificationMeta(
    'statusLevel',
  );
  @override
  late final GeneratedColumn<int> statusLevel = GeneratedColumn<int>(
    'status_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _heatIndexMeta = const VerificationMeta(
    'heatIndex',
  );
  @override
  late final GeneratedColumn<int> heatIndex = GeneratedColumn<int>(
    'heat_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('REALTIME_SENSING'),
  );
  static const VerificationMeta _uploadedMeta = const VerificationMeta(
    'uploaded',
  );
  @override
  late final GeneratedColumn<bool> uploaded = GeneratedColumn<bool>(
    'uploaded',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("uploaded" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _heartRateMeta = const VerificationMeta(
    'heartRate',
  );
  @override
  late final GeneratedColumn<int> heartRate = GeneratedColumn<int>(
    'heart_rate',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _temperatureMeta = const VerificationMeta(
    'temperature',
  );
  @override
  late final GeneratedColumn<int> temperature = GeneratedColumn<int>(
    'temperature',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _humidityMeta = const VerificationMeta(
    'humidity',
  );
  @override
  late final GeneratedColumn<int> humidity = GeneratedColumn<int>(
    'humidity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _heatIndexMaxMeta = const VerificationMeta(
    'heatIndexMax',
  );
  @override
  late final GeneratedColumn<int> heatIndexMax = GeneratedColumn<int>(
    'heat_index_max',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _fallStateMeta = const VerificationMeta(
    'fallState',
  );
  @override
  late final GeneratedColumn<int> fallState = GeneratedColumn<int>(
    'fall_state',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _batteryLevelMeta = const VerificationMeta(
    'batteryLevel',
  );
  @override
  late final GeneratedColumn<int> batteryLevel = GeneratedColumn<int>(
    'battery_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _altitudeDiffMeta = const VerificationMeta(
    'altitudeDiff',
  );
  @override
  late final GeneratedColumn<int> altitudeDiff = GeneratedColumn<int>(
    'altitude_diff',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusIndexMeta = const VerificationMeta(
    'statusIndex',
  );
  @override
  late final GeneratedColumn<int> statusIndex = GeneratedColumn<int>(
    'status_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _ppi0Meta = const VerificationMeta('ppi0');
  @override
  late final GeneratedColumn<int> ppi0 = GeneratedColumn<int>(
    'ppi0',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _ppi1Meta = const VerificationMeta('ppi1');
  @override
  late final GeneratedColumn<int> ppi1 = GeneratedColumn<int>(
    'ppi1',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _ppi2Meta = const VerificationMeta('ppi2');
  @override
  late final GeneratedColumn<int> ppi2 = GeneratedColumn<int>(
    'ppi2',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _userNameMeta = const VerificationMeta(
    'userName',
  );
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
    'user_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _locationSourceMeta = const VerificationMeta(
    'locationSource',
  );
  @override
  late final GeneratedColumn<String> locationSource = GeneratedColumn<String>(
    'location_source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('MS200'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    deviceId,
    timestamp,
    latitude,
    longitude,
    elapsedSeconds,
    statusLevel,
    heatIndex,
    source,
    uploaded,
    createdAt,
    heartRate,
    temperature,
    humidity,
    heatIndexMax,
    fallState,
    batteryLevel,
    altitudeDiff,
    statusIndex,
    ppi0,
    ppi1,
    ppi2,
    userName,
    locationSource,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fall_event_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<FallEventEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('elapsed_seconds')) {
      context.handle(
        _elapsedSecondsMeta,
        elapsedSeconds.isAcceptableOrUnknown(
          data['elapsed_seconds']!,
          _elapsedSecondsMeta,
        ),
      );
    }
    if (data.containsKey('status_level')) {
      context.handle(
        _statusLevelMeta,
        statusLevel.isAcceptableOrUnknown(
          data['status_level']!,
          _statusLevelMeta,
        ),
      );
    }
    if (data.containsKey('heat_index')) {
      context.handle(
        _heatIndexMeta,
        heatIndex.isAcceptableOrUnknown(data['heat_index']!, _heatIndexMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('uploaded')) {
      context.handle(
        _uploadedMeta,
        uploaded.isAcceptableOrUnknown(data['uploaded']!, _uploadedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('heart_rate')) {
      context.handle(
        _heartRateMeta,
        heartRate.isAcceptableOrUnknown(data['heart_rate']!, _heartRateMeta),
      );
    }
    if (data.containsKey('temperature')) {
      context.handle(
        _temperatureMeta,
        temperature.isAcceptableOrUnknown(
          data['temperature']!,
          _temperatureMeta,
        ),
      );
    }
    if (data.containsKey('humidity')) {
      context.handle(
        _humidityMeta,
        humidity.isAcceptableOrUnknown(data['humidity']!, _humidityMeta),
      );
    }
    if (data.containsKey('heat_index_max')) {
      context.handle(
        _heatIndexMaxMeta,
        heatIndexMax.isAcceptableOrUnknown(
          data['heat_index_max']!,
          _heatIndexMaxMeta,
        ),
      );
    }
    if (data.containsKey('fall_state')) {
      context.handle(
        _fallStateMeta,
        fallState.isAcceptableOrUnknown(data['fall_state']!, _fallStateMeta),
      );
    }
    if (data.containsKey('battery_level')) {
      context.handle(
        _batteryLevelMeta,
        batteryLevel.isAcceptableOrUnknown(
          data['battery_level']!,
          _batteryLevelMeta,
        ),
      );
    }
    if (data.containsKey('altitude_diff')) {
      context.handle(
        _altitudeDiffMeta,
        altitudeDiff.isAcceptableOrUnknown(
          data['altitude_diff']!,
          _altitudeDiffMeta,
        ),
      );
    }
    if (data.containsKey('status_index')) {
      context.handle(
        _statusIndexMeta,
        statusIndex.isAcceptableOrUnknown(
          data['status_index']!,
          _statusIndexMeta,
        ),
      );
    }
    if (data.containsKey('ppi0')) {
      context.handle(
        _ppi0Meta,
        ppi0.isAcceptableOrUnknown(data['ppi0']!, _ppi0Meta),
      );
    }
    if (data.containsKey('ppi1')) {
      context.handle(
        _ppi1Meta,
        ppi1.isAcceptableOrUnknown(data['ppi1']!, _ppi1Meta),
      );
    }
    if (data.containsKey('ppi2')) {
      context.handle(
        _ppi2Meta,
        ppi2.isAcceptableOrUnknown(data['ppi2']!, _ppi2Meta),
      );
    }
    if (data.containsKey('user_name')) {
      context.handle(
        _userNameMeta,
        userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta),
      );
    }
    if (data.containsKey('location_source')) {
      context.handle(
        _locationSourceMeta,
        locationSource.isAcceptableOrUnknown(
          data['location_source']!,
          _locationSourceMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FallEventEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FallEventEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}longitude'],
      )!,
      elapsedSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elapsed_seconds'],
      )!,
      statusLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status_level'],
      )!,
      heatIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}heat_index'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      uploaded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}uploaded'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      heartRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}heart_rate'],
      )!,
      temperature: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}temperature'],
      )!,
      humidity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}humidity'],
      )!,
      heatIndexMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}heat_index_max'],
      )!,
      fallState: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fall_state'],
      )!,
      batteryLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}battery_level'],
      )!,
      altitudeDiff: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}altitude_diff'],
      )!,
      statusIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status_index'],
      )!,
      ppi0: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ppi0'],
      )!,
      ppi1: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ppi1'],
      )!,
      ppi2: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ppi2'],
      )!,
      userName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_name'],
      )!,
      locationSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location_source'],
      )!,
    );
  }

  @override
  $FallEventEntriesTable createAlias(String alias) {
    return $FallEventEntriesTable(attachedDatabase, alias);
  }
}

class FallEventEntry extends DataClass implements Insertable<FallEventEntry> {
  final int id;
  final String deviceId;
  final int timestamp;
  final int latitude;
  final int longitude;
  final int elapsedSeconds;
  final int statusLevel;
  final int heatIndex;
  final String source;
  final bool uploaded;
  final int createdAt;
  final int heartRate;
  final int temperature;
  final int humidity;
  final int heatIndexMax;
  final int fallState;
  final int batteryLevel;
  final int altitudeDiff;
  final int statusIndex;
  final int ppi0;
  final int ppi1;
  final int ppi2;
  final String userName;
  final String locationSource;
  const FallEventEntry({
    required this.id,
    required this.deviceId,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    required this.elapsedSeconds,
    required this.statusLevel,
    required this.heatIndex,
    required this.source,
    required this.uploaded,
    required this.createdAt,
    required this.heartRate,
    required this.temperature,
    required this.humidity,
    required this.heatIndexMax,
    required this.fallState,
    required this.batteryLevel,
    required this.altitudeDiff,
    required this.statusIndex,
    required this.ppi0,
    required this.ppi1,
    required this.ppi2,
    required this.userName,
    required this.locationSource,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['device_id'] = Variable<String>(deviceId);
    map['timestamp'] = Variable<int>(timestamp);
    map['latitude'] = Variable<int>(latitude);
    map['longitude'] = Variable<int>(longitude);
    map['elapsed_seconds'] = Variable<int>(elapsedSeconds);
    map['status_level'] = Variable<int>(statusLevel);
    map['heat_index'] = Variable<int>(heatIndex);
    map['source'] = Variable<String>(source);
    map['uploaded'] = Variable<bool>(uploaded);
    map['created_at'] = Variable<int>(createdAt);
    map['heart_rate'] = Variable<int>(heartRate);
    map['temperature'] = Variable<int>(temperature);
    map['humidity'] = Variable<int>(humidity);
    map['heat_index_max'] = Variable<int>(heatIndexMax);
    map['fall_state'] = Variable<int>(fallState);
    map['battery_level'] = Variable<int>(batteryLevel);
    map['altitude_diff'] = Variable<int>(altitudeDiff);
    map['status_index'] = Variable<int>(statusIndex);
    map['ppi0'] = Variable<int>(ppi0);
    map['ppi1'] = Variable<int>(ppi1);
    map['ppi2'] = Variable<int>(ppi2);
    map['user_name'] = Variable<String>(userName);
    map['location_source'] = Variable<String>(locationSource);
    return map;
  }

  FallEventEntriesCompanion toCompanion(bool nullToAbsent) {
    return FallEventEntriesCompanion(
      id: Value(id),
      deviceId: Value(deviceId),
      timestamp: Value(timestamp),
      latitude: Value(latitude),
      longitude: Value(longitude),
      elapsedSeconds: Value(elapsedSeconds),
      statusLevel: Value(statusLevel),
      heatIndex: Value(heatIndex),
      source: Value(source),
      uploaded: Value(uploaded),
      createdAt: Value(createdAt),
      heartRate: Value(heartRate),
      temperature: Value(temperature),
      humidity: Value(humidity),
      heatIndexMax: Value(heatIndexMax),
      fallState: Value(fallState),
      batteryLevel: Value(batteryLevel),
      altitudeDiff: Value(altitudeDiff),
      statusIndex: Value(statusIndex),
      ppi0: Value(ppi0),
      ppi1: Value(ppi1),
      ppi2: Value(ppi2),
      userName: Value(userName),
      locationSource: Value(locationSource),
    );
  }

  factory FallEventEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FallEventEntry(
      id: serializer.fromJson<int>(json['id']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      latitude: serializer.fromJson<int>(json['latitude']),
      longitude: serializer.fromJson<int>(json['longitude']),
      elapsedSeconds: serializer.fromJson<int>(json['elapsedSeconds']),
      statusLevel: serializer.fromJson<int>(json['statusLevel']),
      heatIndex: serializer.fromJson<int>(json['heatIndex']),
      source: serializer.fromJson<String>(json['source']),
      uploaded: serializer.fromJson<bool>(json['uploaded']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      heartRate: serializer.fromJson<int>(json['heartRate']),
      temperature: serializer.fromJson<int>(json['temperature']),
      humidity: serializer.fromJson<int>(json['humidity']),
      heatIndexMax: serializer.fromJson<int>(json['heatIndexMax']),
      fallState: serializer.fromJson<int>(json['fallState']),
      batteryLevel: serializer.fromJson<int>(json['batteryLevel']),
      altitudeDiff: serializer.fromJson<int>(json['altitudeDiff']),
      statusIndex: serializer.fromJson<int>(json['statusIndex']),
      ppi0: serializer.fromJson<int>(json['ppi0']),
      ppi1: serializer.fromJson<int>(json['ppi1']),
      ppi2: serializer.fromJson<int>(json['ppi2']),
      userName: serializer.fromJson<String>(json['userName']),
      locationSource: serializer.fromJson<String>(json['locationSource']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'deviceId': serializer.toJson<String>(deviceId),
      'timestamp': serializer.toJson<int>(timestamp),
      'latitude': serializer.toJson<int>(latitude),
      'longitude': serializer.toJson<int>(longitude),
      'elapsedSeconds': serializer.toJson<int>(elapsedSeconds),
      'statusLevel': serializer.toJson<int>(statusLevel),
      'heatIndex': serializer.toJson<int>(heatIndex),
      'source': serializer.toJson<String>(source),
      'uploaded': serializer.toJson<bool>(uploaded),
      'createdAt': serializer.toJson<int>(createdAt),
      'heartRate': serializer.toJson<int>(heartRate),
      'temperature': serializer.toJson<int>(temperature),
      'humidity': serializer.toJson<int>(humidity),
      'heatIndexMax': serializer.toJson<int>(heatIndexMax),
      'fallState': serializer.toJson<int>(fallState),
      'batteryLevel': serializer.toJson<int>(batteryLevel),
      'altitudeDiff': serializer.toJson<int>(altitudeDiff),
      'statusIndex': serializer.toJson<int>(statusIndex),
      'ppi0': serializer.toJson<int>(ppi0),
      'ppi1': serializer.toJson<int>(ppi1),
      'ppi2': serializer.toJson<int>(ppi2),
      'userName': serializer.toJson<String>(userName),
      'locationSource': serializer.toJson<String>(locationSource),
    };
  }

  FallEventEntry copyWith({
    int? id,
    String? deviceId,
    int? timestamp,
    int? latitude,
    int? longitude,
    int? elapsedSeconds,
    int? statusLevel,
    int? heatIndex,
    String? source,
    bool? uploaded,
    int? createdAt,
    int? heartRate,
    int? temperature,
    int? humidity,
    int? heatIndexMax,
    int? fallState,
    int? batteryLevel,
    int? altitudeDiff,
    int? statusIndex,
    int? ppi0,
    int? ppi1,
    int? ppi2,
    String? userName,
    String? locationSource,
  }) => FallEventEntry(
    id: id ?? this.id,
    deviceId: deviceId ?? this.deviceId,
    timestamp: timestamp ?? this.timestamp,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    statusLevel: statusLevel ?? this.statusLevel,
    heatIndex: heatIndex ?? this.heatIndex,
    source: source ?? this.source,
    uploaded: uploaded ?? this.uploaded,
    createdAt: createdAt ?? this.createdAt,
    heartRate: heartRate ?? this.heartRate,
    temperature: temperature ?? this.temperature,
    humidity: humidity ?? this.humidity,
    heatIndexMax: heatIndexMax ?? this.heatIndexMax,
    fallState: fallState ?? this.fallState,
    batteryLevel: batteryLevel ?? this.batteryLevel,
    altitudeDiff: altitudeDiff ?? this.altitudeDiff,
    statusIndex: statusIndex ?? this.statusIndex,
    ppi0: ppi0 ?? this.ppi0,
    ppi1: ppi1 ?? this.ppi1,
    ppi2: ppi2 ?? this.ppi2,
    userName: userName ?? this.userName,
    locationSource: locationSource ?? this.locationSource,
  );
  FallEventEntry copyWithCompanion(FallEventEntriesCompanion data) {
    return FallEventEntry(
      id: data.id.present ? data.id.value : this.id,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      elapsedSeconds: data.elapsedSeconds.present
          ? data.elapsedSeconds.value
          : this.elapsedSeconds,
      statusLevel: data.statusLevel.present
          ? data.statusLevel.value
          : this.statusLevel,
      heatIndex: data.heatIndex.present ? data.heatIndex.value : this.heatIndex,
      source: data.source.present ? data.source.value : this.source,
      uploaded: data.uploaded.present ? data.uploaded.value : this.uploaded,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      heartRate: data.heartRate.present ? data.heartRate.value : this.heartRate,
      temperature: data.temperature.present
          ? data.temperature.value
          : this.temperature,
      humidity: data.humidity.present ? data.humidity.value : this.humidity,
      heatIndexMax: data.heatIndexMax.present
          ? data.heatIndexMax.value
          : this.heatIndexMax,
      fallState: data.fallState.present ? data.fallState.value : this.fallState,
      batteryLevel: data.batteryLevel.present
          ? data.batteryLevel.value
          : this.batteryLevel,
      altitudeDiff: data.altitudeDiff.present
          ? data.altitudeDiff.value
          : this.altitudeDiff,
      statusIndex: data.statusIndex.present
          ? data.statusIndex.value
          : this.statusIndex,
      ppi0: data.ppi0.present ? data.ppi0.value : this.ppi0,
      ppi1: data.ppi1.present ? data.ppi1.value : this.ppi1,
      ppi2: data.ppi2.present ? data.ppi2.value : this.ppi2,
      userName: data.userName.present ? data.userName.value : this.userName,
      locationSource: data.locationSource.present
          ? data.locationSource.value
          : this.locationSource,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FallEventEntry(')
          ..write('id: $id, ')
          ..write('deviceId: $deviceId, ')
          ..write('timestamp: $timestamp, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('elapsedSeconds: $elapsedSeconds, ')
          ..write('statusLevel: $statusLevel, ')
          ..write('heatIndex: $heatIndex, ')
          ..write('source: $source, ')
          ..write('uploaded: $uploaded, ')
          ..write('createdAt: $createdAt, ')
          ..write('heartRate: $heartRate, ')
          ..write('temperature: $temperature, ')
          ..write('humidity: $humidity, ')
          ..write('heatIndexMax: $heatIndexMax, ')
          ..write('fallState: $fallState, ')
          ..write('batteryLevel: $batteryLevel, ')
          ..write('altitudeDiff: $altitudeDiff, ')
          ..write('statusIndex: $statusIndex, ')
          ..write('ppi0: $ppi0, ')
          ..write('ppi1: $ppi1, ')
          ..write('ppi2: $ppi2, ')
          ..write('userName: $userName, ')
          ..write('locationSource: $locationSource')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    deviceId,
    timestamp,
    latitude,
    longitude,
    elapsedSeconds,
    statusLevel,
    heatIndex,
    source,
    uploaded,
    createdAt,
    heartRate,
    temperature,
    humidity,
    heatIndexMax,
    fallState,
    batteryLevel,
    altitudeDiff,
    statusIndex,
    ppi0,
    ppi1,
    ppi2,
    userName,
    locationSource,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FallEventEntry &&
          other.id == this.id &&
          other.deviceId == this.deviceId &&
          other.timestamp == this.timestamp &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.elapsedSeconds == this.elapsedSeconds &&
          other.statusLevel == this.statusLevel &&
          other.heatIndex == this.heatIndex &&
          other.source == this.source &&
          other.uploaded == this.uploaded &&
          other.createdAt == this.createdAt &&
          other.heartRate == this.heartRate &&
          other.temperature == this.temperature &&
          other.humidity == this.humidity &&
          other.heatIndexMax == this.heatIndexMax &&
          other.fallState == this.fallState &&
          other.batteryLevel == this.batteryLevel &&
          other.altitudeDiff == this.altitudeDiff &&
          other.statusIndex == this.statusIndex &&
          other.ppi0 == this.ppi0 &&
          other.ppi1 == this.ppi1 &&
          other.ppi2 == this.ppi2 &&
          other.userName == this.userName &&
          other.locationSource == this.locationSource);
}

class FallEventEntriesCompanion extends UpdateCompanion<FallEventEntry> {
  final Value<int> id;
  final Value<String> deviceId;
  final Value<int> timestamp;
  final Value<int> latitude;
  final Value<int> longitude;
  final Value<int> elapsedSeconds;
  final Value<int> statusLevel;
  final Value<int> heatIndex;
  final Value<String> source;
  final Value<bool> uploaded;
  final Value<int> createdAt;
  final Value<int> heartRate;
  final Value<int> temperature;
  final Value<int> humidity;
  final Value<int> heatIndexMax;
  final Value<int> fallState;
  final Value<int> batteryLevel;
  final Value<int> altitudeDiff;
  final Value<int> statusIndex;
  final Value<int> ppi0;
  final Value<int> ppi1;
  final Value<int> ppi2;
  final Value<String> userName;
  final Value<String> locationSource;
  const FallEventEntriesCompanion({
    this.id = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.elapsedSeconds = const Value.absent(),
    this.statusLevel = const Value.absent(),
    this.heatIndex = const Value.absent(),
    this.source = const Value.absent(),
    this.uploaded = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.heartRate = const Value.absent(),
    this.temperature = const Value.absent(),
    this.humidity = const Value.absent(),
    this.heatIndexMax = const Value.absent(),
    this.fallState = const Value.absent(),
    this.batteryLevel = const Value.absent(),
    this.altitudeDiff = const Value.absent(),
    this.statusIndex = const Value.absent(),
    this.ppi0 = const Value.absent(),
    this.ppi1 = const Value.absent(),
    this.ppi2 = const Value.absent(),
    this.userName = const Value.absent(),
    this.locationSource = const Value.absent(),
  });
  FallEventEntriesCompanion.insert({
    this.id = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.elapsedSeconds = const Value.absent(),
    this.statusLevel = const Value.absent(),
    this.heatIndex = const Value.absent(),
    this.source = const Value.absent(),
    this.uploaded = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.heartRate = const Value.absent(),
    this.temperature = const Value.absent(),
    this.humidity = const Value.absent(),
    this.heatIndexMax = const Value.absent(),
    this.fallState = const Value.absent(),
    this.batteryLevel = const Value.absent(),
    this.altitudeDiff = const Value.absent(),
    this.statusIndex = const Value.absent(),
    this.ppi0 = const Value.absent(),
    this.ppi1 = const Value.absent(),
    this.ppi2 = const Value.absent(),
    this.userName = const Value.absent(),
    this.locationSource = const Value.absent(),
  });
  static Insertable<FallEventEntry> custom({
    Expression<int>? id,
    Expression<String>? deviceId,
    Expression<int>? timestamp,
    Expression<int>? latitude,
    Expression<int>? longitude,
    Expression<int>? elapsedSeconds,
    Expression<int>? statusLevel,
    Expression<int>? heatIndex,
    Expression<String>? source,
    Expression<bool>? uploaded,
    Expression<int>? createdAt,
    Expression<int>? heartRate,
    Expression<int>? temperature,
    Expression<int>? humidity,
    Expression<int>? heatIndexMax,
    Expression<int>? fallState,
    Expression<int>? batteryLevel,
    Expression<int>? altitudeDiff,
    Expression<int>? statusIndex,
    Expression<int>? ppi0,
    Expression<int>? ppi1,
    Expression<int>? ppi2,
    Expression<String>? userName,
    Expression<String>? locationSource,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deviceId != null) 'device_id': deviceId,
      if (timestamp != null) 'timestamp': timestamp,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (elapsedSeconds != null) 'elapsed_seconds': elapsedSeconds,
      if (statusLevel != null) 'status_level': statusLevel,
      if (heatIndex != null) 'heat_index': heatIndex,
      if (source != null) 'source': source,
      if (uploaded != null) 'uploaded': uploaded,
      if (createdAt != null) 'created_at': createdAt,
      if (heartRate != null) 'heart_rate': heartRate,
      if (temperature != null) 'temperature': temperature,
      if (humidity != null) 'humidity': humidity,
      if (heatIndexMax != null) 'heat_index_max': heatIndexMax,
      if (fallState != null) 'fall_state': fallState,
      if (batteryLevel != null) 'battery_level': batteryLevel,
      if (altitudeDiff != null) 'altitude_diff': altitudeDiff,
      if (statusIndex != null) 'status_index': statusIndex,
      if (ppi0 != null) 'ppi0': ppi0,
      if (ppi1 != null) 'ppi1': ppi1,
      if (ppi2 != null) 'ppi2': ppi2,
      if (userName != null) 'user_name': userName,
      if (locationSource != null) 'location_source': locationSource,
    });
  }

  FallEventEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? deviceId,
    Value<int>? timestamp,
    Value<int>? latitude,
    Value<int>? longitude,
    Value<int>? elapsedSeconds,
    Value<int>? statusLevel,
    Value<int>? heatIndex,
    Value<String>? source,
    Value<bool>? uploaded,
    Value<int>? createdAt,
    Value<int>? heartRate,
    Value<int>? temperature,
    Value<int>? humidity,
    Value<int>? heatIndexMax,
    Value<int>? fallState,
    Value<int>? batteryLevel,
    Value<int>? altitudeDiff,
    Value<int>? statusIndex,
    Value<int>? ppi0,
    Value<int>? ppi1,
    Value<int>? ppi2,
    Value<String>? userName,
    Value<String>? locationSource,
  }) {
    return FallEventEntriesCompanion(
      id: id ?? this.id,
      deviceId: deviceId ?? this.deviceId,
      timestamp: timestamp ?? this.timestamp,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      statusLevel: statusLevel ?? this.statusLevel,
      heatIndex: heatIndex ?? this.heatIndex,
      source: source ?? this.source,
      uploaded: uploaded ?? this.uploaded,
      createdAt: createdAt ?? this.createdAt,
      heartRate: heartRate ?? this.heartRate,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      heatIndexMax: heatIndexMax ?? this.heatIndexMax,
      fallState: fallState ?? this.fallState,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      altitudeDiff: altitudeDiff ?? this.altitudeDiff,
      statusIndex: statusIndex ?? this.statusIndex,
      ppi0: ppi0 ?? this.ppi0,
      ppi1: ppi1 ?? this.ppi1,
      ppi2: ppi2 ?? this.ppi2,
      userName: userName ?? this.userName,
      locationSource: locationSource ?? this.locationSource,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<int>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<int>(longitude.value);
    }
    if (elapsedSeconds.present) {
      map['elapsed_seconds'] = Variable<int>(elapsedSeconds.value);
    }
    if (statusLevel.present) {
      map['status_level'] = Variable<int>(statusLevel.value);
    }
    if (heatIndex.present) {
      map['heat_index'] = Variable<int>(heatIndex.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (uploaded.present) {
      map['uploaded'] = Variable<bool>(uploaded.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (heartRate.present) {
      map['heart_rate'] = Variable<int>(heartRate.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<int>(temperature.value);
    }
    if (humidity.present) {
      map['humidity'] = Variable<int>(humidity.value);
    }
    if (heatIndexMax.present) {
      map['heat_index_max'] = Variable<int>(heatIndexMax.value);
    }
    if (fallState.present) {
      map['fall_state'] = Variable<int>(fallState.value);
    }
    if (batteryLevel.present) {
      map['battery_level'] = Variable<int>(batteryLevel.value);
    }
    if (altitudeDiff.present) {
      map['altitude_diff'] = Variable<int>(altitudeDiff.value);
    }
    if (statusIndex.present) {
      map['status_index'] = Variable<int>(statusIndex.value);
    }
    if (ppi0.present) {
      map['ppi0'] = Variable<int>(ppi0.value);
    }
    if (ppi1.present) {
      map['ppi1'] = Variable<int>(ppi1.value);
    }
    if (ppi2.present) {
      map['ppi2'] = Variable<int>(ppi2.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (locationSource.present) {
      map['location_source'] = Variable<String>(locationSource.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FallEventEntriesCompanion(')
          ..write('id: $id, ')
          ..write('deviceId: $deviceId, ')
          ..write('timestamp: $timestamp, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('elapsedSeconds: $elapsedSeconds, ')
          ..write('statusLevel: $statusLevel, ')
          ..write('heatIndex: $heatIndex, ')
          ..write('source: $source, ')
          ..write('uploaded: $uploaded, ')
          ..write('createdAt: $createdAt, ')
          ..write('heartRate: $heartRate, ')
          ..write('temperature: $temperature, ')
          ..write('humidity: $humidity, ')
          ..write('heatIndexMax: $heatIndexMax, ')
          ..write('fallState: $fallState, ')
          ..write('batteryLevel: $batteryLevel, ')
          ..write('altitudeDiff: $altitudeDiff, ')
          ..write('statusIndex: $statusIndex, ')
          ..write('ppi0: $ppi0, ')
          ..write('ppi1: $ppi1, ')
          ..write('ppi2: $ppi2, ')
          ..write('userName: $userName, ')
          ..write('locationSource: $locationSource')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $SensingDataEntriesTable sensingDataEntries =
      $SensingDataEntriesTable(this);
  late final $FallEventEntriesTable fallEventEntries = $FallEventEntriesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    sensingDataEntries,
    fallEventEntries,
  ];
}

typedef $$SensingDataEntriesTableCreateCompanionBuilder =
    SensingDataEntriesCompanion Function({
      Value<int> id,
      Value<String> deviceId,
      Value<int> timestamp,
      Value<int> heartRate,
      Value<int> statusIndex,
      Value<int> statusLevel,
      Value<int> temperature,
      Value<int> humidity,
      Value<int> heatIndex,
      Value<int> heatIndexMax,
      Value<int> fallState,
      Value<int> batteryLevel,
      Value<int> latitude,
      Value<int> longitude,
      Value<int> altitudeDiff,
      Value<int> ppi0,
      Value<int> ppi1,
      Value<int> ppi2,
      Value<bool> synced,
      Value<int> createdAt,
      Value<String> locationSource,
    });
typedef $$SensingDataEntriesTableUpdateCompanionBuilder =
    SensingDataEntriesCompanion Function({
      Value<int> id,
      Value<String> deviceId,
      Value<int> timestamp,
      Value<int> heartRate,
      Value<int> statusIndex,
      Value<int> statusLevel,
      Value<int> temperature,
      Value<int> humidity,
      Value<int> heatIndex,
      Value<int> heatIndexMax,
      Value<int> fallState,
      Value<int> batteryLevel,
      Value<int> latitude,
      Value<int> longitude,
      Value<int> altitudeDiff,
      Value<int> ppi0,
      Value<int> ppi1,
      Value<int> ppi2,
      Value<bool> synced,
      Value<int> createdAt,
      Value<String> locationSource,
    });

class $$SensingDataEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SensingDataEntriesTable> {
  $$SensingDataEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heartRate => $composableBuilder(
    column: $table.heartRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get statusIndex => $composableBuilder(
    column: $table.statusIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get statusLevel => $composableBuilder(
    column: $table.statusLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get humidity => $composableBuilder(
    column: $table.humidity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heatIndex => $composableBuilder(
    column: $table.heatIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heatIndexMax => $composableBuilder(
    column: $table.heatIndexMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fallState => $composableBuilder(
    column: $table.fallState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get batteryLevel => $composableBuilder(
    column: $table.batteryLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get altitudeDiff => $composableBuilder(
    column: $table.altitudeDiff,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ppi0 => $composableBuilder(
    column: $table.ppi0,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ppi1 => $composableBuilder(
    column: $table.ppi1,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ppi2 => $composableBuilder(
    column: $table.ppi2,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationSource => $composableBuilder(
    column: $table.locationSource,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SensingDataEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SensingDataEntriesTable> {
  $$SensingDataEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heartRate => $composableBuilder(
    column: $table.heartRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get statusIndex => $composableBuilder(
    column: $table.statusIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get statusLevel => $composableBuilder(
    column: $table.statusLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get humidity => $composableBuilder(
    column: $table.humidity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heatIndex => $composableBuilder(
    column: $table.heatIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heatIndexMax => $composableBuilder(
    column: $table.heatIndexMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fallState => $composableBuilder(
    column: $table.fallState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get batteryLevel => $composableBuilder(
    column: $table.batteryLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get altitudeDiff => $composableBuilder(
    column: $table.altitudeDiff,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ppi0 => $composableBuilder(
    column: $table.ppi0,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ppi1 => $composableBuilder(
    column: $table.ppi1,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ppi2 => $composableBuilder(
    column: $table.ppi2,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationSource => $composableBuilder(
    column: $table.locationSource,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SensingDataEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SensingDataEntriesTable> {
  $$SensingDataEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get heartRate =>
      $composableBuilder(column: $table.heartRate, builder: (column) => column);

  GeneratedColumn<int> get statusIndex => $composableBuilder(
    column: $table.statusIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get statusLevel => $composableBuilder(
    column: $table.statusLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<int> get humidity =>
      $composableBuilder(column: $table.humidity, builder: (column) => column);

  GeneratedColumn<int> get heatIndex =>
      $composableBuilder(column: $table.heatIndex, builder: (column) => column);

  GeneratedColumn<int> get heatIndexMax => $composableBuilder(
    column: $table.heatIndexMax,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fallState =>
      $composableBuilder(column: $table.fallState, builder: (column) => column);

  GeneratedColumn<int> get batteryLevel => $composableBuilder(
    column: $table.batteryLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<int> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<int> get altitudeDiff => $composableBuilder(
    column: $table.altitudeDiff,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ppi0 =>
      $composableBuilder(column: $table.ppi0, builder: (column) => column);

  GeneratedColumn<int> get ppi1 =>
      $composableBuilder(column: $table.ppi1, builder: (column) => column);

  GeneratedColumn<int> get ppi2 =>
      $composableBuilder(column: $table.ppi2, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get locationSource => $composableBuilder(
    column: $table.locationSource,
    builder: (column) => column,
  );
}

class $$SensingDataEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SensingDataEntriesTable,
          SensingDataEntry,
          $$SensingDataEntriesTableFilterComposer,
          $$SensingDataEntriesTableOrderingComposer,
          $$SensingDataEntriesTableAnnotationComposer,
          $$SensingDataEntriesTableCreateCompanionBuilder,
          $$SensingDataEntriesTableUpdateCompanionBuilder,
          (
            SensingDataEntry,
            BaseReferences<
              _$AppDatabase,
              $SensingDataEntriesTable,
              SensingDataEntry
            >,
          ),
          SensingDataEntry,
          PrefetchHooks Function()
        > {
  $$SensingDataEntriesTableTableManager(
    _$AppDatabase db,
    $SensingDataEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SensingDataEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SensingDataEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SensingDataEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<int> timestamp = const Value.absent(),
                Value<int> heartRate = const Value.absent(),
                Value<int> statusIndex = const Value.absent(),
                Value<int> statusLevel = const Value.absent(),
                Value<int> temperature = const Value.absent(),
                Value<int> humidity = const Value.absent(),
                Value<int> heatIndex = const Value.absent(),
                Value<int> heatIndexMax = const Value.absent(),
                Value<int> fallState = const Value.absent(),
                Value<int> batteryLevel = const Value.absent(),
                Value<int> latitude = const Value.absent(),
                Value<int> longitude = const Value.absent(),
                Value<int> altitudeDiff = const Value.absent(),
                Value<int> ppi0 = const Value.absent(),
                Value<int> ppi1 = const Value.absent(),
                Value<int> ppi2 = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<String> locationSource = const Value.absent(),
              }) => SensingDataEntriesCompanion(
                id: id,
                deviceId: deviceId,
                timestamp: timestamp,
                heartRate: heartRate,
                statusIndex: statusIndex,
                statusLevel: statusLevel,
                temperature: temperature,
                humidity: humidity,
                heatIndex: heatIndex,
                heatIndexMax: heatIndexMax,
                fallState: fallState,
                batteryLevel: batteryLevel,
                latitude: latitude,
                longitude: longitude,
                altitudeDiff: altitudeDiff,
                ppi0: ppi0,
                ppi1: ppi1,
                ppi2: ppi2,
                synced: synced,
                createdAt: createdAt,
                locationSource: locationSource,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<int> timestamp = const Value.absent(),
                Value<int> heartRate = const Value.absent(),
                Value<int> statusIndex = const Value.absent(),
                Value<int> statusLevel = const Value.absent(),
                Value<int> temperature = const Value.absent(),
                Value<int> humidity = const Value.absent(),
                Value<int> heatIndex = const Value.absent(),
                Value<int> heatIndexMax = const Value.absent(),
                Value<int> fallState = const Value.absent(),
                Value<int> batteryLevel = const Value.absent(),
                Value<int> latitude = const Value.absent(),
                Value<int> longitude = const Value.absent(),
                Value<int> altitudeDiff = const Value.absent(),
                Value<int> ppi0 = const Value.absent(),
                Value<int> ppi1 = const Value.absent(),
                Value<int> ppi2 = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<String> locationSource = const Value.absent(),
              }) => SensingDataEntriesCompanion.insert(
                id: id,
                deviceId: deviceId,
                timestamp: timestamp,
                heartRate: heartRate,
                statusIndex: statusIndex,
                statusLevel: statusLevel,
                temperature: temperature,
                humidity: humidity,
                heatIndex: heatIndex,
                heatIndexMax: heatIndexMax,
                fallState: fallState,
                batteryLevel: batteryLevel,
                latitude: latitude,
                longitude: longitude,
                altitudeDiff: altitudeDiff,
                ppi0: ppi0,
                ppi1: ppi1,
                ppi2: ppi2,
                synced: synced,
                createdAt: createdAt,
                locationSource: locationSource,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SensingDataEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SensingDataEntriesTable,
      SensingDataEntry,
      $$SensingDataEntriesTableFilterComposer,
      $$SensingDataEntriesTableOrderingComposer,
      $$SensingDataEntriesTableAnnotationComposer,
      $$SensingDataEntriesTableCreateCompanionBuilder,
      $$SensingDataEntriesTableUpdateCompanionBuilder,
      (
        SensingDataEntry,
        BaseReferences<
          _$AppDatabase,
          $SensingDataEntriesTable,
          SensingDataEntry
        >,
      ),
      SensingDataEntry,
      PrefetchHooks Function()
    >;
typedef $$FallEventEntriesTableCreateCompanionBuilder =
    FallEventEntriesCompanion Function({
      Value<int> id,
      Value<String> deviceId,
      Value<int> timestamp,
      Value<int> latitude,
      Value<int> longitude,
      Value<int> elapsedSeconds,
      Value<int> statusLevel,
      Value<int> heatIndex,
      Value<String> source,
      Value<bool> uploaded,
      Value<int> createdAt,
      Value<int> heartRate,
      Value<int> temperature,
      Value<int> humidity,
      Value<int> heatIndexMax,
      Value<int> fallState,
      Value<int> batteryLevel,
      Value<int> altitudeDiff,
      Value<int> statusIndex,
      Value<int> ppi0,
      Value<int> ppi1,
      Value<int> ppi2,
      Value<String> userName,
      Value<String> locationSource,
    });
typedef $$FallEventEntriesTableUpdateCompanionBuilder =
    FallEventEntriesCompanion Function({
      Value<int> id,
      Value<String> deviceId,
      Value<int> timestamp,
      Value<int> latitude,
      Value<int> longitude,
      Value<int> elapsedSeconds,
      Value<int> statusLevel,
      Value<int> heatIndex,
      Value<String> source,
      Value<bool> uploaded,
      Value<int> createdAt,
      Value<int> heartRate,
      Value<int> temperature,
      Value<int> humidity,
      Value<int> heatIndexMax,
      Value<int> fallState,
      Value<int> batteryLevel,
      Value<int> altitudeDiff,
      Value<int> statusIndex,
      Value<int> ppi0,
      Value<int> ppi1,
      Value<int> ppi2,
      Value<String> userName,
      Value<String> locationSource,
    });

class $$FallEventEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $FallEventEntriesTable> {
  $$FallEventEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get elapsedSeconds => $composableBuilder(
    column: $table.elapsedSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get statusLevel => $composableBuilder(
    column: $table.statusLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heatIndex => $composableBuilder(
    column: $table.heatIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get uploaded => $composableBuilder(
    column: $table.uploaded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heartRate => $composableBuilder(
    column: $table.heartRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get humidity => $composableBuilder(
    column: $table.humidity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heatIndexMax => $composableBuilder(
    column: $table.heatIndexMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fallState => $composableBuilder(
    column: $table.fallState,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get batteryLevel => $composableBuilder(
    column: $table.batteryLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get altitudeDiff => $composableBuilder(
    column: $table.altitudeDiff,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get statusIndex => $composableBuilder(
    column: $table.statusIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ppi0 => $composableBuilder(
    column: $table.ppi0,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ppi1 => $composableBuilder(
    column: $table.ppi1,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ppi2 => $composableBuilder(
    column: $table.ppi2,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get locationSource => $composableBuilder(
    column: $table.locationSource,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FallEventEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $FallEventEntriesTable> {
  $$FallEventEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get elapsedSeconds => $composableBuilder(
    column: $table.elapsedSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get statusLevel => $composableBuilder(
    column: $table.statusLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heatIndex => $composableBuilder(
    column: $table.heatIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get uploaded => $composableBuilder(
    column: $table.uploaded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heartRate => $composableBuilder(
    column: $table.heartRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get humidity => $composableBuilder(
    column: $table.humidity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heatIndexMax => $composableBuilder(
    column: $table.heatIndexMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fallState => $composableBuilder(
    column: $table.fallState,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get batteryLevel => $composableBuilder(
    column: $table.batteryLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get altitudeDiff => $composableBuilder(
    column: $table.altitudeDiff,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get statusIndex => $composableBuilder(
    column: $table.statusIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ppi0 => $composableBuilder(
    column: $table.ppi0,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ppi1 => $composableBuilder(
    column: $table.ppi1,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ppi2 => $composableBuilder(
    column: $table.ppi2,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get locationSource => $composableBuilder(
    column: $table.locationSource,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FallEventEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FallEventEntriesTable> {
  $$FallEventEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<int> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<int> get elapsedSeconds => $composableBuilder(
    column: $table.elapsedSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get statusLevel => $composableBuilder(
    column: $table.statusLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get heatIndex =>
      $composableBuilder(column: $table.heatIndex, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<bool> get uploaded =>
      $composableBuilder(column: $table.uploaded, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get heartRate =>
      $composableBuilder(column: $table.heartRate, builder: (column) => column);

  GeneratedColumn<int> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<int> get humidity =>
      $composableBuilder(column: $table.humidity, builder: (column) => column);

  GeneratedColumn<int> get heatIndexMax => $composableBuilder(
    column: $table.heatIndexMax,
    builder: (column) => column,
  );

  GeneratedColumn<int> get fallState =>
      $composableBuilder(column: $table.fallState, builder: (column) => column);

  GeneratedColumn<int> get batteryLevel => $composableBuilder(
    column: $table.batteryLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get altitudeDiff => $composableBuilder(
    column: $table.altitudeDiff,
    builder: (column) => column,
  );

  GeneratedColumn<int> get statusIndex => $composableBuilder(
    column: $table.statusIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ppi0 =>
      $composableBuilder(column: $table.ppi0, builder: (column) => column);

  GeneratedColumn<int> get ppi1 =>
      $composableBuilder(column: $table.ppi1, builder: (column) => column);

  GeneratedColumn<int> get ppi2 =>
      $composableBuilder(column: $table.ppi2, builder: (column) => column);

  GeneratedColumn<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => column);

  GeneratedColumn<String> get locationSource => $composableBuilder(
    column: $table.locationSource,
    builder: (column) => column,
  );
}

class $$FallEventEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FallEventEntriesTable,
          FallEventEntry,
          $$FallEventEntriesTableFilterComposer,
          $$FallEventEntriesTableOrderingComposer,
          $$FallEventEntriesTableAnnotationComposer,
          $$FallEventEntriesTableCreateCompanionBuilder,
          $$FallEventEntriesTableUpdateCompanionBuilder,
          (
            FallEventEntry,
            BaseReferences<
              _$AppDatabase,
              $FallEventEntriesTable,
              FallEventEntry
            >,
          ),
          FallEventEntry,
          PrefetchHooks Function()
        > {
  $$FallEventEntriesTableTableManager(
    _$AppDatabase db,
    $FallEventEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FallEventEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FallEventEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FallEventEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<int> timestamp = const Value.absent(),
                Value<int> latitude = const Value.absent(),
                Value<int> longitude = const Value.absent(),
                Value<int> elapsedSeconds = const Value.absent(),
                Value<int> statusLevel = const Value.absent(),
                Value<int> heatIndex = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<bool> uploaded = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> heartRate = const Value.absent(),
                Value<int> temperature = const Value.absent(),
                Value<int> humidity = const Value.absent(),
                Value<int> heatIndexMax = const Value.absent(),
                Value<int> fallState = const Value.absent(),
                Value<int> batteryLevel = const Value.absent(),
                Value<int> altitudeDiff = const Value.absent(),
                Value<int> statusIndex = const Value.absent(),
                Value<int> ppi0 = const Value.absent(),
                Value<int> ppi1 = const Value.absent(),
                Value<int> ppi2 = const Value.absent(),
                Value<String> userName = const Value.absent(),
                Value<String> locationSource = const Value.absent(),
              }) => FallEventEntriesCompanion(
                id: id,
                deviceId: deviceId,
                timestamp: timestamp,
                latitude: latitude,
                longitude: longitude,
                elapsedSeconds: elapsedSeconds,
                statusLevel: statusLevel,
                heatIndex: heatIndex,
                source: source,
                uploaded: uploaded,
                createdAt: createdAt,
                heartRate: heartRate,
                temperature: temperature,
                humidity: humidity,
                heatIndexMax: heatIndexMax,
                fallState: fallState,
                batteryLevel: batteryLevel,
                altitudeDiff: altitudeDiff,
                statusIndex: statusIndex,
                ppi0: ppi0,
                ppi1: ppi1,
                ppi2: ppi2,
                userName: userName,
                locationSource: locationSource,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<int> timestamp = const Value.absent(),
                Value<int> latitude = const Value.absent(),
                Value<int> longitude = const Value.absent(),
                Value<int> elapsedSeconds = const Value.absent(),
                Value<int> statusLevel = const Value.absent(),
                Value<int> heatIndex = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<bool> uploaded = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> heartRate = const Value.absent(),
                Value<int> temperature = const Value.absent(),
                Value<int> humidity = const Value.absent(),
                Value<int> heatIndexMax = const Value.absent(),
                Value<int> fallState = const Value.absent(),
                Value<int> batteryLevel = const Value.absent(),
                Value<int> altitudeDiff = const Value.absent(),
                Value<int> statusIndex = const Value.absent(),
                Value<int> ppi0 = const Value.absent(),
                Value<int> ppi1 = const Value.absent(),
                Value<int> ppi2 = const Value.absent(),
                Value<String> userName = const Value.absent(),
                Value<String> locationSource = const Value.absent(),
              }) => FallEventEntriesCompanion.insert(
                id: id,
                deviceId: deviceId,
                timestamp: timestamp,
                latitude: latitude,
                longitude: longitude,
                elapsedSeconds: elapsedSeconds,
                statusLevel: statusLevel,
                heatIndex: heatIndex,
                source: source,
                uploaded: uploaded,
                createdAt: createdAt,
                heartRate: heartRate,
                temperature: temperature,
                humidity: humidity,
                heatIndexMax: heatIndexMax,
                fallState: fallState,
                batteryLevel: batteryLevel,
                altitudeDiff: altitudeDiff,
                statusIndex: statusIndex,
                ppi0: ppi0,
                ppi1: ppi1,
                ppi2: ppi2,
                userName: userName,
                locationSource: locationSource,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FallEventEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FallEventEntriesTable,
      FallEventEntry,
      $$FallEventEntriesTableFilterComposer,
      $$FallEventEntriesTableOrderingComposer,
      $$FallEventEntriesTableAnnotationComposer,
      $$FallEventEntriesTableCreateCompanionBuilder,
      $$FallEventEntriesTableUpdateCompanionBuilder,
      (
        FallEventEntry,
        BaseReferences<_$AppDatabase, $FallEventEntriesTable, FallEventEntry>,
      ),
      FallEventEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$SensingDataEntriesTableTableManager get sensingDataEntries =>
      $$SensingDataEntriesTableTableManager(_db, _db.sensingDataEntries);
  $$FallEventEntriesTableTableManager get fallEventEntries =>
      $$FallEventEntriesTableTableManager(_db, _db.fallEventEntries);
}
