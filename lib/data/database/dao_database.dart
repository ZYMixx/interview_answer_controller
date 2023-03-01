import 'package:drift/drift.dart';

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
    db
        .update(db.answerDbModel)
        .replace(ToolMapper.entityAnswerToDbModel(answer));
  }

  Future<List<Answer>> getAllAnswerOrderByPosition() async =>
      ToolMapper.listAnswerDbModelToEntity(await (db.select(db.answerDbModel)
            ..orderBy([(t) => OrderingTerm(expression: t.position)]))
          .get());

  deleteAnswerVideoPathFromDb(Answer answer) {
    db
        .update(db.answerDbModel)
        .replace(ToolMapper.entityAnswerToDbModel(answer));
  }

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

  simpleUpdateSubject(Subject subject) {
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
    if (dbSubject.title != oldSubject.title) {
      for (var answer in (await getAllAnswerWhereSubject(oldSubject.title))) {
        answer.subjectTitle = subject.title;
        editAnswer(answer);
      }
    }
    db.into(db.subjectDbModel).insertOnConflictUpdate(dbSubject);
  }
}
