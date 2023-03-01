import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/tools/navigation_tool.dart';
import '../data/tools/theme_tool.dart';
import '../domain/answer.dart';
import 'my_widgets/my_widget_button.dart';

class AddNewQuestScreen extends StatelessWidget {
  final Function({required String answerQuestText, String? answerTitle})
      addAnswerCallBack;
  final Answer? answer;
  final myControllerTitle = TextEditingController();
  final myControllerAnswerQuest = TextEditingController();

  AddNewQuestScreen({Key? key, required this.addAnswerCallBack, this.answer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (answer != null) {
      myControllerTitle.text = answer?.title ?? "";
      myControllerAnswerQuest.text = answer?.questText ?? "";
    }
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.35),
      body: Stack(
        children: [
          const InkWell(
            splashFactory: NoSplash.splashFactory,
            onTap: ToolNavigator.pop,
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
                        onKey: onKeyEvent,
                      ),
                      onSubmitted: (_) => onAddAnswerPressed(),
                      decoration: ToolTheme.textFieldDecoration,
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
                          onKey: onKeyEvent,
                        ),
                        onSubmitted: (_) => onAddAnswerPressed(),
                        decoration: ToolTheme.textFieldDecoration,
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
                      const Flexible(
                        child: MyWidgetButton(
                          onPressed: ToolNavigator.pop,
                          name: "CANSEL",
                          color: Colors.red,
                        ),
                      ),
                      Flexible(
                        child: MyWidgetButton(
                          onPressed: onAddAnswerPressed,
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

  KeyEventResult onKeyEvent(node, event) {
    if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
      ToolNavigator.pop();
    }
    return KeyEventResult.ignored;
  }

  void onAddAnswerPressed() {
    addAnswerCallBack.call(
      answerQuestText: myControllerAnswerQuest.text,
      answerTitle: myControllerTitle.text,
    );
    ToolNavigator.pop();
  }
}
