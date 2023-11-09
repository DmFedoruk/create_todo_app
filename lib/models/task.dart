import 'package:hive/hive.dart';

import '../styles/styles.dart';
import 'task_type.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  DateTime date;
  @HiveField(1)
  String text;
  @HiveField(2)
  bool isCompleted;
  @HiveField(3)
  TaskType taskType;
  Task(this.date, this.text, this.isCompleted, this.taskType);

  static List<Task> fetchAll() {
    Task t1 = Task(DateTime.now(), 'Test 1', false, Styles.tastTypes[1]);
    Task t2 = Task(DateTime.now().add(const Duration(days: 1)), 'Test 2', false,
        Styles.tastTypes[2]);
    return [t1, t2];
  }
}
