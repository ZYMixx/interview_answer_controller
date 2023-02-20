import 'package:flutter/material.dart';
import 'package:flutter_meedu_videoplayer/init_meedu_player.dart';
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
        theme: ThemeData(),
        home: LaunchScreen(),
      ),
    );
  }
}
