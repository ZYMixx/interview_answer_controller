import 'package:flutter/cupertino.dart';
import 'package:interview_answer_controller/data/database/dao_database.dart';
import 'package:interview_answer_controller/data/tools/file_picker.dart';

import '../../domain/answer.dart';
import '../../domain/subject.dart';

class AnswerScreenViewModel extends ChangeNotifier {
  static AnswerScreenViewModel get instance {
    if (_instanceSubject == null) {
      throw ("You have to init ViewModel first");
    }
    return _instance ??= AnswerScreenViewModel(_instanceSubject!);
  }

  static AnswerScreenViewModel? _instance;

  static Subject? _instanceSubject;

  static AnswerScreenViewModel initInstance(Subject subject) {
    return _instance ??= AnswerScreenViewModel(subject);
  }

  @override
  void dispose() {
    _instance = null;
    _instanceSubject = null;
    super.dispose();
  }

  DaoAppDatabase dao = DaoAppDatabase();
  List<Answer> answerList = [];
  String _subjectTitle = "";

  AnswerScreenViewModel(Subject subject) {
    print('CREATE VM');
    _instanceSubject = subject;
    _subjectTitle = subject.title;
    updateAnswerList();
  }

  updateAnswerList() async {
    //answerList = await dao.getAllAnswerOrderByPosition();
    answerList = await dao.getAllAnswerWhereSubject(_subjectTitle);
    notifyListeners();
  }

  addReadyAnswer(Answer answer) async {
    await dao.insertAnswer(answer);
    updateAnswerList();
  }

  addAnswer(String answerQuest, String subjectTitle, String? title) async {
    Answer answer;
    if (answerList.isEmpty) {
      answer =
          Answer(title: answerQuest, position: 0, subjectTitle: subjectTitle);
      answer.position = 0;
    } else {
      print(
          'answerList.last ${answerList.last.title} ${answerList.last.position} ${subjectTitle}');
      answer = Answer(
          questText: answerQuest,
          title: title,
          position: answerList.last.position + 1,
          subjectTitle: subjectTitle);
    }
    print('LaunchScreenViewModel.addAnswer ${answer.title} ${answer.position}');
    await dao.insertAnswer(answer);
    updateAnswerList();
  }

  swapAnswer(Answer moveAnswer, int newPos) async {
    answerList.removeWhere((element) => element == moveAnswer);
    if (newPos < moveAnswer.position) {
      answerList.insert(newPos, moveAnswer);
    } else {
      answerList.insert(newPos - 1, moveAnswer);
    }
    answerList.asMap().forEach((index, subj) {
      subj.position = index;
      dao.updateAnswer(subj);
    });
    updateAnswerList();
  }

  editAnswer(Answer oldAnswer) {
    dao.updateAnswer(oldAnswer);
    updateAnswerList();
  }

  deleteVideoPath(Answer answer) {
    dao.deleteAnswerVideoPathFromDb(answer);
    updateAnswerList();
  }

  _deleteAllAnswerFiles(Answer answer) {
    try {
      if (answer.videoPath != null) {
        ToolFilePicker.deleteFile(answer.videoPath!);
      }
      if (answer.fileList != null) {
        for (var file in answer.fileList!) {
          ToolFilePicker.deleteFile(file);
        }
      }
    } catch (e) {}
  }

  deleteAnswer(Answer answer) async {
    _deleteAllAnswerFiles(answer);
    await dao.deleteAnswer(answer);
    updateAnswerList();
  }

  clearDb() async {
    List list = await dao.getAllAnswer();
    for (var sub in list) {
      await dao.deleteAnswer(sub);
    }
  }

  addNewVideoPath(Answer answer) async {
    try {
      var filePath = await ToolFilePicker.choseVideoFile();
      var dateTime = DateTime.now();
      String fileName = "${answer.subjectTitle}_${answer.id}_${dateTime}";
      fileName = fileName.replaceAll(':', '-');
      String newFilePath =
          ToolFilePicker.saveVideoFileToUserFolder(filePath!, fileName);
      print('answer not null ${answer.fileList != null}');
      answer.videoPath = newFilePath;
      answer.dateTime = dateTime;
      editAnswer(answer);
    } catch (e) {
      print(e);
    }
  }
}
