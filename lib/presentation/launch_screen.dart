import 'package:flutter/material.dart';
import 'package:interview_answer_controller/presentation/answer_list_screen.dart';
import 'package:interview_answer_controller/presentation/view_models/launch_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../data/tools/navigation_tool.dart';
import '../data/tools/theme_tool.dart';
import '../domain/subject.dart';
import 'my_widgets/alert_ask_sure_delete.dart';
import 'my_widgets/my_widget_short_add_text.dart';

late LaunchScreenViewModel _viewModel;

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _viewModel = LaunchScreenViewModel.instance;
    return ChangeNotifierProvider(
      create: ((context) => _viewModel),
      child: Scaffold(
        body: Container(
          decoration: ToolTheme.bgBoxDecoration,
          child: const SubjectListView(),
        ),
      ),
    );
  }
}

class SubjectListView extends StatelessWidget {
  const SubjectListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var subjectList =
        context.select((LaunchScreenViewModel vm) => vm.subjectList);
    return ReorderableListView.builder(
      footer: addSubjectButton(jumpToCreateSubjectScreen),
      itemCount: subjectList.length,
      onReorder: (oldItem, newItem) {
        _viewModel.swapSubject(
          moveSubject: subjectList[oldItem],
          newPos: newItem,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return SubjectBlock(
          subject: subjectList[index],
          key: ValueKey(index),
        );
      },
    );
  }
}

Widget addSubjectButton(VoidCallback jumpFunction) {
  return Card(
    color: ToolTheme.addSubjectColor,
    child: SizedBox(
      height: 70,
      child: InkWell(
        onTap: jumpFunction,
        child: Row(
          children: const [
            Flexible(
              flex: 3,
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 36,
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: SizedBox(),
            )
          ],
        ),
      ),
    ),
  );
}

class SubjectBlock extends StatelessWidget {
  final Subject subject;

  const SubjectBlock({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: ToolTheme.subjectColor,
      child: SizedBox(
        height: 150,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg_texture.png"),
                repeat: ImageRepeat.repeat,
                opacity: 0.3),
          ),
          child: InkWell(
            onTap: () => jumpToAnswerList(subject),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildTitleSubjectBlock(),
                buildVerticalDivider(),
                buildDataSubjectBlock(),
                buildVerticalDivider(),
                buildOptionSubjectBlock(),
                buildVerticalDivider(width: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Flexible buildOptionSubjectBlock() {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: InkWell(
                onTap: () => jumpToEditSubjectScreen(subject),
                child: const SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: Icon(
                        Icons.edit_note,
                        size: 50,
                      ),
                    )),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: InkWell(
                onTap: () {
                  ToolNavigator.push(
                    AlertAskSureDelete(
                      alertText: "Delete This Subject?\nand all answers",
                      deleteAccept: () {
                        _viewModel.deleteSubject(subject);
                      },
                    ),
                  );
                },
                child: const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Icon(
                      Icons.delete,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Flexible buildDataSubjectBlock() {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: "Quests:\n",
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: "${subject.questCount}\n",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      blurRadius: 1,
                      color: Colors.black45,
                    )
                  ],
                ),
              ),
              const TextSpan(
                text: "Undone:\n",
              ),
              TextSpan(
                text: "${subject.undoneQuest}",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                  color: subject.undoneQuest != 0 ? Colors.pink : Colors.green,
                  shadows: const [
                    Shadow(
                      blurRadius: 3,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ]),
      ),
    );
  }

  Flexible buildTitleSubjectBlock() {
    return Flexible(
      flex: 4,
      fit: FlexFit.tight,
      child: Center(
        child: Text(
          subject.title,
          style: const TextStyle(fontSize: 26, shadows: [
            Shadow(blurRadius: 6, color: Color.fromARGB(60, 0, 0, 0))
          ]),
        ),
      ),
    );
  }

  VerticalDivider buildVerticalDivider({double width = 0}) {
    return VerticalDivider(
      color: ToolTheme.answerColor,
      indent: 10,
      endIndent: 10,
      width: width,
    );
  }
}

jumpToAnswerList(Subject subject) {
  ToolNavigator.set(AnswerListScreen(answerSubject: subject));
}

jumpToCreateSubjectScreen() {
  ToolNavigator.push(
      MyWidgetShortAddText(sendButtonCallBack: _viewModel.addSubject));
}

jumpToEditSubjectScreen(Subject subject) {
  ToolNavigator.push(
    MyWidgetShortAddText(
      hint: subject.title,
      sendButtonCallBack: (string) {
        subject.title = string;
        _viewModel.editSubject(subject);
      },
    ),
  );
}
