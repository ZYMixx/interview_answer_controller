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

  DaoAppDatabase dao = DaoAppDatabase();
  List<Subject> subjectList = [];

  LaunchScreenViewModel() {
    print('CREATE VM');
    updateSubjectList();
  }

  updateSubjectList() async {
    subjectList = await dao.getAllSubjectOrderByPosition();
    _updateSubjectData();
    notifyListeners();
    print('NOTIFY ALL');
  }

  _updateSubjectData() async {
    for (var subject in subjectList) {
      var list = await dao.getAllAnswerWhereSubject(subject.title);
      subject.questCount = list.length;
      list.removeWhere((element) => element.videoPath != null);
      subject.undoneQuest = list.length;
    }
  }

  addSubject(String title) async {
    Subject subjct;
    if (subjectList.isEmpty) {
      subjct = Subject(title: title, position: 0);
      subjct.position = 0;
    } else {
      print(
          'subjectList.last ${subjectList.last.title} ${subjectList.last.position}');
      subjct = Subject(title: title, position: subjectList.last.position + 1);
    }
    print(
        'LaunchScreenViewModel.addSubject ${subjct.title} ${subjct.position}');
    await dao.insertSubject(subjct);
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
      dao.simpleUpdateAnswer(subj);
      print('end work');
    });
    updateSubjectList();
  }

  editSubject(Subject oldSubject) async {
    await dao.updateSubjectTitle(oldSubject);
    updateSubjectList();
  }

  deleteSubject(Subject subject) async {
    await dao.deleteSubject(subject);
    updateSubjectList();
  }

  clearDb() async {
    List list = await dao.getAllSubject();
    for (var sub in list) {
      await dao.deleteSubject(sub);
    }
  }
}
