import 'package:flutter/material.dart';
import 'package:flutter_meedu_videoplayer/init_meedu_player.dart';
import 'package:interview_answer_controller/data/tools/navigation_tool.dart';
import 'package:interview_answer_controller/data/tools/theme_tool.dart';
import '../data/tools/file_picker.dart';
import 'launch_screen.dart';

class App {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void start() async {
    ToolFilePicker.createAssetsDirectory();
    initMeeduPlayer();
    navigatorKey = GlobalKey<NavigatorState>();
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: ThemeData(
          canvasColor: Colors.black12,
          dialogBackgroundColor: ToolTheme.mainBgColor,
        ),
        home: LaunchScreen(),
      ),
    );
  }
}
