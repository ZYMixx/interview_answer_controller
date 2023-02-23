import 'package:flutter/cupertino.dart';
import 'package:interview_answer_controller/data/database/dao_database.dart';

import '../../domain/subject.dart';

class LaunchScreenViewModel extends ChangeNotifier {
  static LaunchScreenViewModel get instance =>
      _instance ??= LaunchScreenViewModel();
  static LaunchScreenViewModel? _instance;

  @override
  void dispose() {
    _instance = null;
    super.dispose();
  }

  DaoAppDatabase _dao = DaoAppDatabase();
  List<Subject> subjectList = [];

  LaunchScreenViewModel() {
    updateSubjectList();
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
      subject = Subject(title: title, position: subjectList.last.position + 1);
    }
    await _dao.insertSubject(subject);
    updateSubjectList();
  }

  swapSubject(Subject moveSubject, int newPos) {
    subjectList.removeWhere((element) => element == moveSubject);
    if (newPos < moveSubject.position) {
      subjectList.insert(newPos, moveSubject);
    } else {
      subjectList.insert(newPos - 1, moveSubject);
    }
    subjectList.asMap().forEach((index, subj) {
      subj.position = index;
      _dao.simpleUpdateAnswer(subj);
    });
    updateSubjectList();
  }

  editSubject(Subject oldSubject) async {
    await _dao.updateSubjectTitle(oldSubject);
    updateSubjectList();
  }

  deleteSubject(Subject subject) async {
    await _dao.deleteSubject(subject);
    updateSubjectList();
  }

  clearDb() async {
    List list = await _dao.getAllSubject();
    for (var sub in list) {
      await _dao.deleteSubject(sub);
    }
  }
}
