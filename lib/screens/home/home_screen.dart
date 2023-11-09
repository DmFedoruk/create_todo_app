import 'package:create_todo_app/scoped_models/scoped_tasks.dart';
import 'package:create_todo_app/screens/home/widgets/horizontal_week_calendar.dart';
import 'package:create_todo_app/screens/home/widgets/list_of_tasks.dart';
import 'package:create_todo_app/styles/text_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../styles/styles.dart';

class HomeScreen extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final taskManager;
  const HomeScreen(this.taskManager, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModel<ScopedTasks>(
        model: taskManager,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _customAppBar(),
                const HorizontalWeekCalendar(),
                const ListOfTasks()
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() => Stack(
        children: [
          Container(
            height: 1.0.h,
            color: Styles.extraLightGrey,
          ),
          SizedBox(
              height: Styles.bottomBarHeightWithoutDiv,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0.w),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/icons/menu.png',
                            height: Styles.iconSize,
                            width: Styles.iconSize,
                          ),
                        ),
                        SizedBox(width: 4.0.w),
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            'assets/icons/search.png',
                            height: Styles.iconSize,
                            width: Styles.iconSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 16.0.w),
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        'assets/icons/add.png',
                        height: Styles.addIconSize,
                        width: Styles.addIconSize,
                      ),
                    ),
                  )
                ],
              )),
        ],
      );

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
