import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/tools/navigation_tool.dart';
import 'MyWidgetButton.dart';

class MyWidgetShortAddText extends StatelessWidget {
  const MyWidgetShortAddText(
      {Key? key, required this.sendButtonCallBack, this.hint})
      : super(key: key);
  final String? hint;
  final Function(String) sendButtonCallBack;

  @override
  Widget build(BuildContext context) {
    final myController = TextEditingController();
    if (hint != null) {
      myController.text = hint!;
    }
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
                        onSubmitted: (_) {
                          sendButtonCallBack(myController.text);
                          ToolNavigator.pop();
                        },
                        autofocus: true,
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
                          onPressed: () {
                            sendButtonCallBack(myController.text);
                            ToolNavigator.pop();
                          },
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
