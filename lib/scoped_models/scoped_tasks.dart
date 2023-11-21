import 'dart:collection';

import 'package:create_todo_app/models/dto/task_for_list.dart';
import 'package:create_todo_app/models/task.dart';
import 'package:create_todo_app/styles/text_string.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../models/dto/task_for_date.dart';
import '../models/task_type.dart';

class ScopedTasks extends Model {
  final ItemScrollController listViewController = ItemScrollController();
  final TextEditingController textController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  DateTime now = DateTime.now();
  DateTime selectedDate = DateTime.now();
  DateTime dateForNewTask = DateTime.now();

  List<Task> tasks = [];
  List<TaskForDate> listOfTaskForDays = [];
  TaskType? selectedTaskType;

  int scrollIndex = 0;
  int MAX_ITEM = -1;

  Box? taskBox;

  bool typeIsEmpty = false;

  void scrollDown() {
    scrollFunction();
    if (scrollIndex != -1) {
      listViewController.scrollTo(
        index: scrollIndex,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  void changeSelectDate(DateTime date) {
    selectedDate = date;
    scrollDown();
    notifyListeners();
  }

  void changeSelectTaskType(TaskType taskType) {
    selectedTaskType = taskType;
    typeIsEmpty = false;
    scrollDown();
    notifyListeners();
  }

  void initTaskList() {
    tasks = [];
    listOfTaskForDays = [];
    if (taskBox != null) {
      for (int i = 0; i < taskBox!.values.length; i++) {
        Task task = taskBox!.getAt(i);
        if (!task.isCompleted) {
          tasks.add(task);
          if (task.id > MAX_ITEM) {
            MAX_ITEM = task.id;
          }
        }
      }
      _calculateCountOfTaskForDays();
      //scrollDown();
    }
  }

  void scrollFunction() {
    scrollIndex = listOfTaskForDays
        .indexWhere((TaskForDate element) => element.date == selectedDate);
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
        TaskForList(task.id, task.text, task.taskType, task.isCompleted);
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

  String calculateDayForButton() {
    String day = '';
    if (dateForNewTask.year == now.year &&
        dateForNewTask.month == now.month &&
        dateForNewTask.day == now.day) {
      day = TextString.today;
    } else if (dateForNewTask.year == now.year &&
        dateForNewTask.month == now.month &&
        dateForNewTask.day - 1 == now.day) {
      day = TextString.tomorrow;
    } else if (dateForNewTask.year == now.year &&
        dateForNewTask.month == now.month &&
        dateForNewTask.day + 1 == now.day) {
      day = TextString.yesterday;
    } else {
      day =
          "${_calculateMonth(dateForNewTask.month)}  ${dateForNewTask.day.toString()}";
    }
    return day;
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

  //choise darte for new task
  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        locale: const Locale('en', 'GB'),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      dateForNewTask = picked;
    }
    notifyListeners();
  }

  bool createTask() {
    if (formKey.currentState != null) {
      if (selectedTaskType == null) {
        typeIsEmpty = true;
      }
      bool isValid = formKey.currentState!.validate();
      if (!typeIsEmpty && isValid) {
        MAX_ITEM += 1;
        Task newTask = Task(MAX_ITEM, DateUtils.dateOnly(dateForNewTask),
            textController.text, false, selectedTaskType!);
        taskBox!.add(newTask);
        return true;
      }
    }
    return false;
  }

  void resetDate() {
    dateForNewTask = DateTime.now();
    textController.text = '';
    selectedTaskType = null;
    typeIsEmpty = false;
  }

  void updateTaskList() {
    initTaskList();
    notifyListeners();
  }

  void completeTask(TaskForList task, int index) async {
    Task dbTask = taskBox!.getAt(task.id);
    task.isCompleted = !task.isCompleted;
    dbTask.isCompleted = task.isCompleted;
    notifyListeners();
    taskBox!.putAt(task.id, dbTask);
    TaskForDate taskForDate = listOfTaskForDays[index];
    await Future.delayed(const Duration(milliseconds: 1500));
    taskForDate.listOfTasks.remove(task);
    notifyListeners();
  }
}
