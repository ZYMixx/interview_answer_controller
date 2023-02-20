import 'dart:convert';

import 'package:interview_answer_controller/data/database/app_database.dart';
import 'package:interview_answer_controller/domain/answer.dart';
import 'package:interview_answer_controller/domain/subject.dart';

class ToolMapper {
  static SubjectDbModelData entitySubjectToDbModel(Subject entity) {
    return SubjectDbModelData(
        id: entity.id, title: entity.title, position: entity.position);
  }

  static Subject subjectDbModelToEntity(SubjectDbModelData dbModel) {
    return Subject(
        id: dbModel.id ?? 0, title: dbModel.title, position: dbModel.position);
  }

  static AnswerDbModelData entityAnswerToDbModel(Answer entity) {
    return AnswerDbModelData(
        id: entity.id,
        position: entity.position,
        dataTime: entity.dateTime,
        subjectTitle: entity.subjectTitle,
        title: entity.title,
        questText: entity.questText,
        answerText: entity.answerText,
        fileList: jsonEncode(entity.fileList),
        videoPath: entity.videoPath);
  }

  static Answer answerDbModelToEntity(AnswerDbModelData dbModel) {
    return Answer(
        id: dbModel.id,
        position: dbModel.position,
        dateTime: dbModel.dataTime,
        subjectTitle: dbModel.subjectTitle,
        title: dbModel.title,
        questText: dbModel.questText,
        answerText: dbModel.answerText,
        fileList: jsonDecode(dbModel.fileList),
        videoPath: dbModel.videoPath);
  }

  static List<Subject> listSubjectDbModelToEntity(
          List<SubjectDbModelData> dbList) =>
      dbList.map((e) => subjectDbModelToEntity(e)).toList();

  static List<Answer> listAnswerDbModelToEntity(
          List<AnswerDbModelData> dbList) =>
      dbList.map((e) => answerDbModelToEntity(e)).toList();
}
