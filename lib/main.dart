import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'models/task.dart';
import 'models/task_type.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  final tasksBox = await Hive.openBox('tasks');
  List<Task> task = Task.fetchAll();
  tasksBox.addAll(task);
  task[0].save();
  //Task t = tasksBox.getAt(0);
  print(tasksBox.length);
  runApp(const App());
}
