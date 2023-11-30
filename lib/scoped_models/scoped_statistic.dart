import 'package:scoped_model/scoped_model.dart';

import '../models/singleton.dart';
import '../models/task.dart';

class ScopedStatistic extends Model {
  final _singleton = Singleton();
  List<Task> taskList = [];
  List<bool> selectedPoint = [true, false, false, false];
  int completedTasks = 0;
  int allTasks = 0;
  int completedPercent = 0;
  List<int> realCount = [0, 0, 0, 0];
  List<int> allCount = [0, 0, 0, 0];
  List<double> realLength = [0, 0, 0, 0];
  List<double> allLength = [0, 0, 0, 0];

  void calculateStatistics() {
    taskList = [];
    if (_singleton.taskBox != null) {
      for (int i = 0; i < _singleton.taskBox!.values.length; i++) {
        Task task = _singleton.taskBox!.getAt(i);
        taskList.add(task);
      }
    }
    calculateCountAndPercent(DateTime.now().add(const Duration(days: -7)));
  }

  void calculateCountAndPercent(DateTime date) {
    completedTasks = 0;
    allTasks = 0;
    completedPercent = 0;
    realCount = [0, 0, 0, 0];
    allCount = [0, 0, 0, 0];
    realLength = [0, 0, 0, 0];
    allLength = [0, 0, 0, 0];
    DateTime now = DateTime.now().add(const Duration(days: 1));
    for (Task task in taskList) {
      if (task.date.isAfter(date) && task.date.isBefore(now)) {
        allTasks++;
        countOfTaskForType(task);
      }
    }
    completedPercent = ((100 * completedTasks) / allTasks).round();
    calculateLength();
  }

  void countOfTaskForType(Task task) {
    if (task.isCompleted) {
      completedTasks++;
      switch (task.taskType.name) {
        case 'Work':
          realCount[0]++;
          break;
        case 'Hobby':
          realCount[1]++;
          break;
        case 'Personal':
          realCount[2]++;
          break;
        case 'Lifestyle':
          realCount[3]++;
          break;
      }
    }
    switch (task.taskType.name) {
      case 'Work':
        allCount[0]++;
        break;
      case 'Hobby':
        allCount[1]++;
        break;
      case 'Personal':
        allCount[2]++;
        break;
      case 'Lifestyle':
        allCount[3]++;
        break;
    }
  }

  void calculateLength() {
    for (var i = 0; i < realCount.length; i++) {
      realLength[i] = 320 *
          (realCount[i] *
                  (1.01 - realCount[i] / completedTasks) /
                  (completedTasks - realCount[i]))
              .abs();
    }
    for (var i = 0; i < allCount.length; i++) {
      allLength[i] = 320 *
          (allCount[i] / realCount[i]) *
          (allCount[i] *
                  (1.01 - allCount[i] / allTasks) /
                  (allTasks - allCount[i]))
              .abs();
    }
  }

  void changePoint(int index) {
    for (var i = 0; i < selectedPoint.length; i++) {
      if (i == index) {
        selectedPoint[i] = true;
        updateStats(index);
      } else {
        selectedPoint[i] = false;
      }
    }
    notifyListeners();
  }

  void updateStats(int index) {
    switch (index) {
      case 0:
        calculateCountAndPercent(DateTime.now().add(const Duration(days: -7)));
        break;
      case 1:
        calculateCountAndPercent(DateTime.now().add(const Duration(days: -30)));
        break;
      case 2:
        calculateCountAndPercent(
            DateTime.now().add(const Duration(days: -365)));
        break;
      case 3:
        calculateCountAndPercent(DateTime.now());
        break;
    }
  }
}
