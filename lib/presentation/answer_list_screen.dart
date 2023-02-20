import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interview_answer_controller/data/tools/file_picker.dart';
import 'package:interview_answer_controller/domain/subject.dart';
import 'package:interview_answer_controller/presentation/alert_ask_sure_delete.dart';
import 'package:interview_answer_controller/presentation/video_play_screen.dart';
import 'package:interview_answer_controller/presentation/view_models/answer_screen_view_model.dart';
import 'package:interview_answer_controller/presentation/view_models/launch_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../data/tools/navigation_tool.dart';
import '../domain/answer.dart';
import 'add_new_answer_screen.dart';
import 'add_new_fills_screen.dart';
import 'my_widgets/MyRichText.dart';

late AnswerScreenViewModel _viewModel;

class AnswerListScreen extends StatelessWidget {
  const AnswerListScreen({Key? key, required this.answerSubject})
      : super(key: key);
  final Subject answerSubject;
  @override
  Widget build(BuildContext context) {
    _viewModel = AnswerScreenViewModel.initInstance(answerSubject);
    return ChangeNotifierProvider(
      create: ((context) => _viewModel),
      child: Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Align(
            heightFactor: 120,
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              child: const Icon(Icons.arrow_back),
              backgroundColor: Colors.purple.withOpacity(0.7),
              onPressed: () {
                LaunchScreenViewModel.instance.updateSubjectList();
                ToolNavigator.pop();
              },
            ),
          ),
        ),
        body: AnswerListView(answerSubject: answerSubject),
      ),
    );
  }
}

class AnswerListView extends StatelessWidget {
  const AnswerListView({
    Key? key,
    required this.answerSubject,
  }) : super(key: key);
  final Subject answerSubject;

  @override
  Widget build(BuildContext context) {
    var answerList =
        context.select((AnswerScreenViewModel vm) => vm.answerList);
    return ReorderableListView.builder(
      footer: getAddItemButton(() => jumpToCreateAnswerScreen(answerSubject)),
      itemCount: answerList.length,
      onReorder: (oldItem, newItem) {
        _viewModel.swapAnswer(answerList[oldItem], newItem);
      },
      itemBuilder: (BuildContext context, int index) {
        return AnswerBlock(answer: answerList[index], key: ValueKey(index));
      },
    );
  }
}

Widget getAddItemButton(VoidCallback jumpFunction) {
  return Card(
    color: Colors.purple.withOpacity(0.5),
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

class AnswerBlock extends StatelessWidget {
  const AnswerBlock({Key? key, required this.answer}) : super(key: key);
  final Answer answer;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        _viewModel.deleteAnswer(answer);
      },
      background: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: ColoredBox(
          color: Colors.pinkAccent.withOpacity(0.75),
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "DELETE THIS QUEST",
              style: TextStyle(
                fontSize: 26,
              ),
            ),
          ),
        ),
      ),
      key: ValueKey(answer),
      child: Card(
        color: Colors.greenAccent,
        child: SizedBox(
          height: 140,
          child: Row(
            children: [
              Flexible(
                flex: 0,
                fit: FlexFit.loose,
                child: Text((answer.position + 1).toString()),
              ),
              createVerticalDivider(),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: InkWell(
                  onTap: () {
                    jumpToEditAnswerScreen(answer);
                  },
                  child: Column(
                    //Title Quest
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text(
                          answer.title ?? "null - title",
                          style: const TextStyle(fontSize: 22, shadows: [
                            Shadow(
                                blurRadius: 6,
                                color: Color.fromARGB(90, 0, 0, 0))
                          ]),
                        ),
                      ),
                      Flexible(
                          flex: 3,
                          fit: FlexFit.tight,
                          child: Text(
                            answer.questText ?? "null - questText",
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
              createVerticalDivider(),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: InkWell(
                  onTap: () {
                    jumpToEditFilesAnswerScreen(answer);
                  },
                  child: Column(
                    //Answer Text, Files
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: SingleChildScrollView(
                          child: MyRichText(
                              text: answer.answerText ?? "null - answerText"),
                        ),
                      ),
                      (answer.fileList != null)
                          ? Flexible(
                              flex: 1,
                              fit: FlexFit.loose,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: answer.fileList?.length ?? 0,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return AddNewFilesScreen.getFileImageBox(
                                      answer, answer.fileList![index]);
                                },
                              ),
                            )
                          : const Text("no any files")
                    ],
                  ),
                ),
              ),
              createVerticalDivider(),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: InkWell(
                  onLongPress: () {
                    print('LONG PRESS');
                    if (answer.videoPath != null) {
                      ToolNavigator.push(AlertAskSureDelete(
                        alertText: "Video will delete from your PC",
                        deleteAccept: () {
                          ToolFilePicker.deleteFile(answer.videoPath!);
                          answer.videoPath = null;
                          answer.dateTime = null;
                          AnswerScreenViewModel.instance
                              .deleteVideoPath(answer);
                        },
                      ));
                    }
                  },
                  onTap: () async {
                    if (answer.videoPath == null) {
                      AnswerScreenViewModel.instance.addNewVideoPath(answer);
                    } else {
                      ToolNavigator.push(
                        VideoPlayScreen(videoPath: answer.videoPath!),
                      );
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Text((answer.dateTime ?? "null - dateTime")
                              .toString())),
                      Flexible(
                        flex: 4,
                        fit: FlexFit.tight,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: answer.videoPath != null
                              ? Image(
                                  image: AssetImage("assets/video_ready.png"))
                              : Icon(
                                  size: 50,
                                  Icons.download,
                                  color: Colors.purple.withOpacity(0.60),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const VerticalDivider(
                color: Colors.purple,
                indent: 10,
                endIndent: 10,
                width: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }

  VerticalDivider createVerticalDivider() {
    return const VerticalDivider(
      color: Colors.purple,
      indent: 10,
      endIndent: 10,
    );
  }
}

jumpToCreateAnswerScreen(Subject subject) {
  ToolNavigator.push(AddNewQuestScreen(
    addAnswerCallBack: (String answerTitle, String? title) {
      _viewModel.addAnswer(answerTitle, subject.title, title);
    },
  ));
}

jumpToEditAnswerScreen(Answer answer) {
  print('$answer');
  ToolNavigator.push(AddNewQuestScreen(
    answer: answer,
    addAnswerCallBack: (String answerQuestText, String? title) {
      answer.title = title;
      answer.questText = answerQuestText;
      _viewModel.editAnswer(answer);
    },
  ));
}

jumpToEditFilesAnswerScreen(Answer answer) {
  print('$answer');
  ToolNavigator.push(AddNewFilesScreen(
    answer: answer,
    updateAnswerCallBack: (String? answerText, String? filePath) {
      answer.answerText = answerText;
      if (filePath != null) {
        answer.fileList?.add(filePath!);
      }
      _viewModel.editAnswer(answer);
    },
  ));
}
