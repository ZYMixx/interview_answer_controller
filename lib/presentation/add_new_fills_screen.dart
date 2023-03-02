import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interview_answer_controller/presentation/show_image_widget.dart';
import 'package:interview_answer_controller/presentation/view_models/answer_screen_view_model.dart';
import '../data/tools/navigation_tool.dart';
import '../data/tools/theme_tool.dart';
import '../domain/answer.dart';
import 'my_widgets/my_widget_button.dart';

class AddNewFilesScreen extends StatefulWidget {
  final Function({String? answerText, String? filsPath}) updateAnswerCallBack;
  final Answer answer;

  const AddNewFilesScreen({
    Key? key,
    required this.updateAnswerCallBack,
    required this.answer,
  }) : super(key: key);

  @override
  State<AddNewFilesScreen> createState() => _AddNewFilesScreenState();
}

class _AddNewFilesScreenState extends State<AddNewFilesScreen> {
  final myControllerAnswer = TextEditingController();
  String? filePath;

  @override
  Widget build(BuildContext context) {
    myControllerAnswer.text = widget.answer.answerText ?? "";
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
                    child: Container(),
                  ),
                  buildAnswerTextEdit(),
                  buildAddFilesBox(),
                  buildOptionsButtons()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row buildOptionsButtons() {
    return Row(
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
            onPressed: onAddAnswerTextPressed,
            name: "CHANGE",
            color: Colors.green,
          ),
        )
      ],
    );
  }

  Flexible buildAddFilesBox() {
    return Flexible(
      child: FractionallySizedBox(
        alignment: Alignment.center,
        heightFactor: 0.4,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ColoredBox(
            color: Colors.black38,
            child: ListView.builder(
              itemCount: ((widget.answer.fileList?.length ?? 0) < 4)
                  ? (widget.answer.fileList?.length ?? 0) + 1
                  : 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                if ((widget.answer.fileList?.length ?? 0) < 5 &&
                    index == (widget.answer.fileList?.length ?? 0)) {
                  return addNewFileButton(widget.answer);
                }
                return ShowImageWidget(
                    answer: widget.answer,
                    filePath: widget.answer.fileList![index],
                    setStateCallBack: () {
                      setState(() {});
                    });
              },
            ),
          ),
        ),
      ),
    );
  }

  Flexible buildAnswerTextEdit() {
    return Flexible(
      child: FractionallySizedBox(
        alignment: Alignment.center,
        heightFactor: 0.7,
        child: CupertinoTextField(
          focusNode: FocusNode(
            onKey: onKeyEvent,
          ),
          onSubmitted: (_) => onAddAnswerTextPressed(),
          decoration: ToolTheme.textFieldDecoration,
          maxLines: null,
          autofocus: true,
          controller: myControllerAnswer,
          textAlign: TextAlign.center,
          placeholder: "Answer Text",
        ),
      ),
    );
  }

  KeyEventResult onKeyEvent(node, event) {
    if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
      ToolNavigator.pop();
    }
    return KeyEventResult.ignored;
  }

  void onAddAnswerTextPressed() {
    widget.updateAnswerCallBack
        .call(answerText: myControllerAnswer.text, filsPath: filePath);
    ToolNavigator.pop();
  }

  Widget addNewFileButton(Answer answer) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async {
            await AnswerScreenViewModel.instance.choseNewImage(answer);
            setState(() {});
          },
          child: const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ColoredBox(
              color: Colors.green,
              child: Icon(
                Icons.add_a_photo_outlined,
                size: 100,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
