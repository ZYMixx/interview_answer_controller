import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interview_answer_controller/presentation/answer_list_screen.dart';
import 'package:interview_answer_controller/presentation/view_models/answer_screen_view_model.dart';
import '../data/tools/file_picker.dart';
import '../data/tools/navigation_tool.dart';
import '../domain/answer.dart';
import 'my_widgets/MyWidgetButton.dart';

class AddNewFilesScreen extends StatefulWidget {
  const AddNewFilesScreen(
      {Key? key, required this.updateAnswerCallBack, required this.answer})
      : super(key: key);
  final Function(String? answerText, String? filsPath) updateAnswerCallBack;
  final Answer answer;

  @override
  State<AddNewFilesScreen> createState() => _AddNewFilesScreenState();

  static Widget getFileImageBox(Answer answer, String filePath,
      {Function? callBack}) {
    File file = File(filePath);
    var image2 = Image.file(
      file,
      scale: 0.5,
      fit: BoxFit.cover,
    );
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onLongPress: () {
          answer.fileList?.remove(filePath);
          ToolFilePicker.deleteFile(filePath);
          if (answer.fileList != null && answer.fileList!.isEmpty) {
            answer.fileList = null;
          }
          AnswerScreenViewModel.instance.editAnswer(answer);
          callBack?.call();
        },
        onTap: () {
          ToolNavigator.push(
            Scaffold(
              backgroundColor: const Color.fromRGBO(0, 0, 0, 0.35),
              body: InkWell(
                onTap: () {
                  ToolNavigator.pop();
                },
                child: Center(
                  child: image2,
                ),
              ),
            ),
          );
        },
        child: AspectRatio(
          aspectRatio: 1,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: image2,
          ),
        ),
      ),
    );
  }
}

class _AddNewFilesScreenState extends State<AddNewFilesScreen> {
  @override
  Widget build(BuildContext context) {
    String? filePath;
    final myControllerAnswer = TextEditingController();
    myControllerAnswer.text = widget.answer.answerText ?? "";

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
                    child: Container(),
                  ),
                  Flexible(
                    child: FractionallySizedBox(
                      alignment: Alignment.center,
                      heightFactor: 0.7,
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
                          widget.updateAnswerCallBack
                              .call(myControllerAnswer.text, filePath);
                          ToolNavigator.pop();
                        },
                        maxLines: null,
                        autofocus: true,
                        controller: myControllerAnswer,
                        textAlign: TextAlign.center,
                        placeholder: "Answer Text",
                      ),
                    ),
                  ),
                  Flexible(
                    child: FractionallySizedBox(
                      alignment: Alignment.center,
                      heightFactor: 0.4,
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: ColoredBox(
                          color: Colors.black38,
                          child: ListView.builder(
                            itemCount:
                                ((widget.answer.fileList?.length ?? 0) < 4)
                                    ? (widget.answer.fileList?.length ?? 0) + 1
                                    : 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              if ((widget.answer.fileList?.length ?? 0) < 5 &&
                                  index ==
                                      (widget.answer.fileList?.length ?? 0)) {
                                return addNewFileButton(widget.answer);
                              }
                              return AddNewFilesScreen.getFileImageBox(
                                  widget.answer, widget.answer.fileList![index],
                                  callBack: () {
                                setState(() {});
                              });
                            },
                          ),
                        ),
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
                            widget.updateAnswerCallBack
                                .call(myControllerAnswer.text, filePath);
                            ToolNavigator.pop();
                          },
                          name: "CHANGE",
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

  Widget addNewFileButton(Answer answer) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async {
            try {
              List<String?>? filePathList =
                  await ToolFilePicker.choseImageFile();
              if (filePathList != null) {
                var number = 0;
                for (var path in filePathList!) {
                  String fileName =
                      "${answer.subjectTitle}_${answer.id}_${number.toString()}_${DateTime.now()}";
                  number++;
                  print(fileName);
                  fileName = fileName.replaceAll(':', '-');
                  String newFilePath =
                      ToolFilePicker.saveImgFileToUserFolder(path!, fileName);
                  answer.addToList(newFilePath);
                }

                AnswerScreenViewModel.instance.editAnswer(answer);
                setState(() {});
              }
            } catch (e) {
              print(e);
            }
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