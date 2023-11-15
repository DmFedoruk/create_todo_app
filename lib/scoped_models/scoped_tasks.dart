import 'dart:collection';

import 'package:create_todo_app/models/dto/task_for_list.dart';
import 'package:create_todo_app/models/task.dart';
import 'package:create_todo_app/styles/text_string.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/dto/task_for_date.dart';

class ScopedTasks extends Model {
  DateTime now = DateTime.now();
  List<Task> tasks = [];
  List<TaskForDate> listOfTaskForDays = [];

  Box? taskBox;

  DateTime selectedDate = DateTime.now();

  void changeSelectDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void initTaskList() {
    if (taskBox != null) {
      for (int i = 0; i < taskBox!.values.length; i++) {
        Task task = taskBox!.getAt(i);
        tasks.add(task);
      }
      _calculateCountOfTaskForDays();
    }
  }

  void _calculateCountOfTaskForDays() {
    Map<DateTime, List<Task>> dateList = HashMap();
    for (var task in tasks) {
      if (dateList.containsKey(task.date)) {
        List<Task>? items = dateList[task.date];
        items!.add(task);
        dateList.update(task.date, (value) => items);
      } else {
        dateList.addAll({
          task.date: [task]
        });
      }
    }
    Map<DateTime, List<Task>> sortedDateList = Map.fromEntries(
        dateList.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
    sortedDateList.forEach((key, value) {
      TaskForDate taskForDate;
      List<TaskForList> taskForList = _generateTasksForList(value);
      taskForDate = TaskForDate(key, taskForList);
      listOfTaskForDays.add(taskForDate);
    });
  }

  List<TaskForList> _generateTasksForList(List<Task> tasks) {
    List<TaskForList> outputList = [];
    for (var item in tasks) {
      outputList.add(_generateOneTask(item));
    }
    return outputList;
  }

  TaskForList _generateOneTask(Task task) {
    TaskForList outputItem =
        TaskForList(task.text, task.taskType, task.isCompleted);
    return outputItem;
  }

  List<String> calculateNameOfDays(DateTime date) {
    List<String> outputList = [];
    outputList.add(_calculateWeekday(date.weekday));
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      outputList.add(TextString.today);
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day - 1 == now.day) {
      outputList.add(TextString.tomorrow);
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day + 1 == now.day) {
      outputList.add(TextString.yesterday);
    } else {
      outputList.add("${_calculateMonth(date.month)}  ${date.day.toString()}");
    }
    return outputList;
  }

  String _calculateWeekday(int weekCode) {
    String weekday = '';
    switch (weekCode) {
      case 1:
        weekday = TextString.monday;
        break;
      case 2:
        weekday = TextString.thuesday;
        break;
      case 3:
        weekday = TextString.wednesday;
        break;
      case 4:
        weekday = TextString.thursday;
        break;
      case 5:
        weekday = TextString.friday;
        break;
      case 6:
        weekday = TextString.saturday;
        break;
      case 7:
        weekday = TextString.sunday;
        break;
    }
    return weekday;
  }

  String _calculateMonth(int monthCode) {
    String month = '';
    switch (monthCode) {
      case 1:
        month = TextString.jan;
        break;
      case 2:
        month = TextString.feb;
        break;
      case 3:
        month = TextString.mar;
        break;
      case 4:
        month = TextString.apr;
        break;
      case 5:
        month = TextString.may;
        break;
      case 6:
        month = TextString.jun;
        break;
      case 7:
        month = TextString.jul;
        break;
      case 8:
        month = TextString.aug;
        break;
      case 9:
        month = TextString.sep;
        break;
      case 10:
        month = TextString.oct;
        break;
      case 11:
        month = TextString.nov;
        break;
      case 12:
        month = TextString.dec;
        break;
    }
    return month;
  }
}
