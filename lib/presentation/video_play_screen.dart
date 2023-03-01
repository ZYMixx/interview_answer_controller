import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';
import 'package:interview_answer_controller/data/tools/navigation_tool.dart';

class VideoPlayScreen extends StatefulWidget {
  final String videoPath;
  const VideoPlayScreen({Key? key, required this.videoPath}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _VideoPlayScreenState();
  }
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  final _meeduPlayerController =
      MeeduPlayerController(controlsStyle: ControlsStyle.primary);
  StreamSubscription? _playerEventSubs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  _init() {
    File file = File(widget.videoPath);
    _meeduPlayerController.setDataSource(
      DataSource(
        file: file,
        type: DataSourceType.file,
      ),
      autoplay: true,
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKey: (node, event) {
        if (event.isKeyPressed(LogicalKeyboardKey.space)) {
          if (_meeduPlayerController.playerStatus.playing) {
            _meeduPlayerController.pause();
          } else {
            _meeduPlayerController.play();
          }
          return KeyEventResult.ignored;
        }

        return KeyEventResult.ignored;
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.35),
        body: InkWell(
          onTap: () {
            ToolNavigator.pop();
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: SafeArea(
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: MeeduVideoPlayer(
                    controller: _meeduPlayerController,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _playerEventSubs?.cancel();
    _meeduPlayerController.dispose();
    super.dispose();
  }
}
