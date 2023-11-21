import 'package:hive/hive.dart';

import 'task_type.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  DateTime date;
  @HiveField(2)
  String text;
  @HiveField(3)
  bool isCompleted;
  @HiveField(4)
  TaskType taskType;
  Task(this.id, this.date, this.text, this.isCompleted, this.taskType);

  // static List<Task> fetchAll() {
  //   Task t1 = Task(
  //       DateUtils.dateOnly(DateTime.now()).add(const Duration(days: -1)),
  //       'Test 1',
  //       false,
  //       Styles.taskTypes[1]);
  //   Task t2 = Task(
  //       DateUtils.dateOnly(DateTime.now()).add(const Duration(days: 2)),
  //       'Test 2',
  //       false,
  //       Styles.taskTypes[2]);
  //   return [t1, t2];
  // }
}
