import 'package:create_todo_app/models/task_type.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/singleton.dart';
import '../models/task.dart';
import '../styles/styles.dart';

class ScopedSearch extends Model {
  final TextEditingController textController = TextEditingController();
  List<Task> tasks = [];
  List<Task> tasksToShow = [];
  List<int> countOfTasks = List.filled(Styles.taskTypes.length, 0);
  final singleton = Singleton();

  Box? taskBox;

  void searchTasks() {
    List<Task> newTask = [];
    for (Task item in tasks) {
      if (item.text.contains(textController.text)) {
        newTask.add(item);
      }
    }
    tasksToShow = newTask;
    notifyListeners();
  }

  void calculateCountOfTask() {
    taskBox = singleton.taskBox;
    tasks = singleton.listOfTasks;
    tasksToShow = singleton.listOfTasks;
    for (Task item in tasks) {
      int i = 0;
      for (TaskType type in Styles.taskTypes) {
        if (type.color == item.taskType.color &&
            type.name == item.taskType.name) {
          countOfTasks[i]++;
          break;
        }
        i++;
      }
    }
  }

  void completeTask(Task task) async {
    Task dbTask = taskBox!.getAt(task.id);
    task.isCompleted = !task.isCompleted;
    dbTask.isCompleted = task.isCompleted;
    notifyListeners();
    taskBox!.putAt(task.id, dbTask);
    tasksToShow.remove(task);
    tasks.remove(task);
    await Future.delayed(const Duration(milliseconds: 1500));
    notifyListeners();
  }

  void searchTasksForType(TaskType type) {
    List<Task> newTask = [];
    textController.text = '';
    for (Task item in tasks) {
      if (item.taskType.name == type.name) {
        newTask.add(item);
      }
    }
    tasksToShow = newTask;
    notifyListeners();
  }
}
