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

  AnswerScreenViewModel(Subject subject) {
    _instanceSubject = subject;
    _subjectTitle = subject.title;
    updateAnswerList();
  }

  @override
  void dispose() {
    _instance = null;
    _instanceSubject = null;
    super.dispose();
  }

  List<Answer> answerList = [];
  final DaoAppDatabase _dao = DaoAppDatabase();
  String _subjectTitle = "";

  updateAnswerList() async {
    answerList = await _dao.getAllAnswerWhereSubject(_subjectTitle);
    notifyListeners();
  }

  addReadyAnswer(Answer answer) async {
    await _dao.insertAnswer(answer);
    updateAnswerList();
  }

  addAnswer({
    required String questText,
    required String subjectTitle,
    required String? title,
  }) async {
    Answer answer;
    if (answerList.isEmpty) {
      answer = Answer(
          title: title,
          questText: questText,
          position: 0,
          subjectTitle: subjectTitle);
      answer.position = 0;
    } else {
      answer = Answer(
          title: title,
          questText: questText,
          position: answerList.last.position + 1,
          subjectTitle: subjectTitle);
    }
    await _dao.insertAnswer(answer);
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
      _dao.editAnswer(subj);
    });
    updateAnswerList();
  }

  editAnswer(Answer oldAnswer) {
    _dao.editAnswer(oldAnswer);
    updateAnswerList();
  }

  deleteVideoPath(Answer answer) {
    _dao.deleteAnswerVideoPathFromDb(answer);
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
    await _dao.deleteAnswer(answer);
    updateAnswerList();
  }

  choseNewImage(Answer answer) async {
    try {
      List<String?>? filePathList = await ToolFilePicker.choseImageFile();
      if (filePathList != null) {
        var number = 0;
        for (var path in filePathList) {
          String fileName =
              "${answer.subjectTitle}_${answer.id}_${number.toString()}_${DateTime.now()}";
          number++;
          fileName = fileName.replaceAll(':', '-');
          String newFilePath =
              ToolFilePicker.saveImgFileToUserFolder(path!, fileName);
          answer.addToList(newFilePath);
        }
        editAnswer(answer);
      }
    } catch (e) {
      print(e);
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
      answer.videoPath = newFilePath;
      answer.dateTime = dateTime;
      editAnswer(answer);
    } catch (e) {
      print(e);
    }
  }
}
