class Subject {
  int? id;
  int position;
  String title;
  int undoneQuest = 0;
  int questCount = 0;
  Subject({this.id, required this.title, required this.position});
}
