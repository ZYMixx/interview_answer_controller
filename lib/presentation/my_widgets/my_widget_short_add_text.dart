import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/tools/navigation_tool.dart';
import '../../data/tools/theme_tool.dart';
import 'my_widget_button.dart';

class MyWidgetShortAddText extends StatelessWidget {
  final String? hint;
  final Function(String) sendButtonCallBack;
  final myController = TextEditingController();
  MyWidgetShortAddText({Key? key, required this.sendButtonCallBack, this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (hint != null) {
      myController.text = hint!;
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
                  Flexible(
                    child: FractionallySizedBox(
                      alignment: Alignment.center,
                      heightFactor: 0.2,
                      child: CupertinoTextField(
                        focusNode: FocusNode(
                          onKey: onKeyEvent,
                        ),
                        decoration: ToolTheme.textFieldDecoration,
                        onSubmitted: (_) => onAddTextPressed(),
                        autofocus: true,
                        controller: myController,
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        style: const TextStyle(fontSize: 36),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Flexible(
                        child: MyWidgetButton(
                          onPressed: ToolNavigator.pop,
                          name: "CANCEL",
                          color: Colors.red,
                        ),
                      ),
                      Flexible(
                        child: MyWidgetButton(
                          onPressed: onAddTextPressed,
                          name: (hint != null) ? "CHANGE" : "ADD",
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

  void onAddTextPressed() {
    if (hint == myController.text) {
      ToolNavigator.pop();
    } else {
      sendButtonCallBack(myController.text);
      ToolNavigator.pop();
    }
  }
}
