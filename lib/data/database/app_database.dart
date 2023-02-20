import 'dart:io';
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [SubjectDbModel, AnswerDbModel])
class AppDatabase extends _$AppDatabase {
  static AppDatabase get instance =>
      _instance ??= AppDatabase._crate(_openConnection());
  static AppDatabase? _instance;
  AppDatabase._crate(QueryExecutor exec) : super(exec);

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      FileSystemEntity dbFolder;
      if (Platform.isWindows) {
        dbFolder = File((await getApplicationSupportDirectory()).path);
        //dbFolder = File(Platform.script.toFilePath());
      } else {
        dbFolder = await getApplicationDocumentsDirectory();
      }
      final file =
          File(p.join(dbFolder.path, 'interview_answer_controller.db'));
      return NativeDatabase(file);
    });
  }
}

class SubjectDbModel extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  IntColumn get position => integer()();
  TextColumn get title => text()();
}

class AnswerDbModel extends Table {
  IntColumn get id => integer().nullable().autoIncrement()();
  IntColumn get position => integer()();
  DateTimeColumn get dataTime => dateTime().nullable()();
  TextColumn get subjectTitle => text()();
  TextColumn get title => text().nullable()();
  TextColumn get questText => text().nullable()();
  TextColumn get answerText => text().nullable()();
  TextColumn get fileList => text()();
  TextColumn get videoPath => text().nullable()();
}

//flutter pub run build_runner build
