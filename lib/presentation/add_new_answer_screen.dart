import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/tools/navigation_tool.dart';
import '../domain/answer.dart';
import 'my_widgets/MyWidgetButton.dart';

class AddNewQuestScreen extends StatelessWidget {
  const AddNewQuestScreen(
      {Key? key, required this.addAnswerCallBack, this.answer})
      : super(key: key);
  final Function(String answerQuestText, String? answerTitle) addAnswerCallBack;
  final Answer? answer;

  @override
  Widget build(BuildContext context) {
    final myControllerTitle = TextEditingController();
    final myControllerAnswerQuest = TextEditingController();
    if (answer != null) {
      myControllerTitle.text = answer?.title ?? "";
      myControllerAnswerQuest.text = answer?.questText ?? "";
    }
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.35),
      body: Stack(
        children: [
          InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: () {
              ToolNavigator.pop();
            },
          ),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 35,
                    child: CupertinoTextField(
                      focusNode: FocusNode(
                        onKey: (node, event) {
                          if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
                            ToolNavigator.pop();
                          }
                          return KeyEventResult.ignored;
                        },
                      ),
                      onSubmitted: (_) {
                        addAnswerCallBack.call(myControllerAnswerQuest.text,
                            myControllerTitle.text);
                        ToolNavigator.pop();
                      },
                      controller: myControllerTitle,
                      textAlign: TextAlign.center,
                      placeholder: "Title",
                    ),
                  ),
                  Flexible(
                    child: FractionallySizedBox(
                      alignment: Alignment.center,
                      heightFactor: 0.5,
                      child: CupertinoTextField(
                        focusNode: FocusNode(
                          onKey: (node, event) {
                            if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
                              ToolNavigator.pop();
                            }
                            return KeyEventResult.ignored;
                          },
                        ),
                        onSubmitted: (_) {
                          addAnswerCallBack.call(myControllerAnswerQuest.text,
                              myControllerTitle.text);
                          ToolNavigator.pop();
                        },
                        maxLines: null,
                        autofocus: true,
                        controller: myControllerAnswerQuest,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        placeholder: "Quest Text",
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: MyWidgetButton(
                          onPressed: () {
                            ToolNavigator.pop();
                          },
                          name: "CANSEL",
                          color: Colors.red,
                        ),
                      ),
                      Flexible(
                        child: MyWidgetButton(
                          onPressed: () {
                            addAnswerCallBack.call(myControllerAnswerQuest.text,
                                myControllerTitle.text);
                            ToolNavigator.pop();
                          },
                          name: (answer != null) ? "CHANGE" : "ADD ANSWER",
                          color: Colors.green,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
