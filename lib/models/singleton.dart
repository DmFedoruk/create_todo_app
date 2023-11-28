import 'package:hive_flutter/hive_flutter.dart';

import 'task.dart';

class Singleton {
  Box? taskBox;
  List<Task> listOfTasks = [];
  static final Singleton _instance = Singleton._internal();

  factory Singleton() {
    return _instance;
  }
  Singleton._internal();
}
