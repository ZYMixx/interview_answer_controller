import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interview_answer_controller/presentation/view_models/launch_screen_view_model.dart';

import '../data/tools/navigation_tool.dart';
import 'my_widgets/MyWidgetButton.dart';

class AddSubjectScreen extends StatelessWidget {
  const AddSubjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    print('BUILD');
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
                  Flexible(
                    child: FractionallySizedBox(
                      alignment: Alignment.center,
                      heightFactor: 0.2,
                      child: CupertinoTextField(
                        focusNode: FocusNode(
                          onKey: (node, event) {
                            if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
                              ToolNavigator.pop();
                            }
                            return KeyEventResult.ignored;
                          },
                        ),
                        autofocus: true,
                        onSubmitted: (_) => saveNewSubject(myController.text),
                        controller: myController,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(fontSize: 36),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: MyWidgetButton(
                          onPressed: () => ToolNavigator.pop(),
                          name: "CANCEL",
                          color: Colors.red,
                        ),
                      ),
                      Flexible(
                        child: MyWidgetButton(
                          onPressed: () => saveNewSubject(myController.text),
                          name: "ADD",
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

saveNewSubject(String title) {
  LaunchScreenViewModel.instance.addSubject(title);
  ToolNavigator.pop();
}
