// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $WardrivingSessionsTable extends WardrivingSessions
    with TableInfo<$WardrivingSessionsTable, WardrivingSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WardrivingSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<int> startedAt = GeneratedColumn<int>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<int> endedAt = GeneratedColumn<int>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceSourceMeta = const VerificationMeta(
    'deviceSource',
  );
  @override
  late final GeneratedColumn<String> deviceSource = GeneratedColumn<String>(
    'device_source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wifiEnabledMeta = const VerificationMeta(
    'wifiEnabled',
  );
  @override
  late final GeneratedColumn<bool> wifiEnabled = GeneratedColumn<bool>(
    'wifi_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("wifi_enabled" IN (0, 1))',
    ),
  );
  static const VerificationMeta _bleEnabledMeta = const VerificationMeta(
    'bleEnabled',
  );
  @override
  late final GeneratedColumn<bool> bleEnabled = GeneratedColumn<bool>(
    'ble_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("ble_enabled" IN (0, 1))',
    ),
  );
  static const VerificationMeta _lteEnabledMeta = const VerificationMeta(
    'lteEnabled',
  );
  @override
  late final GeneratedColumn<bool> lteEnabled = GeneratedColumn<bool>(
    'lte_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("lte_enabled" IN (0, 1))',
    ),
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
  static const VerificationMeta _localExportPathMeta = const VerificationMeta(
    'localExportPath',
  );
  @override
  late final GeneratedColumn<String> localExportPath = GeneratedColumn<String>(
    'local_export_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startedAt,
    endedAt,
    status,
    deviceSource,
    notes,
    wifiEnabled,
    bleEnabled,
    lteEnabled,
    uploaded,
    localExportPath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wardriving_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<WardrivingSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('device_source')) {
      context.handle(
        _deviceSourceMeta,
        deviceSource.isAcceptableOrUnknown(
          data['device_source']!,
          _deviceSourceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deviceSourceMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('wifi_enabled')) {
      context.handle(
        _wifiEnabledMeta,
        wifiEnabled.isAcceptableOrUnknown(
          data['wifi_enabled']!,
          _wifiEnabledMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wifiEnabledMeta);
    }
    if (data.containsKey('ble_enabled')) {
      context.handle(
        _bleEnabledMeta,
        bleEnabled.isAcceptableOrUnknown(data['ble_enabled']!, _bleEnabledMeta),
      );
    } else if (isInserting) {
      context.missing(_bleEnabledMeta);
    }
    if (data.containsKey('lte_enabled')) {
      context.handle(
        _lteEnabledMeta,
        lteEnabled.isAcceptableOrUnknown(data['lte_enabled']!, _lteEnabledMeta),
      );
    } else if (isInserting) {
      context.missing(_lteEnabledMeta);
    }
    if (data.containsKey('uploaded')) {
      context.handle(
        _uploadedMeta,
        uploaded.isAcceptableOrUnknown(data['uploaded']!, _uploadedMeta),
      );
    }
    if (data.containsKey('local_export_path')) {
      context.handle(
        _localExportPathMeta,
        localExportPath.isAcceptableOrUnknown(
          data['local_export_path']!,
          _localExportPathMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WardrivingSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WardrivingSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ended_at'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      deviceSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_source'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      wifiEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}wifi_enabled'],
      )!,
      bleEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}ble_enabled'],
      )!,
      lteEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}lte_enabled'],
      )!,
      uploaded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}uploaded'],
      )!,
      localExportPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_export_path'],
      ),
    );
  }

  @override
  $WardrivingSessionsTable createAlias(String alias) {
    return $WardrivingSessionsTable(attachedDatabase, alias);
  }
}

