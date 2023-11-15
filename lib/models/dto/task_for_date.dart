import 'package:create_todo_app/models/dto/task_for_list.dart';

class TaskForDate {
  DateTime date;
  List<TaskForList> listOfTasks;
  TaskForDate(this.date, this.listOfTasks);
}
