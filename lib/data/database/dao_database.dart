import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../../domain/answer.dart';
import '../../domain/subject.dart';
import '../tools/mapper.dart';
import 'app_database.dart';

class DaoAppDatabase {
  AppDatabase db = AppDatabase.instance;

  Future<List<Answer>> getAllAnswer() async =>
      ToolMapper.listAnswerDbModelToEntity(
          await db.select(db.answerDbModel).get());

  Future<List<Answer>> getAllAnswerWhereSubject(String subjectTitle) async =>
      ToolMapper.listAnswerDbModelToEntity(await (db.select(db.answerDbModel)
            ..where((tbl) => (tbl.subjectTitle.equals(subjectTitle)))
            ..orderBy([(t) => OrderingTerm(expression: t.position)]))
          .get());

  Future insertAnswer(Answer answer) => db
      .into(db.answerDbModel)
      .insert(ToolMapper.entityAnswerToDbModel(answer));

  Future deleteAnswer(Answer answer) => db
      .delete(db.answerDbModel)
      .delete(ToolMapper.entityAnswerToDbModel(answer));

  editAnswer(Answer answer) {
    db.update(db.answerDbModel)
      ..where((tbl) => tbl.id.equals(answer.id!))
      ..write(ToolMapper.entityAnswerToDbModel(answer));
  }

  Future<List<Answer>> getAllAnswerOrderByPosition() async =>
      ToolMapper.listAnswerDbModelToEntity(await (db.select(db.answerDbModel)
            ..orderBy([(t) => OrderingTerm(expression: t.position)]))
          .get());

  deleteAnswerVideoPathFromDb(Answer answer) {
    // print("VIDEO PATH ${answer.videoPath}");
    // var added = ToolMapper.entityAnswerToDbModel(answer)
    //     .copyWith(videoPath: Value(null), dataTime: Value(null));
    // print("VIDEO PATH ${added.videoPath}");

    db
        .update(db.answerDbModel)
        .replace(ToolMapper.entityAnswerToDbModel(answer));

    //db.into(db.answerDbModel).insertOnConflictUpdate(added);
  }

  updateAnswer(Answer answer) {
    db
        .update(db.answerDbModel)
        .replace(ToolMapper.entityAnswerToDbModel(answer));
  }

  //subject

  Future<List<Subject>> getAllSubject() async =>
      ToolMapper.listSubjectDbModelToEntity(
          await db.select(db.subjectDbModel).get());

  Future<List<Subject>> getAllSubjectOrderByPosition() async =>
      ToolMapper.listSubjectDbModelToEntity(await (db.select(db.subjectDbModel)
            ..orderBy([(t) => OrderingTerm(expression: t.position)]))
          .get());

  Future insertSubject(Subject subject) => db
      .into(db.subjectDbModel)
      .insert(ToolMapper.entitySubjectToDbModel(subject));

  Future deleteSubject(Subject subject) => db
      .delete(db.subjectDbModel)
      .delete(ToolMapper.entitySubjectToDbModel(subject));

  simpleUpdateAnswer(Subject subject) {
    db
        .into(db.subjectDbModel)
        .insertOnConflictUpdate(ToolMapper.entitySubjectToDbModel(subject));
  }

  updateSubjectTitle(Subject subject) async {
    SubjectDbModelData dbSubject = ToolMapper.entitySubjectToDbModel(subject);
    SubjectDbModelData oldSubject = (await (db.select(db.subjectDbModel)
              ..whereSamePrimaryKey(dbSubject))
            .get())
        .first;
    print('${dbSubject.title} ${oldSubject.title}');
    if (dbSubject.title != oldSubject.title) {
      for (var answer in (await getAllAnswerWhereSubject(oldSubject.title))) {
        answer.subjectTitle = subject.title;
        updateAnswer(answer);
      }
    }
    db.into(db.subjectDbModel).insertOnConflictUpdate(dbSubject);
  }
}