class WardrivingSession extends DataClass
    implements Insertable<WardrivingSession> {
  final String id;
  final int startedAt;
  final int? endedAt;
  final String status;
  final String deviceSource;
  final String? notes;
  final bool wifiEnabled;
  final bool bleEnabled;
  final bool lteEnabled;
  final bool uploaded;
  final String? localExportPath;
  const WardrivingSession({
    required this.id,
    required this.startedAt,
    this.endedAt,
    required this.status,
    required this.deviceSource,
    this.notes,
    required this.wifiEnabled,
    required this.bleEnabled,
    required this.lteEnabled,
    required this.uploaded,
    this.localExportPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['started_at'] = Variable<int>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<int>(endedAt);
    }
    map['status'] = Variable<String>(status);
    map['device_source'] = Variable<String>(deviceSource);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['wifi_enabled'] = Variable<bool>(wifiEnabled);
    map['ble_enabled'] = Variable<bool>(bleEnabled);
    map['lte_enabled'] = Variable<bool>(lteEnabled);
    map['uploaded'] = Variable<bool>(uploaded);
    if (!nullToAbsent || localExportPath != null) {
      map['local_export_path'] = Variable<String>(localExportPath);
    }
    return map;
  }

  WardrivingSessionsCompanion toCompanion(bool nullToAbsent) {
    return WardrivingSessionsCompanion(
      id: Value(id),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      status: Value(status),
      deviceSource: Value(deviceSource),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      wifiEnabled: Value(wifiEnabled),
      bleEnabled: Value(bleEnabled),
      lteEnabled: Value(lteEnabled),
      uploaded: Value(uploaded),
      localExportPath: localExportPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localExportPath),
    );
  }

  factory WardrivingSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WardrivingSession(
      id: serializer.fromJson<String>(json['id']),
      startedAt: serializer.fromJson<int>(json['startedAt']),
      endedAt: serializer.fromJson<int?>(json['endedAt']),
      status: serializer.fromJson<String>(json['status']),
      deviceSource: serializer.fromJson<String>(json['deviceSource']),
      notes: serializer.fromJson<String?>(json['notes']),
      wifiEnabled: serializer.fromJson<bool>(json['wifiEnabled']),
      bleEnabled: serializer.fromJson<bool>(json['bleEnabled']),
      lteEnabled: serializer.fromJson<bool>(json['lteEnabled']),
      uploaded: serializer.fromJson<bool>(json['uploaded']),
      localExportPath: serializer.fromJson<String?>(json['localExportPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'startedAt': serializer.toJson<int>(startedAt),
      'endedAt': serializer.toJson<int?>(endedAt),
      'status': serializer.toJson<String>(status),
      'deviceSource': serializer.toJson<String>(deviceSource),
      'notes': serializer.toJson<String?>(notes),
      'wifiEnabled': serializer.toJson<bool>(wifiEnabled),
      'bleEnabled': serializer.toJson<bool>(bleEnabled),
      'lteEnabled': serializer.toJson<bool>(lteEnabled),
      'uploaded': serializer.toJson<bool>(uploaded),
      'localExportPath': serializer.toJson<String?>(localExportPath),
    };
  }

  WardrivingSession copyWith({
    String? id,
    int? startedAt,
    Value<int?> endedAt = const Value.absent(),
    String? status,
    String? deviceSource,
    Value<String?> notes = const Value.absent(),
    bool? wifiEnabled,
    bool? bleEnabled,
    bool? lteEnabled,
    bool? uploaded,
    Value<String?> localExportPath = const Value.absent(),
  }) => WardrivingSession(
    id: id ?? this.id,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    status: status ?? this.status,
    deviceSource: deviceSource ?? this.deviceSource,
    notes: notes.present ? notes.value : this.notes,
    wifiEnabled: wifiEnabled ?? this.wifiEnabled,
    bleEnabled: bleEnabled ?? this.bleEnabled,
    lteEnabled: lteEnabled ?? this.lteEnabled,
    uploaded: uploaded ?? this.uploaded,
    localExportPath: localExportPath.present
        ? localExportPath.value
        : this.localExportPath,
  );
  WardrivingSession copyWithCompanion(WardrivingSessionsCompanion data) {
    return WardrivingSession(
      id: data.id.present ? data.id.value : this.id,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      status: data.status.present ? data.status.value : this.status,
      deviceSource: data.deviceSource.present
          ? data.deviceSource.value
          : this.deviceSource,
      notes: data.notes.present ? data.notes.value : this.notes,
      wifiEnabled: data.wifiEnabled.present
          ? data.wifiEnabled.value
          : this.wifiEnabled,
      bleEnabled: data.bleEnabled.present
          ? data.bleEnabled.value
          : this.bleEnabled,
      lteEnabled: data.lteEnabled.present
          ? data.lteEnabled.value
          : this.lteEnabled,
      uploaded: data.uploaded.present ? data.uploaded.value : this.uploaded,
      localExportPath: data.localExportPath.present
          ? data.localExportPath.value
          : this.localExportPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WardrivingSession(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('status: $status, ')
          ..write('deviceSource: $deviceSource, ')
          ..write('notes: $notes, ')
          ..write('wifiEnabled: $wifiEnabled, ')
          ..write('bleEnabled: $bleEnabled, ')
          ..write('lteEnabled: $lteEnabled, ')
          ..write('uploaded: $uploaded, ')
          ..write('localExportPath: $localExportPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startedAt,
    endedAt,
    status,
    deviceSource,
    notes,
    wifiEnabled,
    bleEnabled,
    lteEnabled,
    uploaded,
    localExportPath,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WardrivingSession &&
          other.id == this.id &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.status == this.status &&
          other.deviceSource == this.deviceSource &&
          other.notes == this.notes &&
          other.wifiEnabled == this.wifiEnabled &&
          other.bleEnabled == this.bleEnabled &&
          other.lteEnabled == this.lteEnabled &&
          other.uploaded == this.uploaded &&
          other.localExportPath == this.localExportPath);
}

class WardrivingSessionsCompanion extends UpdateCompanion<WardrivingSession> {
  final Value<String> id;
  final Value<int> startedAt;
  final Value<int?> endedAt;
  final Value<String> status;
  final Value<String> deviceSource;
  final Value<String?> notes;
  final Value<bool> wifiEnabled;
  final Value<bool> bleEnabled;
  final Value<bool> lteEnabled;
  final Value<bool> uploaded;
  final Value<String?> localExportPath;
  final Value<int> rowid;
  const WardrivingSessionsCompanion({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.deviceSource = const Value.absent(),
    this.notes = const Value.absent(),
    this.wifiEnabled = const Value.absent(),
    this.bleEnabled = const Value.absent(),
    this.lteEnabled = const Value.absent(),
    this.uploaded = const Value.absent(),
    this.localExportPath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WardrivingSessionsCompanion.insert({
    required String id,
    required int startedAt,
    this.endedAt = const Value.absent(),
    required String status,
    required String deviceSource,
    this.notes = const Value.absent(),
    required bool wifiEnabled,
    required bool bleEnabled,
    required bool lteEnabled,
    this.uploaded = const Value.absent(),
    this.localExportPath = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       startedAt = Value(startedAt),
       status = Value(status),
       deviceSource = Value(deviceSource),
       wifiEnabled = Value(wifiEnabled),
       bleEnabled = Value(bleEnabled),
       lteEnabled = Value(lteEnabled);
  static Insertable<WardrivingSession> custom({
    Expression<String>? id,
    Expression<int>? startedAt,
    Expression<int>? endedAt,
    Expression<String>? status,
    Expression<String>? deviceSource,
    Expression<String>? notes,
    Expression<bool>? wifiEnabled,
    Expression<bool>? bleEnabled,
    Expression<bool>? lteEnabled,
    Expression<bool>? uploaded,
    Expression<String>? localExportPath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (status != null) 'status': status,
      if (deviceSource != null) 'device_source': deviceSource,
      if (notes != null) 'notes': notes,
      if (wifiEnabled != null) 'wifi_enabled': wifiEnabled,
      if (bleEnabled != null) 'ble_enabled': bleEnabled,
      if (lteEnabled != null) 'lte_enabled': lteEnabled,
      if (uploaded != null) 'uploaded': uploaded,
      if (localExportPath != null) 'local_export_path': localExportPath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WardrivingSessionsCompanion copyWith({
    Value<String>? id,
    Value<int>? startedAt,
    Value<int?>? endedAt,
    Value<String>? status,
    Value<String>? deviceSource,
    Value<String?>? notes,
    Value<bool>? wifiEnabled,
    Value<bool>? bleEnabled,
    Value<bool>? lteEnabled,
    Value<bool>? uploaded,
    Value<String?>? localExportPath,
    Value<int>? rowid,
  }) {
    return WardrivingSessionsCompanion(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      status: status ?? this.status,
      deviceSource: deviceSource ?? this.deviceSource,
      notes: notes ?? this.notes,
      wifiEnabled: wifiEnabled ?? this.wifiEnabled,
      bleEnabled: bleEnabled ?? this.bleEnabled,
      lteEnabled: lteEnabled ?? this.lteEnabled,
      uploaded: uploaded ?? this.uploaded,
      localExportPath: localExportPath ?? this.localExportPath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<int>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<int>(endedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (deviceSource.present) {
      map['device_source'] = Variable<String>(deviceSource.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (wifiEnabled.present) {
      map['wifi_enabled'] = Variable<bool>(wifiEnabled.value);
    }
    if (bleEnabled.present) {
      map['ble_enabled'] = Variable<bool>(bleEnabled.value);
    }
    if (lteEnabled.present) {
      map['lte_enabled'] = Variable<bool>(lteEnabled.value);
    }
    if (uploaded.present) {
      map['uploaded'] = Variable<bool>(uploaded.value);
    }
    if (localExportPath.present) {
      map['local_export_path'] = Variable<String>(localExportPath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WardrivingSessionsCompanion(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('status: $status, ')
          ..write('deviceSource: $deviceSource, ')
          ..write('notes: $notes, ')
          ..write('wifiEnabled: $wifiEnabled, ')
          ..write('bleEnabled: $bleEnabled, ')
          ..write('lteEnabled: $lteEnabled, ')
          ..write('uploaded: $uploaded, ')
          ..write('localExportPath: $localExportPath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocationSamplesTable extends LocationSamples
    with TableInfo<$LocationSamplesTable, LocationSample> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationSamplesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _altitudeMetersMeta = const VerificationMeta(
    'altitudeMeters',
  );
  @override
  late final GeneratedColumn<double> altitudeMeters = GeneratedColumn<double>(
    'altitude_meters',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accuracyMetersMeta = const VerificationMeta(
    'accuracyMeters',
  );
  @override
  late final GeneratedColumn<double> accuracyMeters = GeneratedColumn<double>(
    'accuracy_meters',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _speedMetersPerSecondMeta =
      const VerificationMeta('speedMetersPerSecond');
  @override
  late final GeneratedColumn<double> speedMetersPerSecond =
      GeneratedColumn<double>(
        'speed_meters_per_second',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _bearingDegreesMeta = const VerificationMeta(
    'bearingDegrees',
  );
  @override
  late final GeneratedColumn<double> bearingDegrees = GeneratedColumn<double>(
    'bearing_degrees',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    timestamp,
    latitude,
    longitude,
    altitudeMeters,
    accuracyMeters,
    speedMetersPerSecond,
    bearingDegrees,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'location_samples';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocationSample> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('altitude_meters')) {
      context.handle(
        _altitudeMetersMeta,
        altitudeMeters.isAcceptableOrUnknown(
          data['altitude_meters']!,
          _altitudeMetersMeta,
        ),
      );
    }
    if (data.containsKey('accuracy_meters')) {
      context.handle(
        _accuracyMetersMeta,
        accuracyMeters.isAcceptableOrUnknown(
          data['accuracy_meters']!,
          _accuracyMetersMeta,
        ),
      );
    }
    if (data.containsKey('speed_meters_per_second')) {
      context.handle(
        _speedMetersPerSecondMeta,
        speedMetersPerSecond.isAcceptableOrUnknown(
          data['speed_meters_per_second']!,
          _speedMetersPerSecondMeta,
        ),
      );
    }
    if (data.containsKey('bearing_degrees')) {
      context.handle(
        _bearingDegreesMeta,
        bearingDegrees.isAcceptableOrUnknown(
          data['bearing_degrees']!,
          _bearingDegreesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {sessionId, timestamp},
  ];
  @override
  LocationSample map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocationSample(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      altitudeMeters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}altitude_meters'],
      ),
      accuracyMeters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_meters'],
      ),
      speedMetersPerSecond: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}speed_meters_per_second'],
      ),
      bearingDegrees: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bearing_degrees'],
      ),
    );
  }

  @override
  $LocationSamplesTable createAlias(String alias) {
    return $LocationSamplesTable(attachedDatabase, alias);
  }
}

class LocationSample extends DataClass implements Insertable<LocationSample> {
  final int id;
  final String sessionId;
  final int timestamp;
  final double latitude;
  final double longitude;
  final double? altitudeMeters;
  final double? accuracyMeters;
  final double? speedMetersPerSecond;
  final double? bearingDegrees;
  const LocationSample({
    required this.id,
    required this.sessionId,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    this.altitudeMeters,
    this.accuracyMeters,
    this.speedMetersPerSecond,
    this.bearingDegrees,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['timestamp'] = Variable<int>(timestamp);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    if (!nullToAbsent || altitudeMeters != null) {
      map['altitude_meters'] = Variable<double>(altitudeMeters);
    }
    if (!nullToAbsent || accuracyMeters != null) {
      map['accuracy_meters'] = Variable<double>(accuracyMeters);
    }
    if (!nullToAbsent || speedMetersPerSecond != null) {
      map['speed_meters_per_second'] = Variable<double>(speedMetersPerSecond);
    }
    if (!nullToAbsent || bearingDegrees != null) {
      map['bearing_degrees'] = Variable<double>(bearingDegrees);
    }
    return map;
  }

  LocationSamplesCompanion toCompanion(bool nullToAbsent) {
    return LocationSamplesCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      timestamp: Value(timestamp),
      latitude: Value(latitude),
      longitude: Value(longitude),
      altitudeMeters: altitudeMeters == null && nullToAbsent
          ? const Value.absent()
          : Value(altitudeMeters),
      accuracyMeters: accuracyMeters == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracyMeters),
      speedMetersPerSecond: speedMetersPerSecond == null && nullToAbsent
          ? const Value.absent()
          : Value(speedMetersPerSecond),
      bearingDegrees: bearingDegrees == null && nullToAbsent
          ? const Value.absent()
          : Value(bearingDegrees),
    );
  }

  factory LocationSample.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocationSample(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      altitudeMeters: serializer.fromJson<double?>(json['altitudeMeters']),
      accuracyMeters: serializer.fromJson<double?>(json['accuracyMeters']),
      speedMetersPerSecond: serializer.fromJson<double?>(
        json['speedMetersPerSecond'],
      ),
      bearingDegrees: serializer.fromJson<double?>(json['bearingDegrees']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'timestamp': serializer.toJson<int>(timestamp),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'altitudeMeters': serializer.toJson<double?>(altitudeMeters),
      'accuracyMeters': serializer.toJson<double?>(accuracyMeters),
      'speedMetersPerSecond': serializer.toJson<double?>(speedMetersPerSecond),
      'bearingDegrees': serializer.toJson<double?>(bearingDegrees),
    };
  }

  LocationSample copyWith({
    int? id,
    String? sessionId,
    int? timestamp,
    double? latitude,
    double? longitude,
    Value<double?> altitudeMeters = const Value.absent(),
    Value<double?> accuracyMeters = const Value.absent(),
    Value<double?> speedMetersPerSecond = const Value.absent(),
    Value<double?> bearingDegrees = const Value.absent(),
  }) => LocationSample(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    timestamp: timestamp ?? this.timestamp,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    altitudeMeters: altitudeMeters.present
        ? altitudeMeters.value
        : this.altitudeMeters,
    accuracyMeters: accuracyMeters.present
        ? accuracyMeters.value
        : this.accuracyMeters,
    speedMetersPerSecond: speedMetersPerSecond.present
        ? speedMetersPerSecond.value
        : this.speedMetersPerSecond,
    bearingDegrees: bearingDegrees.present
        ? bearingDegrees.value
        : this.bearingDegrees,
  );
  LocationSample copyWithCompanion(LocationSamplesCompanion data) {
    return LocationSample(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      altitudeMeters: data.altitudeMeters.present
          ? data.altitudeMeters.value
          : this.altitudeMeters,
      accuracyMeters: data.accuracyMeters.present
          ? data.accuracyMeters.value
          : this.accuracyMeters,
      speedMetersPerSecond: data.speedMetersPerSecond.present
          ? data.speedMetersPerSecond.value
          : this.speedMetersPerSecond,
      bearingDegrees: data.bearingDegrees.present
          ? data.bearingDegrees.value
          : this.bearingDegrees,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocationSample(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('timestamp: $timestamp, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('altitudeMeters: $altitudeMeters, ')
          ..write('accuracyMeters: $accuracyMeters, ')
          ..write('speedMetersPerSecond: $speedMetersPerSecond, ')
          ..write('bearingDegrees: $bearingDegrees')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    timestamp,
    latitude,
    longitude,
    altitudeMeters,
    accuracyMeters,
    speedMetersPerSecond,
    bearingDegrees,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocationSample &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.timestamp == this.timestamp &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.altitudeMeters == this.altitudeMeters &&
          other.accuracyMeters == this.accuracyMeters &&
          other.speedMetersPerSecond == this.speedMetersPerSecond &&
          other.bearingDegrees == this.bearingDegrees);
}

class LocationSamplesCompanion extends UpdateCompanion<LocationSample> {
  final Value<int> id;
  final Value<String> sessionId;
  final Value<int> timestamp;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<double?> altitudeMeters;
  final Value<double?> accuracyMeters;
  final Value<double?> speedMetersPerSecond;
  final Value<double?> bearingDegrees;
  const LocationSamplesCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.altitudeMeters = const Value.absent(),
    this.accuracyMeters = const Value.absent(),
    this.speedMetersPerSecond = const Value.absent(),
    this.bearingDegrees = const Value.absent(),
  });
  LocationSamplesCompanion.insert({
    this.id = const Value.absent(),
    required String sessionId,
    required int timestamp,
    required double latitude,
    required double longitude,
    this.altitudeMeters = const Value.absent(),
    this.accuracyMeters = const Value.absent(),
    this.speedMetersPerSecond = const Value.absent(),
    this.bearingDegrees = const Value.absent(),
  }) : sessionId = Value(sessionId),
       timestamp = Value(timestamp),
       latitude = Value(latitude),
       longitude = Value(longitude);
  static Insertable<LocationSample> custom({
    Expression<int>? id,
    Expression<String>? sessionId,
    Expression<int>? timestamp,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? altitudeMeters,
    Expression<double>? accuracyMeters,
    Expression<double>? speedMetersPerSecond,
    Expression<double>? bearingDegrees,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (timestamp != null) 'timestamp': timestamp,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (altitudeMeters != null) 'altitude_meters': altitudeMeters,
      if (accuracyMeters != null) 'accuracy_meters': accuracyMeters,
      if (speedMetersPerSecond != null)
        'speed_meters_per_second': speedMetersPerSecond,
      if (bearingDegrees != null) 'bearing_degrees': bearingDegrees,
    });
  }

  LocationSamplesCompanion copyWith({
    Value<int>? id,
    Value<String>? sessionId,
    Value<int>? timestamp,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<double?>? altitudeMeters,
    Value<double?>? accuracyMeters,
    Value<double?>? speedMetersPerSecond,
    Value<double?>? bearingDegrees,
  }) {
    return LocationSamplesCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      timestamp: timestamp ?? this.timestamp,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      altitudeMeters: altitudeMeters ?? this.altitudeMeters,
      accuracyMeters: accuracyMeters ?? this.accuracyMeters,
      speedMetersPerSecond: speedMetersPerSecond ?? this.speedMetersPerSecond,
      bearingDegrees: bearingDegrees ?? this.bearingDegrees,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (altitudeMeters.present) {
      map['altitude_meters'] = Variable<double>(altitudeMeters.value);
    }
    if (accuracyMeters.present) {
      map['accuracy_meters'] = Variable<double>(accuracyMeters.value);
    }
    if (speedMetersPerSecond.present) {
      map['speed_meters_per_second'] = Variable<double>(
        speedMetersPerSecond.value,
      );
    }
    if (bearingDegrees.present) {
      map['bearing_degrees'] = Variable<double>(bearingDegrees.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationSamplesCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('timestamp: $timestamp, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('altitudeMeters: $altitudeMeters, ')
          ..write('accuracyMeters: $accuracyMeters, ')
          ..write('speedMetersPerSecond: $speedMetersPerSecond, ')
          ..write('bearingDegrees: $bearingDegrees')
          ..write(')'))
        .toString();
  }
}

class $WifiBleSamplesTable extends WifiBleSamples
    with TableInfo<$WifiBleSamplesTable, WifiBleSample> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WifiBleSamplesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _macMeta = const VerificationMeta('mac');
  @override
  late final GeneratedColumn<String> mac = GeneratedColumn<String>(
    'mac',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ssidMeta = const VerificationMeta('ssid');
  @override
  late final GeneratedColumn<String> ssid = GeneratedColumn<String>(
    'ssid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authModeMeta = const VerificationMeta(
    'authMode',
  );
  @override
  late final GeneratedColumn<String> authMode = GeneratedColumn<String>(
    'auth_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _channelMeta = const VerificationMeta(
    'channel',
  );
  @override
  late final GeneratedColumn<String> channel = GeneratedColumn<String>(
    'channel',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rssiMeta = const VerificationMeta('rssi');
  @override
  late final GeneratedColumn<int> rssi = GeneratedColumn<int>(
    'rssi',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altitudeMetersMeta = const VerificationMeta(
    'altitudeMeters',
  );
  @override
  late final GeneratedColumn<double> altitudeMeters = GeneratedColumn<double>(
    'altitude_meters',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accuracyMetersMeta = const VerificationMeta(
    'accuracyMeters',
  );
  @override
  late final GeneratedColumn<double> accuracyMeters = GeneratedColumn<double>(
    'accuracy_meters',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rawPayloadMeta = const VerificationMeta(
    'rawPayload',
  );
  @override
  late final GeneratedColumn<String> rawPayload = GeneratedColumn<String>(
    'raw_payload',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    timestamp,
    type,
    mac,
    ssid,
    authMode,
    channel,
    rssi,
    latitude,
    longitude,
    altitudeMeters,
    accuracyMeters,
    rawPayload,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wifi_ble_samples';
  @override
  VerificationContext validateIntegrity(
    Insertable<WifiBleSample> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('mac')) {
      context.handle(
        _macMeta,
        mac.isAcceptableOrUnknown(data['mac']!, _macMeta),
      );
    } else if (isInserting) {
      context.missing(_macMeta);
    }
    if (data.containsKey('ssid')) {
      context.handle(
        _ssidMeta,
        ssid.isAcceptableOrUnknown(data['ssid']!, _ssidMeta),
      );
    } else if (isInserting) {
      context.missing(_ssidMeta);
    }
    if (data.containsKey('auth_mode')) {
      context.handle(
        _authModeMeta,
        authMode.isAcceptableOrUnknown(data['auth_mode']!, _authModeMeta),
      );
    } else if (isInserting) {
      context.missing(_authModeMeta);
    }
    if (data.containsKey('channel')) {
      context.handle(
        _channelMeta,
        channel.isAcceptableOrUnknown(data['channel']!, _channelMeta),
      );
    } else if (isInserting) {
      context.missing(_channelMeta);
    }
    if (data.containsKey('rssi')) {
      context.handle(
        _rssiMeta,
        rssi.isAcceptableOrUnknown(data['rssi']!, _rssiMeta),
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
    if (data.containsKey('altitude_meters')) {
      context.handle(
        _altitudeMetersMeta,
        altitudeMeters.isAcceptableOrUnknown(
          data['altitude_meters']!,
          _altitudeMetersMeta,
        ),
      );
    }
    if (data.containsKey('accuracy_meters')) {
      context.handle(
        _accuracyMetersMeta,
        accuracyMeters.isAcceptableOrUnknown(
          data['accuracy_meters']!,
          _accuracyMetersMeta,
        ),
      );
    }
    if (data.containsKey('raw_payload')) {
      context.handle(
        _rawPayloadMeta,
        rawPayload.isAcceptableOrUnknown(data['raw_payload']!, _rawPayloadMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {sessionId, type, mac, timestamp},
  ];
  @override
  WifiBleSample map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WifiBleSample(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      mac: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mac'],
      )!,
      ssid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ssid'],
      )!,
      authMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}auth_mode'],
      )!,
      channel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}channel'],
      )!,
      rssi: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rssi'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      altitudeMeters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}altitude_meters'],
      ),
      accuracyMeters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_meters'],
      ),
      rawPayload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_payload'],
      ),
    );
  }

  @override
  $WifiBleSamplesTable createAlias(String alias) {
    return $WifiBleSamplesTable(attachedDatabase, alias);
  }
}

class WifiBleSample extends DataClass implements Insertable<WifiBleSample> {
  final int id;
  final String sessionId;
  final int timestamp;
  final String type;
  final String mac;
  final String ssid;
  final String authMode;
  final String channel;
  final int? rssi;
  final double? latitude;
  final double? longitude;
  final double? altitudeMeters;
  final double? accuracyMeters;
  final String? rawPayload;
  const WifiBleSample({
    required this.id,
    required this.sessionId,
    required this.timestamp,
    required this.type,
    required this.mac,
    required this.ssid,
    required this.authMode,
    required this.channel,
    this.rssi,
    this.latitude,
    this.longitude,
    this.altitudeMeters,
    this.accuracyMeters,
    this.rawPayload,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['timestamp'] = Variable<int>(timestamp);
    map['type'] = Variable<String>(type);
    map['mac'] = Variable<String>(mac);
    map['ssid'] = Variable<String>(ssid);
    map['auth_mode'] = Variable<String>(authMode);
    map['channel'] = Variable<String>(channel);
    if (!nullToAbsent || rssi != null) {
      map['rssi'] = Variable<int>(rssi);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || altitudeMeters != null) {
      map['altitude_meters'] = Variable<double>(altitudeMeters);
    }
    if (!nullToAbsent || accuracyMeters != null) {
      map['accuracy_meters'] = Variable<double>(accuracyMeters);
    }
    if (!nullToAbsent || rawPayload != null) {
      map['raw_payload'] = Variable<String>(rawPayload);
    }
    return map;
  }

  WifiBleSamplesCompanion toCompanion(bool nullToAbsent) {
    return WifiBleSamplesCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      timestamp: Value(timestamp),
      type: Value(type),
      mac: Value(mac),
      ssid: Value(ssid),
      authMode: Value(authMode),
      channel: Value(channel),
      rssi: rssi == null && nullToAbsent ? const Value.absent() : Value(rssi),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      altitudeMeters: altitudeMeters == null && nullToAbsent
          ? const Value.absent()
          : Value(altitudeMeters),
      accuracyMeters: accuracyMeters == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracyMeters),
      rawPayload: rawPayload == null && nullToAbsent
          ? const Value.absent()
          : Value(rawPayload),
    );
  }

  factory WifiBleSample.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WifiBleSample(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      type: serializer.fromJson<String>(json['type']),
      mac: serializer.fromJson<String>(json['mac']),
      ssid: serializer.fromJson<String>(json['ssid']),
      authMode: serializer.fromJson<String>(json['authMode']),
      channel: serializer.fromJson<String>(json['channel']),
      rssi: serializer.fromJson<int?>(json['rssi']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      altitudeMeters: serializer.fromJson<double?>(json['altitudeMeters']),
      accuracyMeters: serializer.fromJson<double?>(json['accuracyMeters']),
      rawPayload: serializer.fromJson<String?>(json['rawPayload']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'timestamp': serializer.toJson<int>(timestamp),
      'type': serializer.toJson<String>(type),
      'mac': serializer.toJson<String>(mac),
      'ssid': serializer.toJson<String>(ssid),
      'authMode': serializer.toJson<String>(authMode),
      'channel': serializer.toJson<String>(channel),
      'rssi': serializer.toJson<int?>(rssi),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'altitudeMeters': serializer.toJson<double?>(altitudeMeters),
      'accuracyMeters': serializer.toJson<double?>(accuracyMeters),
      'rawPayload': serializer.toJson<String?>(rawPayload),
    };
  }

  WifiBleSample copyWith({
    int? id,
    String? sessionId,
    int? timestamp,
    String? type,
    String? mac,
    String? ssid,
    String? authMode,
    String? channel,
    Value<int?> rssi = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<double?> altitudeMeters = const Value.absent(),
    Value<double?> accuracyMeters = const Value.absent(),
    Value<String?> rawPayload = const Value.absent(),
  }) => WifiBleSample(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    timestamp: timestamp ?? this.timestamp,
    type: type ?? this.type,
    mac: mac ?? this.mac,
    ssid: ssid ?? this.ssid,
    authMode: authMode ?? this.authMode,
    channel: channel ?? this.channel,
    rssi: rssi.present ? rssi.value : this.rssi,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    altitudeMeters: altitudeMeters.present
        ? altitudeMeters.value
        : this.altitudeMeters,
    accuracyMeters: accuracyMeters.present
        ? accuracyMeters.value
        : this.accuracyMeters,
    rawPayload: rawPayload.present ? rawPayload.value : this.rawPayload,
  );
  WifiBleSample copyWithCompanion(WifiBleSamplesCompanion data) {
    return WifiBleSample(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      type: data.type.present ? data.type.value : this.type,
      mac: data.mac.present ? data.mac.value : this.mac,
      ssid: data.ssid.present ? data.ssid.value : this.ssid,
      authMode: data.authMode.present ? data.authMode.value : this.authMode,
      channel: data.channel.present ? data.channel.value : this.channel,
      rssi: data.rssi.present ? data.rssi.value : this.rssi,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      altitudeMeters: data.altitudeMeters.present
          ? data.altitudeMeters.value
          : this.altitudeMeters,
      accuracyMeters: data.accuracyMeters.present
          ? data.accuracyMeters.value
          : this.accuracyMeters,
      rawPayload: data.rawPayload.present
          ? data.rawPayload.value
          : this.rawPayload,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WifiBleSample(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('timestamp: $timestamp, ')
          ..write('type: $type, ')
          ..write('mac: $mac, ')
          ..write('ssid: $ssid, ')
          ..write('authMode: $authMode, ')
          ..write('channel: $channel, ')
          ..write('rssi: $rssi, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('altitudeMeters: $altitudeMeters, ')
          ..write('accuracyMeters: $accuracyMeters, ')
          ..write('rawPayload: $rawPayload')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    timestamp,
    type,
    mac,
    ssid,
    authMode,
    channel,
    rssi,
    latitude,
    longitude,
    altitudeMeters,
    accuracyMeters,
    rawPayload,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WifiBleSample &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.timestamp == this.timestamp &&
          other.type == this.type &&
          other.mac == this.mac &&
          other.ssid == this.ssid &&
          other.authMode == this.authMode &&
          other.channel == this.channel &&
          other.rssi == this.rssi &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.altitudeMeters == this.altitudeMeters &&
          other.accuracyMeters == this.accuracyMeters &&
          other.rawPayload == this.rawPayload);
}

class WifiBleSamplesCompanion extends UpdateCompanion<WifiBleSample> {
  final Value<int> id;
  final Value<String> sessionId;
  final Value<int> timestamp;
  final Value<String> type;
  final Value<String> mac;
  final Value<String> ssid;
  final Value<String> authMode;
  final Value<String> channel;
  final Value<int?> rssi;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<double?> altitudeMeters;
  final Value<double?> accuracyMeters;
  final Value<String?> rawPayload;
  const WifiBleSamplesCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.type = const Value.absent(),
    this.mac = const Value.absent(),
    this.ssid = const Value.absent(),
    this.authMode = const Value.absent(),
    this.channel = const Value.absent(),
    this.rssi = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.altitudeMeters = const Value.absent(),
    this.accuracyMeters = const Value.absent(),
    this.rawPayload = const Value.absent(),
  });
  WifiBleSamplesCompanion.insert({
    this.id = const Value.absent(),
    required String sessionId,
    required int timestamp,
    required String type,
    required String mac,
    required String ssid,
    required String authMode,
    required String channel,
    this.rssi = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.altitudeMeters = const Value.absent(),
    this.accuracyMeters = const Value.absent(),
    this.rawPayload = const Value.absent(),
  }) : sessionId = Value(sessionId),
       timestamp = Value(timestamp),
       type = Value(type),
       mac = Value(mac),
       ssid = Value(ssid),
       authMode = Value(authMode),
       channel = Value(channel);
  static Insertable<WifiBleSample> custom({
    Expression<int>? id,
    Expression<String>? sessionId,
    Expression<int>? timestamp,
    Expression<String>? type,
    Expression<String>? mac,
    Expression<String>? ssid,
    Expression<String>? authMode,
    Expression<String>? channel,
    Expression<int>? rssi,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? altitudeMeters,
    Expression<double>? accuracyMeters,
    Expression<String>? rawPayload,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (timestamp != null) 'timestamp': timestamp,
      if (type != null) 'type': type,
      if (mac != null) 'mac': mac,
      if (ssid != null) 'ssid': ssid,
      if (authMode != null) 'auth_mode': authMode,
      if (channel != null) 'channel': channel,
      if (rssi != null) 'rssi': rssi,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (altitudeMeters != null) 'altitude_meters': altitudeMeters,
      if (accuracyMeters != null) 'accuracy_meters': accuracyMeters,
      if (rawPayload != null) 'raw_payload': rawPayload,
    });
  }

  WifiBleSamplesCompanion copyWith({
    Value<int>? id,
    Value<String>? sessionId,
    Value<int>? timestamp,
    Value<String>? type,
    Value<String>? mac,
    Value<String>? ssid,
    Value<String>? authMode,
    Value<String>? channel,
    Value<int?>? rssi,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<double?>? altitudeMeters,
    Value<double?>? accuracyMeters,
    Value<String?>? rawPayload,
  }) {
    return WifiBleSamplesCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      mac: mac ?? this.mac,
      ssid: ssid ?? this.ssid,
      authMode: authMode ?? this.authMode,
      channel: channel ?? this.channel,
      rssi: rssi ?? this.rssi,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      altitudeMeters: altitudeMeters ?? this.altitudeMeters,
      accuracyMeters: accuracyMeters ?? this.accuracyMeters,
      rawPayload: rawPayload ?? this.rawPayload,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (mac.present) {
      map['mac'] = Variable<String>(mac.value);
    }
    if (ssid.present) {
      map['ssid'] = Variable<String>(ssid.value);
    }
    if (authMode.present) {
      map['auth_mode'] = Variable<String>(authMode.value);
    }
    if (channel.present) {
      map['channel'] = Variable<String>(channel.value);
    }
    if (rssi.present) {
      map['rssi'] = Variable<int>(rssi.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (altitudeMeters.present) {
      map['altitude_meters'] = Variable<double>(altitudeMeters.value);
    }
    if (accuracyMeters.present) {
      map['accuracy_meters'] = Variable<double>(accuracyMeters.value);
    }
    if (rawPayload.present) {
      map['raw_payload'] = Variable<String>(rawPayload.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WifiBleSamplesCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('timestamp: $timestamp, ')
          ..write('type: $type, ')
          ..write('mac: $mac, ')
          ..write('ssid: $ssid, ')
          ..write('authMode: $authMode, ')
          ..write('channel: $channel, ')
          ..write('rssi: $rssi, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('altitudeMeters: $altitudeMeters, ')
          ..write('accuracyMeters: $accuracyMeters, ')
          ..write('rawPayload: $rawPayload')
          ..write(')'))
        .toString();
  }
}

class $LteSamplesTable extends LteSamples
    with TableInfo<$LteSamplesTable, LteSample> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LteSamplesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _technologyMeta = const VerificationMeta(
    'technology',
  );
  @override
  late final GeneratedColumn<String> technology = GeneratedColumn<String>(
    'technology',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mccMeta = const VerificationMeta('mcc');
  @override
  late final GeneratedColumn<String> mcc = GeneratedColumn<String>(
    'mcc',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mncMeta = const VerificationMeta('mnc');
  @override
  late final GeneratedColumn<String> mnc = GeneratedColumn<String>(
    'mnc',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lacMeta = const VerificationMeta('lac');
  @override
  late final GeneratedColumn<int> lac = GeneratedColumn<int>(
    'lac',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cellIdMeta = const VerificationMeta('cellId');
  @override
  late final GeneratedColumn<int> cellId = GeneratedColumn<int>(
    'cell_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pciMeta = const VerificationMeta('pci');
  @override
  late final GeneratedColumn<int> pci = GeneratedColumn<int>(
    'pci',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _earfcnMeta = const VerificationMeta('earfcn');
  @override
  late final GeneratedColumn<int> earfcn = GeneratedColumn<int>(
    'earfcn',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bandMeta = const VerificationMeta('band');
  @override
  late final GeneratedColumn<String> band = GeneratedColumn<String>(
    'band',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rssiMeta = const VerificationMeta('rssi');
  @override
  late final GeneratedColumn<int> rssi = GeneratedColumn<int>(
    'rssi',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rsrpMeta = const VerificationMeta('rsrp');
  @override
  late final GeneratedColumn<int> rsrp = GeneratedColumn<int>(
    'rsrp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rsrqMeta = const VerificationMeta('rsrq');
  @override
  late final GeneratedColumn<int> rsrq = GeneratedColumn<int>(
    'rsrq',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sinrMeta = const VerificationMeta('sinr');
  @override
  late final GeneratedColumn<int> sinr = GeneratedColumn<int>(
    'sinr',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _operatorNameMeta = const VerificationMeta(
    'operatorName',
  );
  @override
  late final GeneratedColumn<String> operatorName = GeneratedColumn<String>(
    'operator',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rawPayloadMeta = const VerificationMeta(
    'rawPayload',
  );
  @override
  late final GeneratedColumn<String> rawPayload = GeneratedColumn<String>(
    'raw_payload',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    timestamp,
    technology,
    state,
    mcc,
    mnc,
    lac,
    cellId,
    pci,
    earfcn,
    band,
    rssi,
    rsrp,
    rsrq,
    sinr,
    operatorName,
    longitude,
    latitude,
    rawPayload,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lte_samples';
  @override
  VerificationContext validateIntegrity(
    Insertable<LteSample> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('technology')) {
      context.handle(
        _technologyMeta,
        technology.isAcceptableOrUnknown(data['technology']!, _technologyMeta),
      );
    } else if (isInserting) {
      context.missing(_technologyMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('mcc')) {
      context.handle(
        _mccMeta,
        mcc.isAcceptableOrUnknown(data['mcc']!, _mccMeta),
      );
    }
    if (data.containsKey('mnc')) {
      context.handle(
        _mncMeta,
        mnc.isAcceptableOrUnknown(data['mnc']!, _mncMeta),
      );
    }
    if (data.containsKey('lac')) {
      context.handle(
        _lacMeta,
        lac.isAcceptableOrUnknown(data['lac']!, _lacMeta),
      );
    }
    if (data.containsKey('cell_id')) {
      context.handle(
        _cellIdMeta,
        cellId.isAcceptableOrUnknown(data['cell_id']!, _cellIdMeta),
      );
    }
    if (data.containsKey('pci')) {
      context.handle(
        _pciMeta,
        pci.isAcceptableOrUnknown(data['pci']!, _pciMeta),
      );
    }
    if (data.containsKey('earfcn')) {
      context.handle(
        _earfcnMeta,
        earfcn.isAcceptableOrUnknown(data['earfcn']!, _earfcnMeta),
      );
    }
    if (data.containsKey('band')) {
      context.handle(
        _bandMeta,
        band.isAcceptableOrUnknown(data['band']!, _bandMeta),
      );
    }
    if (data.containsKey('rssi')) {
      context.handle(
        _rssiMeta,
        rssi.isAcceptableOrUnknown(data['rssi']!, _rssiMeta),
      );
    }
    if (data.containsKey('rsrp')) {
      context.handle(
        _rsrpMeta,
        rsrp.isAcceptableOrUnknown(data['rsrp']!, _rsrpMeta),
      );
    }
    if (data.containsKey('rsrq')) {
      context.handle(
        _rsrqMeta,
        rsrq.isAcceptableOrUnknown(data['rsrq']!, _rsrqMeta),
      );
    }
    if (data.containsKey('sinr')) {
      context.handle(
        _sinrMeta,
        sinr.isAcceptableOrUnknown(data['sinr']!, _sinrMeta),
      );
    }
    if (data.containsKey('operator')) {
      context.handle(
        _operatorNameMeta,
        operatorName.isAcceptableOrUnknown(
          data['operator']!,
          _operatorNameMeta,
        ),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('raw_payload')) {
      context.handle(
        _rawPayloadMeta,
        rawPayload.isAcceptableOrUnknown(data['raw_payload']!, _rawPayloadMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {sessionId, timestamp, mcc, mnc, lac, cellId},
  ];
  @override
  LteSample map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LteSample(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timestamp'],
      )!,
      technology: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}technology'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      mcc: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mcc'],
      ),
      mnc: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mnc'],
      ),
      lac: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lac'],
      ),
      cellId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cell_id'],
      ),
      pci: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pci'],
      ),
      earfcn: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}earfcn'],
      ),
      band: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}band'],
      ),
      rssi: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rssi'],
      ),
      rsrp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rsrp'],
      ),
      rsrq: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rsrq'],
      ),
      sinr: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sinr'],
      ),
      operatorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operator'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      rawPayload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_payload'],
      ),
    );
  }

  @override
  $LteSamplesTable createAlias(String alias) {
    return $LteSamplesTable(attachedDatabase, alias);
  }
}

class LteSample extends DataClass implements Insertable<LteSample> {
  final int id;
  final String sessionId;
  final int timestamp;
  final String technology;
  final String state;
  final String? mcc;
  final String? mnc;
  final int? lac;
  final int? cellId;
  final int? pci;
  final int? earfcn;
  final String? band;
  final int? rssi;
  final int? rsrp;
  final int? rsrq;
  final int? sinr;
  final String? operatorName;
  final double? longitude;
  final double? latitude;
  final String? rawPayload;
  const LteSample({
    required this.id,
    required this.sessionId,
    required this.timestamp,
    required this.technology,
    required this.state,
    this.mcc,
    this.mnc,
    this.lac,
    this.cellId,
    this.pci,
    this.earfcn,
    this.band,
    this.rssi,
    this.rsrp,
    this.rsrq,
    this.sinr,
    this.operatorName,
    this.longitude,
    this.latitude,
    this.rawPayload,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['timestamp'] = Variable<int>(timestamp);
    map['technology'] = Variable<String>(technology);
    map['state'] = Variable<String>(state);
    if (!nullToAbsent || mcc != null) {
      map['mcc'] = Variable<String>(mcc);
    }
    if (!nullToAbsent || mnc != null) {
      map['mnc'] = Variable<String>(mnc);
    }
    if (!nullToAbsent || lac != null) {
      map['lac'] = Variable<int>(lac);
    }
    if (!nullToAbsent || cellId != null) {
      map['cell_id'] = Variable<int>(cellId);
    }
    if (!nullToAbsent || pci != null) {
      map['pci'] = Variable<int>(pci);
    }
    if (!nullToAbsent || earfcn != null) {
      map['earfcn'] = Variable<int>(earfcn);
    }
    if (!nullToAbsent || band != null) {
      map['band'] = Variable<String>(band);
    }
    if (!nullToAbsent || rssi != null) {
      map['rssi'] = Variable<int>(rssi);
    }
    if (!nullToAbsent || rsrp != null) {
      map['rsrp'] = Variable<int>(rsrp);
    }
    if (!nullToAbsent || rsrq != null) {
      map['rsrq'] = Variable<int>(rsrq);
    }
    if (!nullToAbsent || sinr != null) {
      map['sinr'] = Variable<int>(sinr);
    }
    if (!nullToAbsent || operatorName != null) {
      map['operator'] = Variable<String>(operatorName);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || rawPayload != null) {
      map['raw_payload'] = Variable<String>(rawPayload);
    }
    return map;
  }

  LteSamplesCompanion toCompanion(bool nullToAbsent) {
    return LteSamplesCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      timestamp: Value(timestamp),
      technology: Value(technology),
      state: Value(state),
      mcc: mcc == null && nullToAbsent ? const Value.absent() : Value(mcc),
      mnc: mnc == null && nullToAbsent ? const Value.absent() : Value(mnc),
      lac: lac == null && nullToAbsent ? const Value.absent() : Value(lac),
      cellId: cellId == null && nullToAbsent
          ? const Value.absent()
          : Value(cellId),
      pci: pci == null && nullToAbsent ? const Value.absent() : Value(pci),
      earfcn: earfcn == null && nullToAbsent
          ? const Value.absent()
          : Value(earfcn),
      band: band == null && nullToAbsent ? const Value.absent() : Value(band),
      rssi: rssi == null && nullToAbsent ? const Value.absent() : Value(rssi),
      rsrp: rsrp == null && nullToAbsent ? const Value.absent() : Value(rsrp),
      rsrq: rsrq == null && nullToAbsent ? const Value.absent() : Value(rsrq),
      sinr: sinr == null && nullToAbsent ? const Value.absent() : Value(sinr),
      operatorName: operatorName == null && nullToAbsent
          ? const Value.absent()
          : Value(operatorName),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      rawPayload: rawPayload == null && nullToAbsent
          ? const Value.absent()
          : Value(rawPayload),
    );
  }

  factory LteSample.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LteSample(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      timestamp: serializer.fromJson<int>(json['timestamp']),
      technology: serializer.fromJson<String>(json['technology']),
      state: serializer.fromJson<String>(json['state']),
      mcc: serializer.fromJson<String?>(json['mcc']),
      mnc: serializer.fromJson<String?>(json['mnc']),
      lac: serializer.fromJson<int?>(json['lac']),
      cellId: serializer.fromJson<int?>(json['cellId']),
      pci: serializer.fromJson<int?>(json['pci']),
      earfcn: serializer.fromJson<int?>(json['earfcn']),
      band: serializer.fromJson<String?>(json['band']),
      rssi: serializer.fromJson<int?>(json['rssi']),
      rsrp: serializer.fromJson<int?>(json['rsrp']),
      rsrq: serializer.fromJson<int?>(json['rsrq']),
      sinr: serializer.fromJson<int?>(json['sinr']),
      operatorName: serializer.fromJson<String?>(json['operatorName']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      rawPayload: serializer.fromJson<String?>(json['rawPayload']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'timestamp': serializer.toJson<int>(timestamp),
      'technology': serializer.toJson<String>(technology),
      'state': serializer.toJson<String>(state),
      'mcc': serializer.toJson<String?>(mcc),
      'mnc': serializer.toJson<String?>(mnc),
      'lac': serializer.toJson<int?>(lac),
      'cellId': serializer.toJson<int?>(cellId),
      'pci': serializer.toJson<int?>(pci),
      'earfcn': serializer.toJson<int?>(earfcn),
      'band': serializer.toJson<String?>(band),
      'rssi': serializer.toJson<int?>(rssi),
      'rsrp': serializer.toJson<int?>(rsrp),
      'rsrq': serializer.toJson<int?>(rsrq),
      'sinr': serializer.toJson<int?>(sinr),
      'operatorName': serializer.toJson<String?>(operatorName),
      'longitude': serializer.toJson<double?>(longitude),
      'latitude': serializer.toJson<double?>(latitude),
      'rawPayload': serializer.toJson<String?>(rawPayload),
    };
  }

  LteSample copyWith({
    int? id,
    String? sessionId,
    int? timestamp,
    String? technology,
    String? state,
    Value<String?> mcc = const Value.absent(),
    Value<String?> mnc = const Value.absent(),
    Value<int?> lac = const Value.absent(),
    Value<int?> cellId = const Value.absent(),
    Value<int?> pci = const Value.absent(),
    Value<int?> earfcn = const Value.absent(),
    Value<String?> band = const Value.absent(),
    Value<int?> rssi = const Value.absent(),
    Value<int?> rsrp = const Value.absent(),
    Value<int?> rsrq = const Value.absent(),
    Value<int?> sinr = const Value.absent(),
    Value<String?> operatorName = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<String?> rawPayload = const Value.absent(),
  }) => LteSample(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    timestamp: timestamp ?? this.timestamp,
    technology: technology ?? this.technology,
    state: state ?? this.state,
    mcc: mcc.present ? mcc.value : this.mcc,
    mnc: mnc.present ? mnc.value : this.mnc,
    lac: lac.present ? lac.value : this.lac,
    cellId: cellId.present ? cellId.value : this.cellId,
    pci: pci.present ? pci.value : this.pci,
    earfcn: earfcn.present ? earfcn.value : this.earfcn,
    band: band.present ? band.value : this.band,
    rssi: rssi.present ? rssi.value : this.rssi,
    rsrp: rsrp.present ? rsrp.value : this.rsrp,
    rsrq: rsrq.present ? rsrq.value : this.rsrq,
    sinr: sinr.present ? sinr.value : this.sinr,
    operatorName: operatorName.present ? operatorName.value : this.operatorName,
    longitude: longitude.present ? longitude.value : this.longitude,
    latitude: latitude.present ? latitude.value : this.latitude,
    rawPayload: rawPayload.present ? rawPayload.value : this.rawPayload,
  );
  LteSample copyWithCompanion(LteSamplesCompanion data) {
    return LteSample(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      technology: data.technology.present
          ? data.technology.value
          : this.technology,
      state: data.state.present ? data.state.value : this.state,
      mcc: data.mcc.present ? data.mcc.value : this.mcc,
      mnc: data.mnc.present ? data.mnc.value : this.mnc,
      lac: data.lac.present ? data.lac.value : this.lac,
      cellId: data.cellId.present ? data.cellId.value : this.cellId,
      pci: data.pci.present ? data.pci.value : this.pci,
      earfcn: data.earfcn.present ? data.earfcn.value : this.earfcn,
      band: data.band.present ? data.band.value : this.band,
      rssi: data.rssi.present ? data.rssi.value : this.rssi,
      rsrp: data.rsrp.present ? data.rsrp.value : this.rsrp,
      rsrq: data.rsrq.present ? data.rsrq.value : this.rsrq,
      sinr: data.sinr.present ? data.sinr.value : this.sinr,
      operatorName: data.operatorName.present
          ? data.operatorName.value
          : this.operatorName,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      rawPayload: data.rawPayload.present
          ? data.rawPayload.value
          : this.rawPayload,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LteSample(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('timestamp: $timestamp, ')
          ..write('technology: $technology, ')
          ..write('state: $state, ')
          ..write('mcc: $mcc, ')
          ..write('mnc: $mnc, ')
          ..write('lac: $lac, ')
          ..write('cellId: $cellId, ')
          ..write('pci: $pci, ')
          ..write('earfcn: $earfcn, ')
          ..write('band: $band, ')
          ..write('rssi: $rssi, ')
          ..write('rsrp: $rsrp, ')
          ..write('rsrq: $rsrq, ')
          ..write('sinr: $sinr, ')
          ..write('operatorName: $operatorName, ')
          ..write('longitude: $longitude, ')
          ..write('latitude: $latitude, ')
          ..write('rawPayload: $rawPayload')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    timestamp,
    technology,
    state,
    mcc,
    mnc,
    lac,
    cellId,
    pci,
    earfcn,
    band,
    rssi,
    rsrp,
    rsrq,
    sinr,
    operatorName,
    longitude,
    latitude,
    rawPayload,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LteSample &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.timestamp == this.timestamp &&
          other.technology == this.technology &&
          other.state == this.state &&
          other.mcc == this.mcc &&
          other.mnc == this.mnc &&
          other.lac == this.lac &&
          other.cellId == this.cellId &&
          other.pci == this.pci &&
          other.earfcn == this.earfcn &&
          other.band == this.band &&
          other.rssi == this.rssi &&
          other.rsrp == this.rsrp &&
          other.rsrq == this.rsrq &&
          other.sinr == this.sinr &&
          other.operatorName == this.operatorName &&
          other.longitude == this.longitude &&
          other.latitude == this.latitude &&
          other.rawPayload == this.rawPayload);
}

class LteSamplesCompanion extends UpdateCompanion<LteSample> {
  final Value<int> id;
  final Value<String> sessionId;
  final Value<int> timestamp;
  final Value<String> technology;
  final Value<String> state;
  final Value<String?> mcc;
  final Value<String?> mnc;
  final Value<int?> lac;
  final Value<int?> cellId;
  final Value<int?> pci;
  final Value<int?> earfcn;
  final Value<String?> band;
  final Value<int?> rssi;
  final Value<int?> rsrp;
  final Value<int?> rsrq;
  final Value<int?> sinr;
  final Value<String?> operatorName;
  final Value<double?> longitude;
  final Value<double?> latitude;
  final Value<String?> rawPayload;
  const LteSamplesCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.technology = const Value.absent(),
    this.state = const Value.absent(),
    this.mcc = const Value.absent(),
    this.mnc = const Value.absent(),
    this.lac = const Value.absent(),
    this.cellId = const Value.absent(),
    this.pci = const Value.absent(),
    this.earfcn = const Value.absent(),
    this.band = const Value.absent(),
    this.rssi = const Value.absent(),
    this.rsrp = const Value.absent(),
    this.rsrq = const Value.absent(),
    this.sinr = const Value.absent(),
    this.operatorName = const Value.absent(),
    this.longitude = const Value.absent(),
    this.latitude = const Value.absent(),
    this.rawPayload = const Value.absent(),
  });
  LteSamplesCompanion.insert({
    this.id = const Value.absent(),
    required String sessionId,
    required int timestamp,
    required String technology,
    required String state,
    this.mcc = const Value.absent(),
    this.mnc = const Value.absent(),
    this.lac = const Value.absent(),
    this.cellId = const Value.absent(),
    this.pci = const Value.absent(),
    this.earfcn = const Value.absent(),
    this.band = const Value.absent(),
    this.rssi = const Value.absent(),
    this.rsrp = const Value.absent(),
    this.rsrq = const Value.absent(),
    this.sinr = const Value.absent(),
    this.operatorName = const Value.absent(),
    this.longitude = const Value.absent(),
    this.latitude = const Value.absent(),
    this.rawPayload = const Value.absent(),
  }) : sessionId = Value(sessionId),
       timestamp = Value(timestamp),
       technology = Value(technology),
       state = Value(state);
  static Insertable<LteSample> custom({
    Expression<int>? id,
    Expression<String>? sessionId,
    Expression<int>? timestamp,
    Expression<String>? technology,
    Expression<String>? state,
    Expression<String>? mcc,
    Expression<String>? mnc,
    Expression<int>? lac,
    Expression<int>? cellId,
    Expression<int>? pci,
    Expression<int>? earfcn,
    Expression<String>? band,
    Expression<int>? rssi,
    Expression<int>? rsrp,
    Expression<int>? rsrq,
    Expression<int>? sinr,
    Expression<String>? operatorName,
    Expression<double>? longitude,
    Expression<double>? latitude,
    Expression<String>? rawPayload,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (timestamp != null) 'timestamp': timestamp,
      if (technology != null) 'technology': technology,
      if (state != null) 'state': state,
      if (mcc != null) 'mcc': mcc,
      if (mnc != null) 'mnc': mnc,
      if (lac != null) 'lac': lac,
      if (cellId != null) 'cell_id': cellId,
      if (pci != null) 'pci': pci,
      if (earfcn != null) 'earfcn': earfcn,
      if (band != null) 'band': band,
      if (rssi != null) 'rssi': rssi,
      if (rsrp != null) 'rsrp': rsrp,
      if (rsrq != null) 'rsrq': rsrq,
      if (sinr != null) 'sinr': sinr,
      if (operatorName != null) 'operator': operatorName,
      if (longitude != null) 'longitude': longitude,
      if (latitude != null) 'latitude': latitude,
      if (rawPayload != null) 'raw_payload': rawPayload,
    });
  }

  LteSamplesCompanion copyWith({
    Value<int>? id,
    Value<String>? sessionId,
    Value<int>? timestamp,
    Value<String>? technology,
    Value<String>? state,
    Value<String?>? mcc,
    Value<String?>? mnc,
    Value<int?>? lac,
    Value<int?>? cellId,
    Value<int?>? pci,
    Value<int?>? earfcn,
    Value<String?>? band,
    Value<int?>? rssi,
    Value<int?>? rsrp,
    Value<int?>? rsrq,
    Value<int?>? sinr,
    Value<String?>? operatorName,
    Value<double?>? longitude,
    Value<double?>? latitude,
    Value<String?>? rawPayload,
  }) {
    return LteSamplesCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      timestamp: timestamp ?? this.timestamp,
      technology: technology ?? this.technology,
      state: state ?? this.state,
      mcc: mcc ?? this.mcc,
      mnc: mnc ?? this.mnc,
      lac: lac ?? this.lac,
      cellId: cellId ?? this.cellId,
      pci: pci ?? this.pci,
      earfcn: earfcn ?? this.earfcn,
      band: band ?? this.band,
      rssi: rssi ?? this.rssi,
      rsrp: rsrp ?? this.rsrp,
      rsrq: rsrq ?? this.rsrq,
      sinr: sinr ?? this.sinr,
      operatorName: operatorName ?? this.operatorName,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      rawPayload: rawPayload ?? this.rawPayload,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<int>(timestamp.value);
    }
    if (technology.present) {
      map['technology'] = Variable<String>(technology.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (mcc.present) {
      map['mcc'] = Variable<String>(mcc.value);
    }
    if (mnc.present) {
      map['mnc'] = Variable<String>(mnc.value);
    }
    if (lac.present) {
      map['lac'] = Variable<int>(lac.value);
    }
    if (cellId.present) {
      map['cell_id'] = Variable<int>(cellId.value);
    }
    if (pci.present) {
      map['pci'] = Variable<int>(pci.value);
    }
    if (earfcn.present) {
      map['earfcn'] = Variable<int>(earfcn.value);
    }
    if (band.present) {
      map['band'] = Variable<String>(band.value);
    }
    if (rssi.present) {
      map['rssi'] = Variable<int>(rssi.value);
    }
    if (rsrp.present) {
      map['rsrp'] = Variable<int>(rsrp.value);
    }
    if (rsrq.present) {
      map['rsrq'] = Variable<int>(rsrq.value);
    }
    if (sinr.present) {
      map['sinr'] = Variable<int>(sinr.value);
    }
    if (operatorName.present) {
      map['operator'] = Variable<String>(operatorName.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (rawPayload.present) {
      map['raw_payload'] = Variable<String>(rawPayload.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LteSamplesCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('timestamp: $timestamp, ')
          ..write('technology: $technology, ')
          ..write('state: $state, ')
          ..write('mcc: $mcc, ')
          ..write('mnc: $mnc, ')
          ..write('lac: $lac, ')
          ..write('cellId: $cellId, ')
          ..write('pci: $pci, ')
          ..write('earfcn: $earfcn, ')
          ..write('band: $band, ')
          ..write('rssi: $rssi, ')
          ..write('rsrp: $rsrp, ')
          ..write('rsrq: $rsrq, ')
          ..write('sinr: $sinr, ')
          ..write('operatorName: $operatorName, ')
          ..write('longitude: $longitude, ')
          ..write('latitude: $latitude, ')
          ..write('rawPayload: $rawPayload')
          ..write(')'))
        .toString();
  }
}

class $PendingUploadsTable extends PendingUploads
    with TableInfo<$PendingUploadsTable, PendingUpload> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingUploadsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uploadTypeMeta = const VerificationMeta(
    'uploadType',
  );
  @override
  late final GeneratedColumn<String> uploadType = GeneratedColumn<String>(
    'upload_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sampleCountMeta = const VerificationMeta(
    'sampleCount',
  );
  @override
  late final GeneratedColumn<int> sampleCount = GeneratedColumn<int>(
    'sample_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remoteSourceMeta = const VerificationMeta(
    'remoteSource',
  );
  @override
  late final GeneratedColumn<String> remoteSource = GeneratedColumn<String>(
    'remote_source',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remoteHashSha256Meta = const VerificationMeta(
    'remoteHashSha256',
  );
  @override
  late final GeneratedColumn<String> remoteHashSha256 = GeneratedColumn<String>(
    'remote_hash_sha256',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isProcessedMeta = const VerificationMeta(
    'isProcessed',
  );
  @override
  late final GeneratedColumn<bool> isProcessed = GeneratedColumn<bool>(
    'is_processed',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_processed" IN (0, 1))',
    ),
  );
  static const VerificationMeta _responseReceivedAtMeta =
      const VerificationMeta('responseReceivedAt');
  @override
  late final GeneratedColumn<int> responseReceivedAt = GeneratedColumn<int>(
    'response_received_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _uploadedAtMeta = const VerificationMeta(
    'uploadedAt',
  );
  @override
  late final GeneratedColumn<int> uploadedAt = GeneratedColumn<int>(
    'uploaded_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    uploadType,
    filePath,
    createdAt,
    sampleCount,
    retryCount,
    lastError,
    remoteId,
    remoteSource,
    remoteHashSha256,
    isProcessed,
    responseReceivedAt,
    uploadedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_uploads';
  @override
  VerificationContext validateIntegrity(
    Insertable<PendingUpload> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('upload_type')) {
      context.handle(
        _uploadTypeMeta,
        uploadType.isAcceptableOrUnknown(data['upload_type']!, _uploadTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_uploadTypeMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('sample_count')) {
      context.handle(
        _sampleCountMeta,
        sampleCount.isAcceptableOrUnknown(
          data['sample_count']!,
          _sampleCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sampleCountMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('remote_source')) {
      context.handle(
        _remoteSourceMeta,
        remoteSource.isAcceptableOrUnknown(
          data['remote_source']!,
          _remoteSourceMeta,
        ),
      );
    }
    if (data.containsKey('remote_hash_sha256')) {
      context.handle(
        _remoteHashSha256Meta,
        remoteHashSha256.isAcceptableOrUnknown(
          data['remote_hash_sha256']!,
          _remoteHashSha256Meta,
        ),
      );
    }
    if (data.containsKey('is_processed')) {
      context.handle(
        _isProcessedMeta,
        isProcessed.isAcceptableOrUnknown(
          data['is_processed']!,
          _isProcessedMeta,
        ),
      );
    }
    if (data.containsKey('response_received_at')) {
      context.handle(
        _responseReceivedAtMeta,
        responseReceivedAt.isAcceptableOrUnknown(
          data['response_received_at']!,
          _responseReceivedAtMeta,
        ),
      );
    }
    if (data.containsKey('uploaded_at')) {
      context.handle(
        _uploadedAtMeta,
        uploadedAt.isAcceptableOrUnknown(data['uploaded_at']!, _uploadedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {sessionId, uploadType},
  ];
  @override
  PendingUpload map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingUpload(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      uploadType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}upload_type'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at'],
      )!,
      sampleCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sample_count'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
      remoteSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_source'],
      ),
      remoteHashSha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_hash_sha256'],
      ),
      isProcessed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_processed'],
      ),
      responseReceivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}response_received_at'],
      ),
      uploadedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}uploaded_at'],
      ),
    );
  }

  @override
  $PendingUploadsTable createAlias(String alias) {
    return $PendingUploadsTable(attachedDatabase, alias);
  }
}

class PendingUpload extends DataClass implements Insertable<PendingUpload> {
  final int id;
  final String sessionId;
  final String uploadType;
  final String filePath;
  final int createdAt;
  final int sampleCount;
  final int retryCount;
  final String? lastError;
  final String? remoteId;
  final String? remoteSource;
  final String? remoteHashSha256;
  final bool? isProcessed;
  final int? responseReceivedAt;
  final int? uploadedAt;
  const PendingUpload({
    required this.id,
    required this.sessionId,
    required this.uploadType,
    required this.filePath,
    required this.createdAt,
    required this.sampleCount,
    required this.retryCount,
    this.lastError,
    this.remoteId,
    this.remoteSource,
    this.remoteHashSha256,
    this.isProcessed,
    this.responseReceivedAt,
    this.uploadedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['upload_type'] = Variable<String>(uploadType);
    map['file_path'] = Variable<String>(filePath);
    map['created_at'] = Variable<int>(createdAt);
    map['sample_count'] = Variable<int>(sampleCount);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    if (!nullToAbsent || remoteSource != null) {
      map['remote_source'] = Variable<String>(remoteSource);
    }
    if (!nullToAbsent || remoteHashSha256 != null) {
      map['remote_hash_sha256'] = Variable<String>(remoteHashSha256);
    }
    if (!nullToAbsent || isProcessed != null) {
      map['is_processed'] = Variable<bool>(isProcessed);
    }
    if (!nullToAbsent || responseReceivedAt != null) {
      map['response_received_at'] = Variable<int>(responseReceivedAt);
    }
    if (!nullToAbsent || uploadedAt != null) {
      map['uploaded_at'] = Variable<int>(uploadedAt);
    }
    return map;
  }

  PendingUploadsCompanion toCompanion(bool nullToAbsent) {
    return PendingUploadsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      uploadType: Value(uploadType),
      filePath: Value(filePath),
      createdAt: Value(createdAt),
      sampleCount: Value(sampleCount),
      retryCount: Value(retryCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      remoteSource: remoteSource == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteSource),
      remoteHashSha256: remoteHashSha256 == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteHashSha256),
      isProcessed: isProcessed == null && nullToAbsent
          ? const Value.absent()
          : Value(isProcessed),
      responseReceivedAt: responseReceivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(responseReceivedAt),
      uploadedAt: uploadedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(uploadedAt),
    );
  }

  factory PendingUpload.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingUpload(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      uploadType: serializer.fromJson<String>(json['uploadType']),
      filePath: serializer.fromJson<String>(json['filePath']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      sampleCount: serializer.fromJson<int>(json['sampleCount']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      remoteSource: serializer.fromJson<String?>(json['remoteSource']),
      remoteHashSha256: serializer.fromJson<String?>(json['remoteHashSha256']),
      isProcessed: serializer.fromJson<bool?>(json['isProcessed']),
      responseReceivedAt: serializer.fromJson<int?>(json['responseReceivedAt']),
      uploadedAt: serializer.fromJson<int?>(json['uploadedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'uploadType': serializer.toJson<String>(uploadType),
      'filePath': serializer.toJson<String>(filePath),
      'createdAt': serializer.toJson<int>(createdAt),
      'sampleCount': serializer.toJson<int>(sampleCount),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastError': serializer.toJson<String?>(lastError),
      'remoteId': serializer.toJson<String?>(remoteId),
      'remoteSource': serializer.toJson<String?>(remoteSource),
      'remoteHashSha256': serializer.toJson<String?>(remoteHashSha256),
      'isProcessed': serializer.toJson<bool?>(isProcessed),
      'responseReceivedAt': serializer.toJson<int?>(responseReceivedAt),
      'uploadedAt': serializer.toJson<int?>(uploadedAt),
    };
  }

  PendingUpload copyWith({
    int? id,
    String? sessionId,
    String? uploadType,
    String? filePath,
    int? createdAt,
    int? sampleCount,
    int? retryCount,
    Value<String?> lastError = const Value.absent(),
    Value<String?> remoteId = const Value.absent(),
    Value<String?> remoteSource = const Value.absent(),
    Value<String?> remoteHashSha256 = const Value.absent(),
    Value<bool?> isProcessed = const Value.absent(),
    Value<int?> responseReceivedAt = const Value.absent(),
    Value<int?> uploadedAt = const Value.absent(),
  }) => PendingUpload(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    uploadType: uploadType ?? this.uploadType,
    filePath: filePath ?? this.filePath,
    createdAt: createdAt ?? this.createdAt,
    sampleCount: sampleCount ?? this.sampleCount,
    retryCount: retryCount ?? this.retryCount,
    lastError: lastError.present ? lastError.value : this.lastError,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    remoteSource: remoteSource.present ? remoteSource.value : this.remoteSource,
    remoteHashSha256: remoteHashSha256.present
        ? remoteHashSha256.value
        : this.remoteHashSha256,
    isProcessed: isProcessed.present ? isProcessed.value : this.isProcessed,
    responseReceivedAt: responseReceivedAt.present
        ? responseReceivedAt.value
        : this.responseReceivedAt,
    uploadedAt: uploadedAt.present ? uploadedAt.value : this.uploadedAt,
  );
  PendingUpload copyWithCompanion(PendingUploadsCompanion data) {
    return PendingUpload(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      uploadType: data.uploadType.present
          ? data.uploadType.value
          : this.uploadType,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      sampleCount: data.sampleCount.present
          ? data.sampleCount.value
          : this.sampleCount,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      remoteSource: data.remoteSource.present
          ? data.remoteSource.value
          : this.remoteSource,
      remoteHashSha256: data.remoteHashSha256.present
          ? data.remoteHashSha256.value
          : this.remoteHashSha256,
      isProcessed: data.isProcessed.present
          ? data.isProcessed.value
          : this.isProcessed,
      responseReceivedAt: data.responseReceivedAt.present
          ? data.responseReceivedAt.value
          : this.responseReceivedAt,
      uploadedAt: data.uploadedAt.present
          ? data.uploadedAt.value
          : this.uploadedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingUpload(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('uploadType: $uploadType, ')
          ..write('filePath: $filePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('sampleCount: $sampleCount, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('remoteId: $remoteId, ')
          ..write('remoteSource: $remoteSource, ')
          ..write('remoteHashSha256: $remoteHashSha256, ')
          ..write('isProcessed: $isProcessed, ')
          ..write('responseReceivedAt: $responseReceivedAt, ')
          ..write('uploadedAt: $uploadedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    uploadType,
    filePath,
    createdAt,
    sampleCount,
    retryCount,
    lastError,
    remoteId,
    remoteSource,
    remoteHashSha256,
    isProcessed,
    responseReceivedAt,
    uploadedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingUpload &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.uploadType == this.uploadType &&
          other.filePath == this.filePath &&
          other.createdAt == this.createdAt &&
          other.sampleCount == this.sampleCount &&
          other.retryCount == this.retryCount &&
          other.lastError == this.lastError &&
          other.remoteId == this.remoteId &&
          other.remoteSource == this.remoteSource &&
          other.remoteHashSha256 == this.remoteHashSha256 &&
          other.isProcessed == this.isProcessed &&
          other.responseReceivedAt == this.responseReceivedAt &&
          other.uploadedAt == this.uploadedAt);
}

class PendingUploadsCompanion extends UpdateCompanion<PendingUpload> {
  final Value<int> id;
  final Value<String> sessionId;
  final Value<String> uploadType;
  final Value<String> filePath;
  final Value<int> createdAt;
  final Value<int> sampleCount;
  final Value<int> retryCount;
  final Value<String?> lastError;
  final Value<String?> remoteId;
  final Value<String?> remoteSource;
  final Value<String?> remoteHashSha256;
  final Value<bool?> isProcessed;
  final Value<int?> responseReceivedAt;
  final Value<int?> uploadedAt;
  const PendingUploadsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.uploadType = const Value.absent(),
    this.filePath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.sampleCount = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.remoteSource = const Value.absent(),
    this.remoteHashSha256 = const Value.absent(),
    this.isProcessed = const Value.absent(),
    this.responseReceivedAt = const Value.absent(),
    this.uploadedAt = const Value.absent(),
  });
  PendingUploadsCompanion.insert({
    this.id = const Value.absent(),
    required String sessionId,
    required String uploadType,
    required String filePath,
    required int createdAt,
    required int sampleCount,
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.remoteSource = const Value.absent(),
    this.remoteHashSha256 = const Value.absent(),
    this.isProcessed = const Value.absent(),
    this.responseReceivedAt = const Value.absent(),
    this.uploadedAt = const Value.absent(),
  }) : sessionId = Value(sessionId),
       uploadType = Value(uploadType),
       filePath = Value(filePath),
       createdAt = Value(createdAt),
       sampleCount = Value(sampleCount);
  static Insertable<PendingUpload> custom({
    Expression<int>? id,
    Expression<String>? sessionId,
    Expression<String>? uploadType,
    Expression<String>? filePath,
    Expression<int>? createdAt,
    Expression<int>? sampleCount,
    Expression<int>? retryCount,
    Expression<String>? lastError,
    Expression<String>? remoteId,
    Expression<String>? remoteSource,
    Expression<String>? remoteHashSha256,
    Expression<bool>? isProcessed,
    Expression<int>? responseReceivedAt,
    Expression<int>? uploadedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (uploadType != null) 'upload_type': uploadType,
      if (filePath != null) 'file_path': filePath,
      if (createdAt != null) 'created_at': createdAt,
      if (sampleCount != null) 'sample_count': sampleCount,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastError != null) 'last_error': lastError,
      if (remoteId != null) 'remote_id': remoteId,
      if (remoteSource != null) 'remote_source': remoteSource,
      if (remoteHashSha256 != null) 'remote_hash_sha256': remoteHashSha256,
      if (isProcessed != null) 'is_processed': isProcessed,
      if (responseReceivedAt != null)
        'response_received_at': responseReceivedAt,
      if (uploadedAt != null) 'uploaded_at': uploadedAt,
    });
  }

  PendingUploadsCompanion copyWith({
    Value<int>? id,
    Value<String>? sessionId,
    Value<String>? uploadType,
    Value<String>? filePath,
    Value<int>? createdAt,
    Value<int>? sampleCount,
    Value<int>? retryCount,
    Value<String?>? lastError,
    Value<String?>? remoteId,
    Value<String?>? remoteSource,
    Value<String?>? remoteHashSha256,
    Value<bool?>? isProcessed,
    Value<int?>? responseReceivedAt,
    Value<int?>? uploadedAt,
  }) {
    return PendingUploadsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      uploadType: uploadType ?? this.uploadType,
      filePath: filePath ?? this.filePath,
      createdAt: createdAt ?? this.createdAt,
      sampleCount: sampleCount ?? this.sampleCount,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
      remoteId: remoteId ?? this.remoteId,
      remoteSource: remoteSource ?? this.remoteSource,
      remoteHashSha256: remoteHashSha256 ?? this.remoteHashSha256,
      isProcessed: isProcessed ?? this.isProcessed,
      responseReceivedAt: responseReceivedAt ?? this.responseReceivedAt,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (uploadType.present) {
      map['upload_type'] = Variable<String>(uploadType.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (sampleCount.present) {
      map['sample_count'] = Variable<int>(sampleCount.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (remoteSource.present) {
      map['remote_source'] = Variable<String>(remoteSource.value);
    }
    if (remoteHashSha256.present) {
      map['remote_hash_sha256'] = Variable<String>(remoteHashSha256.value);
    }
    if (isProcessed.present) {
      map['is_processed'] = Variable<bool>(isProcessed.value);
    }
    if (responseReceivedAt.present) {
      map['response_received_at'] = Variable<int>(responseReceivedAt.value);
    }
    if (uploadedAt.present) {
      map['uploaded_at'] = Variable<int>(uploadedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingUploadsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('uploadType: $uploadType, ')
          ..write('filePath: $filePath, ')
          ..write('createdAt: $createdAt, ')
          ..write('sampleCount: $sampleCount, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('remoteId: $remoteId, ')
          ..write('remoteSource: $remoteSource, ')
          ..write('remoteHashSha256: $remoteHashSha256, ')
          ..write('isProcessed: $isProcessed, ')
          ..write('responseReceivedAt: $responseReceivedAt, ')
          ..write('uploadedAt: $uploadedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$WardrivingDatabase extends GeneratedDatabase {
  _$WardrivingDatabase(QueryExecutor e) : super(e);
  $WardrivingDatabaseManager get managers => $WardrivingDatabaseManager(this);
  late final $WardrivingSessionsTable wardrivingSessions =
      $WardrivingSessionsTable(this);
  late final $LocationSamplesTable locationSamples = $LocationSamplesTable(
    this,
  );
  late final $WifiBleSamplesTable wifiBleSamples = $WifiBleSamplesTable(this);
  late final $LteSamplesTable lteSamples = $LteSamplesTable(this);
  late final $PendingUploadsTable pendingUploads = $PendingUploadsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    wardrivingSessions,
    locationSamples,
    wifiBleSamples,
    lteSamples,
    pendingUploads,
  ];
}

typedef $$WardrivingSessionsTableCreateCompanionBuilder =
    WardrivingSessionsCompanion Function({
      required String id,
      required int startedAt,
      Value<int?> endedAt,
      required String status,
      required String deviceSource,
      Value<String?> notes,
      required bool wifiEnabled,
      required bool bleEnabled,
      required bool lteEnabled,
      Value<bool> uploaded,
      Value<String?> localExportPath,
      Value<int> rowid,
    });
typedef $$WardrivingSessionsTableUpdateCompanionBuilder =
    WardrivingSessionsCompanion Function({
      Value<String> id,
      Value<int> startedAt,
      Value<int?> endedAt,
      Value<String> status,
      Value<String> deviceSource,
      Value<String?> notes,
      Value<bool> wifiEnabled,
      Value<bool> bleEnabled,
      Value<bool> lteEnabled,
      Value<bool> uploaded,
      Value<String?> localExportPath,
      Value<int> rowid,
    });

class $$WardrivingSessionsTableFilterComposer
    extends Composer<_$WardrivingDatabase, $WardrivingSessionsTable> {
  $$WardrivingSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceSource => $composableBuilder(
    column: $table.deviceSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get wifiEnabled => $composableBuilder(
    column: $table.wifiEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get bleEnabled => $composableBuilder(
    column: $table.bleEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get lteEnabled => $composableBuilder(
    column: $table.lteEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get uploaded => $composableBuilder(
    column: $table.uploaded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localExportPath => $composableBuilder(
    column: $table.localExportPath,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WardrivingSessionsTableOrderingComposer
    extends Composer<_$WardrivingDatabase, $WardrivingSessionsTable> {
  $$WardrivingSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceSource => $composableBuilder(
    column: $table.deviceSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get wifiEnabled => $composableBuilder(
    column: $table.wifiEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get bleEnabled => $composableBuilder(
    column: $table.bleEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get lteEnabled => $composableBuilder(
    column: $table.lteEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get uploaded => $composableBuilder(
    column: $table.uploaded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localExportPath => $composableBuilder(
    column: $table.localExportPath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WardrivingSessionsTableAnnotationComposer
    extends Composer<_$WardrivingDatabase, $WardrivingSessionsTable> {
  $$WardrivingSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<int> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get deviceSource => $composableBuilder(
    column: $table.deviceSource,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get wifiEnabled => $composableBuilder(
    column: $table.wifiEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get bleEnabled => $composableBuilder(
    column: $table.bleEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get lteEnabled => $composableBuilder(
    column: $table.lteEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get uploaded =>
      $composableBuilder(column: $table.uploaded, builder: (column) => column);

  GeneratedColumn<String> get localExportPath => $composableBuilder(
    column: $table.localExportPath,
    builder: (column) => column,
  );
}

class $$WardrivingSessionsTableTableManager
    extends
        RootTableManager<
          _$WardrivingDatabase,
          $WardrivingSessionsTable,
          WardrivingSession,
          $$WardrivingSessionsTableFilterComposer,
          $$WardrivingSessionsTableOrderingComposer,
          $$WardrivingSessionsTableAnnotationComposer,
          $$WardrivingSessionsTableCreateCompanionBuilder,
          $$WardrivingSessionsTableUpdateCompanionBuilder,
          (
            WardrivingSession,
            BaseReferences<
              _$WardrivingDatabase,
              $WardrivingSessionsTable,
              WardrivingSession
            >,
          ),
          WardrivingSession,
          PrefetchHooks Function()
        > {
  $$WardrivingSessionsTableTableManager(
    _$WardrivingDatabase db,
    $WardrivingSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WardrivingSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WardrivingSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WardrivingSessionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> startedAt = const Value.absent(),
                Value<int?> endedAt = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> deviceSource = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> wifiEnabled = const Value.absent(),
                Value<bool> bleEnabled = const Value.absent(),
                Value<bool> lteEnabled = const Value.absent(),
                Value<bool> uploaded = const Value.absent(),
                Value<String?> localExportPath = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WardrivingSessionsCompanion(
                id: id,
                startedAt: startedAt,
                endedAt: endedAt,
                status: status,
                deviceSource: deviceSource,
                notes: notes,
                wifiEnabled: wifiEnabled,
                bleEnabled: bleEnabled,
                lteEnabled: lteEnabled,
                uploaded: uploaded,
                localExportPath: localExportPath,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int startedAt,
                Value<int?> endedAt = const Value.absent(),
                required String status,
                required String deviceSource,
                Value<String?> notes = const Value.absent(),
                required bool wifiEnabled,
                required bool bleEnabled,
                required bool lteEnabled,
                Value<bool> uploaded = const Value.absent(),
                Value<String?> localExportPath = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WardrivingSessionsCompanion.insert(
                id: id,
                startedAt: startedAt,
                endedAt: endedAt,
                status: status,
                deviceSource: deviceSource,
                notes: notes,
                wifiEnabled: wifiEnabled,
                bleEnabled: bleEnabled,
                lteEnabled: lteEnabled,
                uploaded: uploaded,
                localExportPath: localExportPath,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WardrivingSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$WardrivingDatabase,
      $WardrivingSessionsTable,
      WardrivingSession,
      $$WardrivingSessionsTableFilterComposer,
      $$WardrivingSessionsTableOrderingComposer,
      $$WardrivingSessionsTableAnnotationComposer,
      $$WardrivingSessionsTableCreateCompanionBuilder,
      $$WardrivingSessionsTableUpdateCompanionBuilder,
      (
        WardrivingSession,
        BaseReferences<
          _$WardrivingDatabase,
          $WardrivingSessionsTable,
          WardrivingSession
        >,
      ),
      WardrivingSession,
      PrefetchHooks Function()
    >;
typedef $$LocationSamplesTableCreateCompanionBuilder =
    LocationSamplesCompanion Function({
      Value<int> id,
      required String sessionId,
      required int timestamp,
      required double latitude,
      required double longitude,
      Value<double?> altitudeMeters,
      Value<double?> accuracyMeters,
      Value<double?> speedMetersPerSecond,
      Value<double?> bearingDegrees,
    });
typedef $$LocationSamplesTableUpdateCompanionBuilder =
    LocationSamplesCompanion Function({
      Value<int> id,
      Value<String> sessionId,
      Value<int> timestamp,
      Value<double> latitude,
      Value<double> longitude,
      Value<double?> altitudeMeters,
      Value<double?> accuracyMeters,
      Value<double?> speedMetersPerSecond,
      Value<double?> bearingDegrees,
    });

class $$LocationSamplesTableFilterComposer
    extends Composer<_$WardrivingDatabase, $LocationSamplesTable> {
  $$LocationSamplesTableFilterComposer({
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

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get altitudeMeters => $composableBuilder(
    column: $table.altitudeMeters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyMeters => $composableBuilder(
    column: $table.accuracyMeters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get speedMetersPerSecond => $composableBuilder(
    column: $table.speedMetersPerSecond,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bearingDegrees => $composableBuilder(
    column: $table.bearingDegrees,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocationSamplesTableOrderingComposer
    extends Composer<_$WardrivingDatabase, $LocationSamplesTable> {
  $$LocationSamplesTableOrderingComposer({
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

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get altitudeMeters => $composableBuilder(
    column: $table.altitudeMeters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyMeters => $composableBuilder(
    column: $table.accuracyMeters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get speedMetersPerSecond => $composableBuilder(
    column: $table.speedMetersPerSecond,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bearingDegrees => $composableBuilder(
    column: $table.bearingDegrees,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocationSamplesTableAnnotationComposer
    extends Composer<_$WardrivingDatabase, $LocationSamplesTable> {
  $$LocationSamplesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get altitudeMeters => $composableBuilder(
    column: $table.altitudeMeters,
    builder: (column) => column,
  );

  GeneratedColumn<double> get accuracyMeters => $composableBuilder(
    column: $table.accuracyMeters,
    builder: (column) => column,
  );

  GeneratedColumn<double> get speedMetersPerSecond => $composableBuilder(
    column: $table.speedMetersPerSecond,
    builder: (column) => column,
  );

  GeneratedColumn<double> get bearingDegrees => $composableBuilder(
    column: $table.bearingDegrees,
    builder: (column) => column,
  );
}

class $$LocationSamplesTableTableManager
    extends
        RootTableManager<
          _$WardrivingDatabase,
          $LocationSamplesTable,
          LocationSample,
          $$LocationSamplesTableFilterComposer,
          $$LocationSamplesTableOrderingComposer,
          $$LocationSamplesTableAnnotationComposer,
          $$LocationSamplesTableCreateCompanionBuilder,
          $$LocationSamplesTableUpdateCompanionBuilder,
          (
            LocationSample,
            BaseReferences<
              _$WardrivingDatabase,
              $LocationSamplesTable,
              LocationSample
            >,
          ),
          LocationSample,
          PrefetchHooks Function()
        > {
  $$LocationSamplesTableTableManager(
    _$WardrivingDatabase db,
    $LocationSamplesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocationSamplesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocationSamplesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocationSamplesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<int> timestamp = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<double?> altitudeMeters = const Value.absent(),
                Value<double?> accuracyMeters = const Value.absent(),
                Value<double?> speedMetersPerSecond = const Value.absent(),
                Value<double?> bearingDegrees = const Value.absent(),
              }) => LocationSamplesCompanion(
                id: id,
                sessionId: sessionId,
                timestamp: timestamp,
                latitude: latitude,
                longitude: longitude,
                altitudeMeters: altitudeMeters,
                accuracyMeters: accuracyMeters,
                speedMetersPerSecond: speedMetersPerSecond,
                bearingDegrees: bearingDegrees,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sessionId,
                required int timestamp,
                required double latitude,
                required double longitude,
                Value<double?> altitudeMeters = const Value.absent(),
                Value<double?> accuracyMeters = const Value.absent(),
                Value<double?> speedMetersPerSecond = const Value.absent(),
                Value<double?> bearingDegrees = const Value.absent(),
              }) => LocationSamplesCompanion.insert(
                id: id,
                sessionId: sessionId,
                timestamp: timestamp,
                latitude: latitude,
                longitude: longitude,
                altitudeMeters: altitudeMeters,
                accuracyMeters: accuracyMeters,
                speedMetersPerSecond: speedMetersPerSecond,
                bearingDegrees: bearingDegrees,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocationSamplesTableProcessedTableManager =
    ProcessedTableManager<
      _$WardrivingDatabase,
      $LocationSamplesTable,
      LocationSample,
      $$LocationSamplesTableFilterComposer,
      $$LocationSamplesTableOrderingComposer,
      $$LocationSamplesTableAnnotationComposer,
      $$LocationSamplesTableCreateCompanionBuilder,
      $$LocationSamplesTableUpdateCompanionBuilder,
      (
        LocationSample,
        BaseReferences<
          _$WardrivingDatabase,
          $LocationSamplesTable,
          LocationSample
        >,
      ),
      LocationSample,
      PrefetchHooks Function()
    >;
typedef $$WifiBleSamplesTableCreateCompanionBuilder =
    WifiBleSamplesCompanion Function({
      Value<int> id,
      required String sessionId,
      required int timestamp,
      required String type,
      required String mac,
      required String ssid,
      required String authMode,
      required String channel,
      Value<int?> rssi,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<double?> altitudeMeters,
      Value<double?> accuracyMeters,
      Value<String?> rawPayload,
    });
typedef $$WifiBleSamplesTableUpdateCompanionBuilder =
    WifiBleSamplesCompanion Function({
      Value<int> id,
      Value<String> sessionId,
      Value<int> timestamp,
      Value<String> type,
      Value<String> mac,
      Value<String> ssid,
      Value<String> authMode,
      Value<String> channel,
      Value<int?> rssi,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<double?> altitudeMeters,
      Value<double?> accuracyMeters,
      Value<String?> rawPayload,
    });

class $$WifiBleSamplesTableFilterComposer
    extends Composer<_$WardrivingDatabase, $WifiBleSamplesTable> {
  $$WifiBleSamplesTableFilterComposer({
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

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mac => $composableBuilder(
    column: $table.mac,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ssid => $composableBuilder(
    column: $table.ssid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authMode => $composableBuilder(
    column: $table.authMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get channel => $composableBuilder(
    column: $table.channel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rssi => $composableBuilder(
    column: $table.rssi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get altitudeMeters => $composableBuilder(
    column: $table.altitudeMeters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyMeters => $composableBuilder(
    column: $table.accuracyMeters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawPayload => $composableBuilder(
    column: $table.rawPayload,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WifiBleSamplesTableOrderingComposer
    extends Composer<_$WardrivingDatabase, $WifiBleSamplesTable> {
  $$WifiBleSamplesTableOrderingComposer({
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

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mac => $composableBuilder(
    column: $table.mac,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ssid => $composableBuilder(
    column: $table.ssid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authMode => $composableBuilder(
    column: $table.authMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get channel => $composableBuilder(
    column: $table.channel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rssi => $composableBuilder(
    column: $table.rssi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get altitudeMeters => $composableBuilder(
    column: $table.altitudeMeters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyMeters => $composableBuilder(
    column: $table.accuracyMeters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawPayload => $composableBuilder(
    column: $table.rawPayload,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WifiBleSamplesTableAnnotationComposer
    extends Composer<_$WardrivingDatabase, $WifiBleSamplesTable> {
  $$WifiBleSamplesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get mac =>
      $composableBuilder(column: $table.mac, builder: (column) => column);

  GeneratedColumn<String> get ssid =>
      $composableBuilder(column: $table.ssid, builder: (column) => column);

  GeneratedColumn<String> get authMode =>
      $composableBuilder(column: $table.authMode, builder: (column) => column);

  GeneratedColumn<String> get channel =>
      $composableBuilder(column: $table.channel, builder: (column) => column);

  GeneratedColumn<int> get rssi =>
      $composableBuilder(column: $table.rssi, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get altitudeMeters => $composableBuilder(
    column: $table.altitudeMeters,
    builder: (column) => column,
  );

  GeneratedColumn<double> get accuracyMeters => $composableBuilder(
    column: $table.accuracyMeters,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rawPayload => $composableBuilder(
    column: $table.rawPayload,
    builder: (column) => column,
  );
}

class $$WifiBleSamplesTableTableManager
    extends
        RootTableManager<
          _$WardrivingDatabase,
          $WifiBleSamplesTable,
          WifiBleSample,
          $$WifiBleSamplesTableFilterComposer,
          $$WifiBleSamplesTableOrderingComposer,
          $$WifiBleSamplesTableAnnotationComposer,
          $$WifiBleSamplesTableCreateCompanionBuilder,
          $$WifiBleSamplesTableUpdateCompanionBuilder,
          (
            WifiBleSample,
            BaseReferences<
              _$WardrivingDatabase,
              $WifiBleSamplesTable,
              WifiBleSample
            >,
          ),
          WifiBleSample,
          PrefetchHooks Function()
        > {
  $$WifiBleSamplesTableTableManager(
    _$WardrivingDatabase db,
    $WifiBleSamplesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WifiBleSamplesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WifiBleSamplesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WifiBleSamplesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<int> timestamp = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> mac = const Value.absent(),
                Value<String> ssid = const Value.absent(),
                Value<String> authMode = const Value.absent(),
                Value<String> channel = const Value.absent(),
                Value<int?> rssi = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<double?> altitudeMeters = const Value.absent(),
                Value<double?> accuracyMeters = const Value.absent(),
                Value<String?> rawPayload = const Value.absent(),
              }) => WifiBleSamplesCompanion(
                id: id,
                sessionId: sessionId,
                timestamp: timestamp,
                type: type,
                mac: mac,
                ssid: ssid,
                authMode: authMode,
                channel: channel,
                rssi: rssi,
                latitude: latitude,
                longitude: longitude,
                altitudeMeters: altitudeMeters,
                accuracyMeters: accuracyMeters,
                rawPayload: rawPayload,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sessionId,
                required int timestamp,
                required String type,
                required String mac,
                required String ssid,
                required String authMode,
                required String channel,
                Value<int?> rssi = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<double?> altitudeMeters = const Value.absent(),
                Value<double?> accuracyMeters = const Value.absent(),
                Value<String?> rawPayload = const Value.absent(),
              }) => WifiBleSamplesCompanion.insert(
                id: id,
                sessionId: sessionId,
                timestamp: timestamp,
                type: type,
                mac: mac,
                ssid: ssid,
                authMode: authMode,
                channel: channel,
                rssi: rssi,
                latitude: latitude,
                longitude: longitude,
                altitudeMeters: altitudeMeters,
                accuracyMeters: accuracyMeters,
                rawPayload: rawPayload,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WifiBleSamplesTableProcessedTableManager =
    ProcessedTableManager<
      _$WardrivingDatabase,
      $WifiBleSamplesTable,
      WifiBleSample,
      $$WifiBleSamplesTableFilterComposer,
      $$WifiBleSamplesTableOrderingComposer,
      $$WifiBleSamplesTableAnnotationComposer,
      $$WifiBleSamplesTableCreateCompanionBuilder,
      $$WifiBleSamplesTableUpdateCompanionBuilder,
      (
        WifiBleSample,
        BaseReferences<
          _$WardrivingDatabase,
          $WifiBleSamplesTable,
          WifiBleSample
        >,
      ),
      WifiBleSample,
      PrefetchHooks Function()
    >;
typedef $$LteSamplesTableCreateCompanionBuilder =
    LteSamplesCompanion Function({
      Value<int> id,
      required String sessionId,
      required int timestamp,
      required String technology,
      required String state,
      Value<String?> mcc,
      Value<String?> mnc,
      Value<int?> lac,
      Value<int?> cellId,
      Value<int?> pci,
      Value<int?> earfcn,
      Value<String?> band,
      Value<int?> rssi,
      Value<int?> rsrp,
      Value<int?> rsrq,
      Value<int?> sinr,
      Value<String?> operatorName,
      Value<double?> longitude,
      Value<double?> latitude,
      Value<String?> rawPayload,
    });
typedef $$LteSamplesTableUpdateCompanionBuilder =
    LteSamplesCompanion Function({
      Value<int> id,
      Value<String> sessionId,
      Value<int> timestamp,
      Value<String> technology,
      Value<String> state,
      Value<String?> mcc,
      Value<String?> mnc,
      Value<int?> lac,
      Value<int?> cellId,
      Value<int?> pci,
      Value<int?> earfcn,
      Value<String?> band,
      Value<int?> rssi,
      Value<int?> rsrp,
      Value<int?> rsrq,
      Value<int?> sinr,
      Value<String?> operatorName,
      Value<double?> longitude,
      Value<double?> latitude,
      Value<String?> rawPayload,
    });

class $$LteSamplesTableFilterComposer
    extends Composer<_$WardrivingDatabase, $LteSamplesTable> {
  $$LteSamplesTableFilterComposer({
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

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get technology => $composableBuilder(
    column: $table.technology,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mcc => $composableBuilder(
    column: $table.mcc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mnc => $composableBuilder(
    column: $table.mnc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lac => $composableBuilder(
    column: $table.lac,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cellId => $composableBuilder(
    column: $table.cellId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pci => $composableBuilder(
    column: $table.pci,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get earfcn => $composableBuilder(
    column: $table.earfcn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get band => $composableBuilder(
    column: $table.band,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rssi => $composableBuilder(
    column: $table.rssi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rsrp => $composableBuilder(
    column: $table.rsrp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rsrq => $composableBuilder(
    column: $table.rsrq,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sinr => $composableBuilder(
    column: $table.sinr,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operatorName => $composableBuilder(
    column: $table.operatorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawPayload => $composableBuilder(
    column: $table.rawPayload,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LteSamplesTableOrderingComposer
    extends Composer<_$WardrivingDatabase, $LteSamplesTable> {
  $$LteSamplesTableOrderingComposer({
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

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get technology => $composableBuilder(
    column: $table.technology,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mcc => $composableBuilder(
    column: $table.mcc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mnc => $composableBuilder(
    column: $table.mnc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lac => $composableBuilder(
    column: $table.lac,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cellId => $composableBuilder(
    column: $table.cellId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pci => $composableBuilder(
    column: $table.pci,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get earfcn => $composableBuilder(
    column: $table.earfcn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get band => $composableBuilder(
    column: $table.band,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rssi => $composableBuilder(
    column: $table.rssi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rsrp => $composableBuilder(
    column: $table.rsrp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rsrq => $composableBuilder(
    column: $table.rsrq,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sinr => $composableBuilder(
    column: $table.sinr,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operatorName => $composableBuilder(
    column: $table.operatorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawPayload => $composableBuilder(
    column: $table.rawPayload,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LteSamplesTableAnnotationComposer
    extends Composer<_$WardrivingDatabase, $LteSamplesTable> {
  $$LteSamplesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<int> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get technology => $composableBuilder(
    column: $table.technology,
    builder: (column) => column,
  );

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<String> get mcc =>
      $composableBuilder(column: $table.mcc, builder: (column) => column);

  GeneratedColumn<String> get mnc =>
      $composableBuilder(column: $table.mnc, builder: (column) => column);

  GeneratedColumn<int> get lac =>
      $composableBuilder(column: $table.lac, builder: (column) => column);

  GeneratedColumn<int> get cellId =>
      $composableBuilder(column: $table.cellId, builder: (column) => column);

  GeneratedColumn<int> get pci =>
      $composableBuilder(column: $table.pci, builder: (column) => column);

  GeneratedColumn<int> get earfcn =>
      $composableBuilder(column: $table.earfcn, builder: (column) => column);

  GeneratedColumn<String> get band =>
      $composableBuilder(column: $table.band, builder: (column) => column);

  GeneratedColumn<int> get rssi =>
      $composableBuilder(column: $table.rssi, builder: (column) => column);

  GeneratedColumn<int> get rsrp =>
      $composableBuilder(column: $table.rsrp, builder: (column) => column);

  GeneratedColumn<int> get rsrq =>
      $composableBuilder(column: $table.rsrq, builder: (column) => column);

  GeneratedColumn<int> get sinr =>
      $composableBuilder(column: $table.sinr, builder: (column) => column);

  GeneratedColumn<String> get operatorName => $composableBuilder(
    column: $table.operatorName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<String> get rawPayload => $composableBuilder(
    column: $table.rawPayload,
    builder: (column) => column,
  );
}

class $$LteSamplesTableTableManager
    extends
        RootTableManager<
          _$WardrivingDatabase,
          $LteSamplesTable,
          LteSample,
          $$LteSamplesTableFilterComposer,
          $$LteSamplesTableOrderingComposer,
          $$LteSamplesTableAnnotationComposer,
          $$LteSamplesTableCreateCompanionBuilder,
          $$LteSamplesTableUpdateCompanionBuilder,
          (
            LteSample,
            BaseReferences<_$WardrivingDatabase, $LteSamplesTable, LteSample>,
          ),
          LteSample,
          PrefetchHooks Function()
        > {
  $$LteSamplesTableTableManager(_$WardrivingDatabase db, $LteSamplesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LteSamplesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LteSamplesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LteSamplesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<int> timestamp = const Value.absent(),
                Value<String> technology = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<String?> mcc = const Value.absent(),
                Value<String?> mnc = const Value.absent(),
                Value<int?> lac = const Value.absent(),
                Value<int?> cellId = const Value.absent(),
                Value<int?> pci = const Value.absent(),
                Value<int?> earfcn = const Value.absent(),
                Value<String?> band = const Value.absent(),
                Value<int?> rssi = const Value.absent(),
                Value<int?> rsrp = const Value.absent(),
                Value<int?> rsrq = const Value.absent(),
                Value<int?> sinr = const Value.absent(),
                Value<String?> operatorName = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<String?> rawPayload = const Value.absent(),
              }) => LteSamplesCompanion(
                id: id,
                sessionId: sessionId,
                timestamp: timestamp,
                technology: technology,
                state: state,
                mcc: mcc,
                mnc: mnc,
                lac: lac,
                cellId: cellId,
                pci: pci,
                earfcn: earfcn,
                band: band,
                rssi: rssi,
                rsrp: rsrp,
                rsrq: rsrq,
                sinr: sinr,
                operatorName: operatorName,
                longitude: longitude,
                latitude: latitude,
                rawPayload: rawPayload,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sessionId,
                required int timestamp,
                required String technology,
                required String state,
                Value<String?> mcc = const Value.absent(),
                Value<String?> mnc = const Value.absent(),
                Value<int?> lac = const Value.absent(),
                Value<int?> cellId = const Value.absent(),
                Value<int?> pci = const Value.absent(),
                Value<int?> earfcn = const Value.absent(),
                Value<String?> band = const Value.absent(),
                Value<int?> rssi = const Value.absent(),
                Value<int?> rsrp = const Value.absent(),
                Value<int?> rsrq = const Value.absent(),
                Value<int?> sinr = const Value.absent(),
                Value<String?> operatorName = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<String?> rawPayload = const Value.absent(),
              }) => LteSamplesCompanion.insert(
                id: id,
                sessionId: sessionId,
                timestamp: timestamp,
                technology: technology,
                state: state,
                mcc: mcc,
                mnc: mnc,
                lac: lac,
                cellId: cellId,
                pci: pci,
                earfcn: earfcn,
                band: band,
                rssi: rssi,
                rsrp: rsrp,
                rsrq: rsrq,
                sinr: sinr,
                operatorName: operatorName,
                longitude: longitude,
                latitude: latitude,
                rawPayload: rawPayload,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LteSamplesTableProcessedTableManager =
    ProcessedTableManager<
      _$WardrivingDatabase,
      $LteSamplesTable,
      LteSample,
      $$LteSamplesTableFilterComposer,
      $$LteSamplesTableOrderingComposer,
      $$LteSamplesTableAnnotationComposer,
      $$LteSamplesTableCreateCompanionBuilder,
      $$LteSamplesTableUpdateCompanionBuilder,
      (
        LteSample,
        BaseReferences<_$WardrivingDatabase, $LteSamplesTable, LteSample>,
      ),
      LteSample,
      PrefetchHooks Function()
    >;
typedef $$PendingUploadsTableCreateCompanionBuilder =
    PendingUploadsCompanion Function({
      Value<int> id,
      required String sessionId,
      required String uploadType,
      required String filePath,
      required int createdAt,
      required int sampleCount,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<String?> remoteId,
      Value<String?> remoteSource,
      Value<String?> remoteHashSha256,
      Value<bool?> isProcessed,
      Value<int?> responseReceivedAt,
      Value<int?> uploadedAt,
    });
typedef $$PendingUploadsTableUpdateCompanionBuilder =
    PendingUploadsCompanion Function({
      Value<int> id,
      Value<String> sessionId,
      Value<String> uploadType,
      Value<String> filePath,
      Value<int> createdAt,
      Value<int> sampleCount,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<String?> remoteId,
      Value<String?> remoteSource,
      Value<String?> remoteHashSha256,
      Value<bool?> isProcessed,
      Value<int?> responseReceivedAt,
      Value<int?> uploadedAt,
    });

class $$PendingUploadsTableFilterComposer
    extends Composer<_$WardrivingDatabase, $PendingUploadsTable> {
  $$PendingUploadsTableFilterComposer({
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

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uploadType => $composableBuilder(
    column: $table.uploadType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sampleCount => $composableBuilder(
    column: $table.sampleCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteSource => $composableBuilder(
    column: $table.remoteSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteHashSha256 => $composableBuilder(
    column: $table.remoteHashSha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isProcessed => $composableBuilder(
    column: $table.isProcessed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get responseReceivedAt => $composableBuilder(
    column: $table.responseReceivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get uploadedAt => $composableBuilder(
    column: $table.uploadedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PendingUploadsTableOrderingComposer
    extends Composer<_$WardrivingDatabase, $PendingUploadsTable> {
  $$PendingUploadsTableOrderingComposer({
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

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uploadType => $composableBuilder(
    column: $table.uploadType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sampleCount => $composableBuilder(
    column: $table.sampleCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteSource => $composableBuilder(
    column: $table.remoteSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteHashSha256 => $composableBuilder(
    column: $table.remoteHashSha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isProcessed => $composableBuilder(
    column: $table.isProcessed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get responseReceivedAt => $composableBuilder(
    column: $table.responseReceivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get uploadedAt => $composableBuilder(
    column: $table.uploadedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PendingUploadsTableAnnotationComposer
    extends Composer<_$WardrivingDatabase, $PendingUploadsTable> {
  $$PendingUploadsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get uploadType => $composableBuilder(
    column: $table.uploadType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get sampleCount => $composableBuilder(
    column: $table.sampleCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get remoteSource => $composableBuilder(
    column: $table.remoteSource,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remoteHashSha256 => $composableBuilder(
    column: $table.remoteHashSha256,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isProcessed => $composableBuilder(
    column: $table.isProcessed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get responseReceivedAt => $composableBuilder(
    column: $table.responseReceivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get uploadedAt => $composableBuilder(
    column: $table.uploadedAt,
    builder: (column) => column,
  );
}

class $$PendingUploadsTableTableManager
    extends
        RootTableManager<
          _$WardrivingDatabase,
          $PendingUploadsTable,
          PendingUpload,
          $$PendingUploadsTableFilterComposer,
          $$PendingUploadsTableOrderingComposer,
          $$PendingUploadsTableAnnotationComposer,
          $$PendingUploadsTableCreateCompanionBuilder,
          $$PendingUploadsTableUpdateCompanionBuilder,
          (
            PendingUpload,
            BaseReferences<
              _$WardrivingDatabase,
              $PendingUploadsTable,
              PendingUpload
            >,
          ),
          PendingUpload,
          PrefetchHooks Function()
        > {
  $$PendingUploadsTableTableManager(
    _$WardrivingDatabase db,
    $PendingUploadsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingUploadsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PendingUploadsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PendingUploadsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> uploadType = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<int> createdAt = const Value.absent(),
                Value<int> sampleCount = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> remoteSource = const Value.absent(),
                Value<String?> remoteHashSha256 = const Value.absent(),
                Value<bool?> isProcessed = const Value.absent(),
                Value<int?> responseReceivedAt = const Value.absent(),
                Value<int?> uploadedAt = const Value.absent(),
              }) => PendingUploadsCompanion(
                id: id,
                sessionId: sessionId,
                uploadType: uploadType,
                filePath: filePath,
                createdAt: createdAt,
                sampleCount: sampleCount,
                retryCount: retryCount,
                lastError: lastError,
                remoteId: remoteId,
                remoteSource: remoteSource,
                remoteHashSha256: remoteHashSha256,
                isProcessed: isProcessed,
                responseReceivedAt: responseReceivedAt,
                uploadedAt: uploadedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sessionId,
                required String uploadType,
                required String filePath,
                required int createdAt,
                required int sampleCount,
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
                Value<String?> remoteSource = const Value.absent(),
                Value<String?> remoteHashSha256 = const Value.absent(),
                Value<bool?> isProcessed = const Value.absent(),
                Value<int?> responseReceivedAt = const Value.absent(),
                Value<int?> uploadedAt = const Value.absent(),
              }) => PendingUploadsCompanion.insert(
                id: id,
                sessionId: sessionId,
                uploadType: uploadType,
                filePath: filePath,
                createdAt: createdAt,
                sampleCount: sampleCount,
                retryCount: retryCount,
                lastError: lastError,
                remoteId: remoteId,
                remoteSource: remoteSource,
                remoteHashSha256: remoteHashSha256,
                isProcessed: isProcessed,
                responseReceivedAt: responseReceivedAt,
                uploadedAt: uploadedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PendingUploadsTableProcessedTableManager =
    ProcessedTableManager<
      _$WardrivingDatabase,
      $PendingUploadsTable,
      PendingUpload,
      $$PendingUploadsTableFilterComposer,
      $$PendingUploadsTableOrderingComposer,
      $$PendingUploadsTableAnnotationComposer,
      $$PendingUploadsTableCreateCompanionBuilder,
      $$PendingUploadsTableUpdateCompanionBuilder,
      (
        PendingUpload,
        BaseReferences<
          _$WardrivingDatabase,
          $PendingUploadsTable,
          PendingUpload
        >,
      ),
      PendingUpload,
      PrefetchHooks Function()
    >;

class $WardrivingDatabaseManager {
  final _$WardrivingDatabase _db;
  $WardrivingDatabaseManager(this._db);
  $$WardrivingSessionsTableTableManager get wardrivingSessions =>
      $$WardrivingSessionsTableTableManager(_db, _db.wardrivingSessions);
  $$LocationSamplesTableTableManager get locationSamples =>
      $$LocationSamplesTableTableManager(_db, _db.locationSamples);
  $$WifiBleSamplesTableTableManager get wifiBleSamples =>
      $$WifiBleSamplesTableTableManager(_db, _db.wifiBleSamples);
  $$LteSamplesTableTableManager get lteSamples =>
      $$LteSamplesTableTableManager(_db, _db.lteSamples);
  $$PendingUploadsTableTableManager get pendingUploads =>
      $$PendingUploadsTableTableManager(_db, _db.pendingUploads);
}
