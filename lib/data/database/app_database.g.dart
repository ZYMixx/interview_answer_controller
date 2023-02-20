// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $SubjectDbModelTable extends SubjectDbModel
    with TableInfo<$SubjectDbModelTable, SubjectDbModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectDbModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, position, title];
  @override
  String get aliasedName => _alias ?? 'subject_db_model';
  @override
  String get actualTableName => 'subject_db_model';
  @override
  VerificationContext validateIntegrity(Insertable<SubjectDbModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SubjectDbModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubjectDbModelData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
    );
  }

  @override
  $SubjectDbModelTable createAlias(String alias) {
    return $SubjectDbModelTable(attachedDatabase, alias);
  }
}

class SubjectDbModelData extends DataClass
    implements Insertable<SubjectDbModelData> {
  final int? id;
  final int position;
  final String title;
  const SubjectDbModelData(
      {this.id, required this.position, required this.title});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['position'] = Variable<int>(position);
    map['title'] = Variable<String>(title);
    return map;
  }

  SubjectDbModelCompanion toCompanion(bool nullToAbsent) {
    return SubjectDbModelCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      position: Value(position),
      title: Value(title),
    );
  }

  factory SubjectDbModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubjectDbModelData(
      id: serializer.fromJson<int?>(json['id']),
      position: serializer.fromJson<int>(json['position']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'position': serializer.toJson<int>(position),
      'title': serializer.toJson<String>(title),
    };
  }

  SubjectDbModelData copyWith(
          {Value<int?> id = const Value.absent(),
          int? position,
          String? title}) =>
      SubjectDbModelData(
        id: id.present ? id.value : this.id,
        position: position ?? this.position,
        title: title ?? this.title,
      );
  @override
  String toString() {
    return (StringBuffer('SubjectDbModelData(')
          ..write('id: $id, ')
          ..write('position: $position, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, position, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubjectDbModelData &&
          other.id == this.id &&
          other.position == this.position &&
          other.title == this.title);
}

class SubjectDbModelCompanion extends UpdateCompanion<SubjectDbModelData> {
  final Value<int?> id;
  final Value<int> position;
  final Value<String> title;
  const SubjectDbModelCompanion({
    this.id = const Value.absent(),
    this.position = const Value.absent(),
    this.title = const Value.absent(),
  });
  SubjectDbModelCompanion.insert({
    this.id = const Value.absent(),
    required int position,
    required String title,
  })  : position = Value(position),
        title = Value(title);
  static Insertable<SubjectDbModelData> custom({
    Expression<int>? id,
    Expression<int>? position,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (position != null) 'position': position,
      if (title != null) 'title': title,
    });
  }

  SubjectDbModelCompanion copyWith(
      {Value<int?>? id, Value<int>? position, Value<String>? title}) {
    return SubjectDbModelCompanion(
      id: id ?? this.id,
      position: position ?? this.position,
      title: title ?? this.title,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectDbModelCompanion(')
          ..write('id: $id, ')
          ..write('position: $position, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }
}

class $AnswerDbModelTable extends AnswerDbModel
    with TableInfo<$AnswerDbModelTable, AnswerDbModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnswerDbModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dataTimeMeta =
      const VerificationMeta('dataTime');
  @override
  late final GeneratedColumn<DateTime> dataTime = GeneratedColumn<DateTime>(
      'data_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _subjectTitleMeta =
      const VerificationMeta('subjectTitle');
  @override
  late final GeneratedColumn<String> subjectTitle = GeneratedColumn<String>(
      'subject_title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _questTextMeta =
      const VerificationMeta('questText');
  @override
  late final GeneratedColumn<String> questText = GeneratedColumn<String>(
      'quest_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _answerTextMeta =
      const VerificationMeta('answerText');
  @override
  late final GeneratedColumn<String> answerText = GeneratedColumn<String>(
      'answer_text', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _fileListMeta =
      const VerificationMeta('fileList');
  @override
  late final GeneratedColumn<String> fileList = GeneratedColumn<String>(
      'file_list', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _videoPathMeta =
      const VerificationMeta('videoPath');
  @override
  late final GeneratedColumn<String> videoPath = GeneratedColumn<String>(
      'video_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        position,
        dataTime,
        subjectTitle,
        title,
        questText,
        answerText,
        fileList,
        videoPath
      ];
  @override
  String get aliasedName => _alias ?? 'answer_db_model';
  @override
  String get actualTableName => 'answer_db_model';
  @override
  VerificationContext validateIntegrity(Insertable<AnswerDbModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('data_time')) {
      context.handle(_dataTimeMeta,
          dataTime.isAcceptableOrUnknown(data['data_time']!, _dataTimeMeta));
    }
    if (data.containsKey('subject_title')) {
      context.handle(
          _subjectTitleMeta,
          subjectTitle.isAcceptableOrUnknown(
              data['subject_title']!, _subjectTitleMeta));
    } else if (isInserting) {
      context.missing(_subjectTitleMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('quest_text')) {
      context.handle(_questTextMeta,
          questText.isAcceptableOrUnknown(data['quest_text']!, _questTextMeta));
    }
    if (data.containsKey('answer_text')) {
      context.handle(
          _answerTextMeta,
          answerText.isAcceptableOrUnknown(
              data['answer_text']!, _answerTextMeta));
    }
    if (data.containsKey('file_list')) {
      context.handle(_fileListMeta,
          fileList.isAcceptableOrUnknown(data['file_list']!, _fileListMeta));
    } else if (isInserting) {
      context.missing(_fileListMeta);
    }
    if (data.containsKey('video_path')) {
      context.handle(_videoPathMeta,
          videoPath.isAcceptableOrUnknown(data['video_path']!, _videoPathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AnswerDbModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnswerDbModelData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      dataTime: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}data_time']),
      subjectTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subject_title'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      questText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}quest_text']),
      answerText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}answer_text']),
      fileList: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_list'])!,
      videoPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}video_path']),
    );
  }

  @override
  $AnswerDbModelTable createAlias(String alias) {
    return $AnswerDbModelTable(attachedDatabase, alias);
  }
}

class AnswerDbModelData extends DataClass
    implements Insertable<AnswerDbModelData> {
  final int? id;
  final int position;
  final DateTime? dataTime;
  final String subjectTitle;
  final String? title;
  final String? questText;
  final String? answerText;
  final String fileList;
  final String? videoPath;
  const AnswerDbModelData(
      {this.id,
      required this.position,
      this.dataTime,
      required this.subjectTitle,
      this.title,
      this.questText,
      this.answerText,
      required this.fileList,
      this.videoPath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['position'] = Variable<int>(position);
    if (!nullToAbsent || dataTime != null) {
      map['data_time'] = Variable<DateTime>(dataTime);
    }
    map['subject_title'] = Variable<String>(subjectTitle);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || questText != null) {
      map['quest_text'] = Variable<String>(questText);
    }
    if (!nullToAbsent || answerText != null) {
      map['answer_text'] = Variable<String>(answerText);
    }
    map['file_list'] = Variable<String>(fileList);
    if (!nullToAbsent || videoPath != null) {
      map['video_path'] = Variable<String>(videoPath);
    }
    return map;
  }

  AnswerDbModelCompanion toCompanion(bool nullToAbsent) {
    return AnswerDbModelCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      position: Value(position),
      dataTime: dataTime == null && nullToAbsent
          ? const Value.absent()
          : Value(dataTime),
      subjectTitle: Value(subjectTitle),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      questText: questText == null && nullToAbsent
          ? const Value.absent()
          : Value(questText),
      answerText: answerText == null && nullToAbsent
          ? const Value.absent()
          : Value(answerText),
      fileList: Value(fileList),
      videoPath: videoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(videoPath),
    );
  }

  factory AnswerDbModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnswerDbModelData(
      id: serializer.fromJson<int?>(json['id']),
      position: serializer.fromJson<int>(json['position']),
      dataTime: serializer.fromJson<DateTime?>(json['dataTime']),
      subjectTitle: serializer.fromJson<String>(json['subjectTitle']),
      title: serializer.fromJson<String?>(json['title']),
      questText: serializer.fromJson<String?>(json['questText']),
      answerText: serializer.fromJson<String?>(json['answerText']),
      fileList: serializer.fromJson<String>(json['fileList']),
      videoPath: serializer.fromJson<String?>(json['videoPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'position': serializer.toJson<int>(position),
      'dataTime': serializer.toJson<DateTime?>(dataTime),
      'subjectTitle': serializer.toJson<String>(subjectTitle),
      'title': serializer.toJson<String?>(title),
      'questText': serializer.toJson<String?>(questText),
      'answerText': serializer.toJson<String?>(answerText),
      'fileList': serializer.toJson<String>(fileList),
      'videoPath': serializer.toJson<String?>(videoPath),
    };
  }

  AnswerDbModelData copyWith(
          {Value<int?> id = const Value.absent(),
          int? position,
          Value<DateTime?> dataTime = const Value.absent(),
          String? subjectTitle,
          Value<String?> title = const Value.absent(),
          Value<String?> questText = const Value.absent(),
          Value<String?> answerText = const Value.absent(),
          String? fileList,
          Value<String?> videoPath = const Value.absent()}) =>
      AnswerDbModelData(
        id: id.present ? id.value : this.id,
        position: position ?? this.position,
        dataTime: dataTime.present ? dataTime.value : this.dataTime,
        subjectTitle: subjectTitle ?? this.subjectTitle,
        title: title.present ? title.value : this.title,
        questText: questText.present ? questText.value : this.questText,
        answerText: answerText.present ? answerText.value : this.answerText,
        fileList: fileList ?? this.fileList,
        videoPath: videoPath.present ? videoPath.value : this.videoPath,
      );
  @override
  String toString() {
    return (StringBuffer('AnswerDbModelData(')
          ..write('id: $id, ')
          ..write('position: $position, ')
          ..write('dataTime: $dataTime, ')
          ..write('subjectTitle: $subjectTitle, ')
          ..write('title: $title, ')
          ..write('questText: $questText, ')
          ..write('answerText: $answerText, ')
          ..write('fileList: $fileList, ')
          ..write('videoPath: $videoPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, position, dataTime, subjectTitle, title,
      questText, answerText, fileList, videoPath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnswerDbModelData &&
          other.id == this.id &&
          other.position == this.position &&
          other.dataTime == this.dataTime &&
          other.subjectTitle == this.subjectTitle &&
          other.title == this.title &&
          other.questText == this.questText &&
          other.answerText == this.answerText &&
          other.fileList == this.fileList &&
          other.videoPath == this.videoPath);
}

class AnswerDbModelCompanion extends UpdateCompanion<AnswerDbModelData> {
  final Value<int?> id;
  final Value<int> position;
  final Value<DateTime?> dataTime;
  final Value<String> subjectTitle;
  final Value<String?> title;
  final Value<String?> questText;
  final Value<String?> answerText;
  final Value<String> fileList;
  final Value<String?> videoPath;
  const AnswerDbModelCompanion({
    this.id = const Value.absent(),
    this.position = const Value.absent(),
    this.dataTime = const Value.absent(),
    this.subjectTitle = const Value.absent(),
    this.title = const Value.absent(),
    this.questText = const Value.absent(),
    this.answerText = const Value.absent(),
    this.fileList = const Value.absent(),
    this.videoPath = const Value.absent(),
  });
  AnswerDbModelCompanion.insert({
    this.id = const Value.absent(),
    required int position,
    this.dataTime = const Value.absent(),
    required String subjectTitle,
    this.title = const Value.absent(),
    this.questText = const Value.absent(),
    this.answerText = const Value.absent(),
    required String fileList,
    this.videoPath = const Value.absent(),
  })  : position = Value(position),
        subjectTitle = Value(subjectTitle),
        fileList = Value(fileList);
  static Insertable<AnswerDbModelData> custom({
    Expression<int>? id,
    Expression<int>? position,
    Expression<DateTime>? dataTime,
    Expression<String>? subjectTitle,
    Expression<String>? title,
    Expression<String>? questText,
    Expression<String>? answerText,
    Expression<String>? fileList,
    Expression<String>? videoPath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (position != null) 'position': position,
      if (dataTime != null) 'data_time': dataTime,
      if (subjectTitle != null) 'subject_title': subjectTitle,
      if (title != null) 'title': title,
      if (questText != null) 'quest_text': questText,
      if (answerText != null) 'answer_text': answerText,
      if (fileList != null) 'file_list': fileList,
      if (videoPath != null) 'video_path': videoPath,
    });
  }

  AnswerDbModelCompanion copyWith(
      {Value<int?>? id,
      Value<int>? position,
      Value<DateTime?>? dataTime,
      Value<String>? subjectTitle,
      Value<String?>? title,
      Value<String?>? questText,
      Value<String?>? answerText,
      Value<String>? fileList,
      Value<String?>? videoPath}) {
    return AnswerDbModelCompanion(
      id: id ?? this.id,
      position: position ?? this.position,
      dataTime: dataTime ?? this.dataTime,
      subjectTitle: subjectTitle ?? this.subjectTitle,
      title: title ?? this.title,
      questText: questText ?? this.questText,
      answerText: answerText ?? this.answerText,
      fileList: fileList ?? this.fileList,
      videoPath: videoPath ?? this.videoPath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (dataTime.present) {
      map['data_time'] = Variable<DateTime>(dataTime.value);
    }
    if (subjectTitle.present) {
      map['subject_title'] = Variable<String>(subjectTitle.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (questText.present) {
      map['quest_text'] = Variable<String>(questText.value);
    }
    if (answerText.present) {
      map['answer_text'] = Variable<String>(answerText.value);
    }
    if (fileList.present) {
      map['file_list'] = Variable<String>(fileList.value);
    }
    if (videoPath.present) {
      map['video_path'] = Variable<String>(videoPath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnswerDbModelCompanion(')
          ..write('id: $id, ')
          ..write('position: $position, ')
          ..write('dataTime: $dataTime, ')
          ..write('subjectTitle: $subjectTitle, ')
          ..write('title: $title, ')
          ..write('questText: $questText, ')
          ..write('answerText: $answerText, ')
          ..write('fileList: $fileList, ')
          ..write('videoPath: $videoPath')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $SubjectDbModelTable subjectDbModel = $SubjectDbModelTable(this);
  late final $AnswerDbModelTable answerDbModel = $AnswerDbModelTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [subjectDbModel, answerDbModel];
}
