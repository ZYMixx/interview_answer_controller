import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyRichText extends StatelessWidget {
  final String text;
  const MyRichText({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "",
        style: TextStyle(fontSize: 16),
        children: parsText(text),
      ),
    );
  }
}

List<TextSpan> parsText(String userText) {
  List<TextSpan> formattedTextSpanList = [];
  var firstPos = 0;
  var secondPos = 0;
  while (userText.contains("**")) {
    firstPos = userText.indexOf("**");
    secondPos = userText.indexOf("**", firstPos + 2);
    if (secondPos == -1) {
      break;
    }
    var regularTextPart = userText.substring(0, firstPos);
    var bloodTextPart =
        userText.substring(firstPos, secondPos + 2).replaceAll("**", "");
    formattedTextSpanList.add(TextSpan(
        text: regularTextPart,
        style: TextStyle(
          color: Colors.black,
        )));
    formattedTextSpanList.add(TextSpan(
        text: bloodTextPart,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)));
    userText = userText.substring(secondPos + 2);
  }
  formattedTextSpanList
      .add(TextSpan(text: userText, style: TextStyle(color: Colors.black)));
  return formattedTextSpanList;
}
