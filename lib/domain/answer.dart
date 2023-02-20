class Answer {
  Answer({
    required this.subjectTitle,
    this.id,
    required this.position,
    this.dateTime,
    this.title,
    this.questText,
    this.answerText,
    this.fileList,
    this.videoPath,
  });
  int? id;
  int position;
  DateTime? dateTime;
  String subjectTitle;
  String? title;
  String? questText;
  String? answerText;
  List<dynamic>? fileList;
  String? videoPath;

  addToList(String path) {
    if (fileList == null) {
      fileList = [path];
    } else {
      fileList?.add(path);
    }
    ;
  }

  @override
  String toString() {
    return 'Answer{id: $id, position: $position, dateTime: $dateTime, subjectTitle: $subjectTitle, title: $title, questText: $questText, answerText: $answerText, fileList: $fileList, videoPath: $videoPath}';
  }
}
