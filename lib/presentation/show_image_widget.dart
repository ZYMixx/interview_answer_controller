import 'dart:io';
import 'package:flutter/material.dart';
import 'package:interview_answer_controller/presentation/view_models/answer_screen_view_model.dart';
import '../data/tools/file_picker.dart';
import '../data/tools/navigation_tool.dart';
import '../domain/answer.dart';

class ShowImageWidget extends StatelessWidget {
  final Answer answer;
  final String filePath;
  final Function? setStateCallBack;

  const ShowImageWidget({
    Key? key,
    required this.answer,
    required this.filePath,
    this.setStateCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var image = Image.file(
      File(filePath),
      scale: 0.5,
      fit: BoxFit.cover,
    );
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onLongPress: () =>
            onDeleteImagePressed(answer, filePath, setStateCallBack),
        onTap: () => ToolNavigator.push(buildFullScreenImage(image)),
        child: AspectRatio(
          aspectRatio: 1,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: image,
          ),
        ),
      ),
    );
  }
}

void onDeleteImagePressed(Answer answer, String filePath, Function? callBack) {
  answer.fileList?.remove(filePath);
  ToolFilePicker.deleteFile(filePath);
  if (answer.fileList != null && answer.fileList!.isEmpty) {
    answer.fileList = null;
  }
  AnswerScreenViewModel.instance.editAnswer(answer);
  callBack?.call();
}

Scaffold buildFullScreenImage(Image image) {
  return Scaffold(
    backgroundColor: const Color.fromRGBO(0, 0, 0, 0.35),
    body: InkWell(
      onTap: ToolNavigator.pop,
      child: Center(
        child: image,
      ),
    ),
  );
}
