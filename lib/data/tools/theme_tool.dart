import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class ToolTheme {
  static const Color subjectColor = Color(0xFF6A1B9A);
  static const Color addSubjectColor = Color(0xCC5C6BC0);
  static const Color answerColor = Color(0xE65C6BC0);
  static const Color addAnswerColor = Color(0xB36A1B9A);
  static const Color mainBgColor = Color(0xFFC5CAE9);

  static const BoxDecoration bgBoxDecoration = BoxDecoration(
    color: mainBgColor,
    image: DecorationImage(
      colorFilter: ColorFilter.srgbToLinearGamma(),
      opacity: 0.7,
      image: AssetImage("assets/main_bg.png"),
      alignment: Alignment.bottomRight,
    ),
  );

  static const BoxDecoration textFieldDecoration = BoxDecoration(
    color: mainBgColor,
  );
}
