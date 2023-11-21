import '../task_type.dart';

class TaskForList {
  int id;
  String text;
  TaskType type;
  bool isCompleted;
  TaskForList(this.id, this.text, this.type, this.isCompleted);
}
