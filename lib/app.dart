import 'package:create_todo_app/scoped_models/scoped_tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'models/task.dart';
import 'screens/home/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final taskManager = ScopedTasks();

    final taskList = Task.fetchAll();
    taskManager.tasks = taskList;
    return ScreenUtilInit(
      designSize: const Size(360, 764),
      child: MaterialApp(
          debugShowCheckedModeBanner: false, home: HomeScreen(taskManager)),
    );
  }
}
