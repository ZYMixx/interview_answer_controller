import 'package:flutter/material.dart';
import 'package:interview_answer_controller/presentation/answer_list_screen.dart';
import 'package:interview_answer_controller/presentation/my_widgets/MyWidgetButton.dart';
import 'package:interview_answer_controller/presentation/view_models/launch_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../data/tools/navigation_tool.dart';
import '../domain/subject.dart';
import 'alert_ask_sure_delete.dart';
import 'my_widgets/MyWidgetShortAddText.dart';

late LaunchScreenViewModel _viewModel;

class LaunchScreen extends StatelessWidget {
  LaunchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _viewModel = LaunchScreenViewModel.instance;
    return ChangeNotifierProvider(
      create: ((context) => _viewModel),
      child: const Scaffold(
        body: SubjectListView(),
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
      footer: getAddItemButton(jumpToCreateSubjectScreen),
      itemCount: subjectList.length,
      onReorder: (oldItem, newItem) {
        print('oldItem: $oldItem newItem: $newItem');
        _viewModel.swapSubject(subjectList[oldItem], newItem);
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

Widget getAddItemButton(VoidCallback jumpFunction) {
  return Card(
    color: Colors.green,
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
                  size: 35,
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
  const SubjectBlock({Key? key, required this.subject}) : super(key: key);
  final Subject subject;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: Colors.purple.withOpacity(0.7),
        child: SizedBox(
          height: 150,
          child: InkWell(
            onTap: () {
              jumpToAnswerList(subject);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Center(
                    child: Text(
                      "${subject.title}",
                      style: const TextStyle(fontSize: 22, shadows: [
                        Shadow(
                            blurRadius: 6, color: Color.fromARGB(60, 0, 0, 0))
                      ]),
                    ),
                  ),
                ),
                createVerticalDivider(),
                Flexible(
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
                              color: subject.undoneQuest != 0
                                  ? Colors.pink
                                  : Colors.green,
                              shadows: const [
                                Shadow(
                                  blurRadius: 3,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        ]),
                    // text: "Quests: ${subject.questCount} \n Undone: ${subject.undoneQuest}",
                    // style: TextStyle(fontSize: 22),
                  ),
                ),
                createVerticalDivider(),
                Flexible(
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
                                  alertText:
                                      "Delete This Subject?\nand all answers",
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
                    // child: Column(
                    //   children: [
                    //     InkWell(
                    //       onTap: () {
                    //         jumpToEditSubjectScreen(subject);
                    //       },
                    //     ),
                    //   ],
                    // ),
                  ),
                ),
                const VerticalDivider(
                  color: Colors.green,
                  indent: 10,
                  endIndent: 10,
                  width: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  VerticalDivider createVerticalDivider() {
    return const VerticalDivider(
      color: Colors.green,
      indent: 10,
      endIndent: 10,
    );
  }
}

jumpToAnswerList(Subject subject) {
  print("SUMN");
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
