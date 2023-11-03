import 'package:create_todo_app/screens/home/widgets/horizontal_week_calendar.dart';
import 'package:create_todo_app/styles/text_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: Styles.appStatusStrokeHeight,
          ),
          _customAppBar(),
          const HorizontalWeekCalendar()
        ],
      ),
    );
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
