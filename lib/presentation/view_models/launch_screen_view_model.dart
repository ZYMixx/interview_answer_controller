import 'package:flutter/cupertino.dart';
import 'package:interview_answer_controller/data/database/dao_database.dart';

import '../../domain/subject.dart';
import 'answer_screen_view_model.dart';

class LaunchScreenViewModel extends ChangeNotifier {
  static LaunchScreenViewModel get instance =>
      _instance ??= LaunchScreenViewModel();
  static LaunchScreenViewModel? _instance;
  final DaoAppDatabase _dao = DaoAppDatabase();
  List<Subject> subjectList = [];

  LaunchScreenViewModel() {
    updateSubjectList();
  }

  @override
  void dispose() {
    _instance = null;
    super.dispose();
  }

  updateSubjectList() async {
    subjectList = await _dao.getAllSubjectOrderByPosition();
    _updateSubjectData();
    notifyListeners();
  }

  _updateSubjectData() async {
    for (var subject in subjectList) {
      var list = await _dao.getAllAnswerWhereSubject(subject.title);
      subject.questCount = list.length;
      list.removeWhere((element) => element.videoPath != null);
      subject.undoneQuest = list.length;
    }
  }

  addSubject(String title) async {
    Subject subject;
    if (subjectList.isEmpty) {
      subject = Subject(title: title, position: 0);
      subject.position = 0;
    } else {
      int copyInt = 0;
      String fitsTitle = title;
      while (checkDuplicatesTitle(title)) {
        title = "$fitsTitle (${++copyInt})";
      }
      subject = Subject(title: title, position: subjectList.last.position + 1);
    }
    await _dao.insertSubject(subject);
    updateSubjectList();
  }

  editSubject(Subject oldSubject) async {
    String title = oldSubject.title;
    String fitsTitle = title;
    int copyInt = 0;
    while (checkDuplicatesTitle(title)) {
      title = "$fitsTitle (${++copyInt})";
    }
    oldSubject.title = title;
    await _dao.updateSubjectTitle(oldSubject);
    updateSubjectList();
  }

  bool checkDuplicatesTitle(String title) {
    for (var subject in subjectList) {
      if (subject.title == title) {
        return true;
      }
    }
    return false;
  }

  swapSubject({
    required Subject moveSubject,
    required int newPos,
  }) {
    subjectList.removeWhere((element) => element == moveSubject);
    if (newPos < moveSubject.position) {
      subjectList.insert(newPos, moveSubject);
    } else {
      subjectList.insert(newPos - 1, moveSubject);
    }
    subjectList.asMap().forEach((index, subj) {
      subj.position = index;
      _dao.simpleUpdateSubject(subj);
    });
    updateSubjectList();
  }

  deleteSubject(Subject subject) async {
    await _dao.deleteSubject(subject);
    var list = await _dao.getAllAnswerWhereSubject(subject.title);
    for (var answer in list) {
      AnswerScreenViewModel.initInstance(subject).deleteAnswer(answer);
    }
    updateSubjectList();
  }

  clearDb() async {
    List list = await _dao.getAllSubject();
    for (var sub in list) {
      await _dao.deleteSubject(sub);
    }
  }
}
