import 'package:hive_flutter/hive_flutter.dart';

part 'task_type.g.dart';

@HiveType(typeId: 1)
class TaskType extends HiveObject {
  @HiveField(0)
  int color;
  @HiveField(1)
  String name;
  TaskType(this.color, this.name);
}
