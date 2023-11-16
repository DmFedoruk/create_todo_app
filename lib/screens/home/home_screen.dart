import 'package:create_todo_app/scoped_models/scoped_tasks.dart';
import 'package:create_todo_app/screens/home/widgets/horizontal_week_calendar.dart';
import 'package:create_todo_app/screens/home/widgets/list_of_tasks.dart';
import 'package:create_todo_app/styles/text_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../styles/styles.dart';
import 'widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScopedTasks taskManager = ScopedTasks();
    return ScopedModel<ScopedTasks>(
        model: taskManager,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _customAppBar(),
                const HorizontalWeekCalendar(),
                FutureBuilder(
                    future: _getData(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        taskManager.taskBox = snapshot.data;
                        taskManager.initTaskList();
                        return const ListOfTasks();
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ],
            ),
          ),
          bottomNavigationBar: const CustomBottomNavigationBar(),
        ));
  }

  Future<Box> _getData() async {
    final tasksBox = await Hive.openBox('tasks');
    // List<Task> tasks = Task.fetchAll();

    // tasksBox.addAll(tasks);
    //await Future.delayed(Duration(seconds: 10));
    return tasksBox;
  }

  Widget _customAppBar() {
    return SizedBox(
      height: Styles.appBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: Styles.avatarRadius,
            height: Styles.avatarRadius,
            margin: EdgeInsets.only(left: 20.0.w, right: 12.0.w),
            decoration:
                const BoxDecoration(shape: BoxShape.circle, color: Styles.grey),
          ),
          Text(
            TextString.greetingsString,
            style: Styles.appBarStyle,
          ),
          _notificationButton()
        ],
      ),
    );
  }

  Widget _notificationButton() {
    return Container(
        margin: EdgeInsets.only(left: 70.0.w),
        padding: EdgeInsets.zero,
        child: MaterialButton(
          minWidth: Styles.iconSize,
          padding: EdgeInsets.zero,
          onPressed: () {},
          shape: const CircleBorder(),
          child: Image.asset(
            'assets/icons/notification.png',
            height: Styles.iconSize,
          ),
        ));
  }
}
