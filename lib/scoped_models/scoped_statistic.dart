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
  List<double> realCount = [0, 0, 0, 0];
  List<double> allCount = [0, 0, 0, 0];
  List<double> realLength = [0, 0, 0, 0];
  List<double> allLength = [0, 0, 0, 0];

  void calculateStatistics() {
    completedTasks = 0;
    allTasks = 0;
    completedPercent = 0;
    if (_singleton.taskBox != null) {
      for (int i = 0; i < _singleton.taskBox!.values.length; i++) {
        Task task = _singleton.taskBox!.getAt(i);
        taskList.add(task);
      }
    }
    calculateCountAndPercent();
  }

  void calculateCountAndPercent() {
    for (Task task in taskList) {
      allTasks++;
      if (task.isCompleted) {
        completedTasks++;
      }
    }
    completedPercent = ((100 * completedTasks) / allTasks).round();
  }

  void changePoint(int index) {
    for (var i = 0; i < selectedPoint.length; i++) {
      if (i == index) {
        selectedPoint[i] = true;
      } else {
        selectedPoint[i] = false;
      }
    }
    notifyListeners();
  }
}
