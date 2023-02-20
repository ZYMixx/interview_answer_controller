import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

class MyLog {
  static log(String text) {
    StackTrace.current;
    var time = DateTime.now();
    print("MYLOG: $text ${time.minute}:${time.second}:${time.millisecond}");
  }
}
