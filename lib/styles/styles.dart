import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/task_type.dart';
import 'text_string.dart';

class Styles {
  static const _fontNameDefault = 'Plus Jakarta Sans';

  //fontSize
  static final double _titleFontSize = 20.0.sp;
  static final double calendarNumberFontSize = 18.0.sp;
  static final double calendarDayFontSize = 10.0.sp;
  static final double taskNameSize = 14.0.sp;
  static final double specialIconTextSize = 12.0.sp;
  static final double numbersFontSize = 36.0.sp;

  //start page
  static final double appStatusStrokeHeight = 28.0.h;
  static final double appBarHeight = 80.0.h;
  static final double avatarRadius = 32.0.r;
  static final double iconSize = 48.0.r;
  static final double fillPartOfScreen = 502.0.h;

  //list calendar
  static final double dayListHeight = 68.0.h;
  static final double oneDayHeight = 64.0.h;
  static final double dayFromListWidth = 46.0.w;

  //bottom bar
  static final double bottomBarHeight = 88.0.h;
  static final double bottomBarHeightWithoutDiv = 87.0.h;
  static final double addIconSize = 56.0.r;

  //task of day item
  static final double circleSize = 4.0.r;
  static final double titleHeight = 24.0.h;
  static final double taskHeight = 48.0.h;
  static final double taskTitleWidth = 234.0.w;
  static final double taskTypeCheck = 8.0.r;

  //bottom sheet to add task
  static final double plugCorner = 2.0.r;
  static final double corners = 16.0.r;
  static final double fieldHeight = 136.0.h;
  static final double handleHeight = 4.0.h;
  static final double handleWidth = 48.0.w;
  static final double textFieldHeight = 40.0.h;
  //special button for bottom sheet
  static final double specialIconButtonHeight = 40.0.h;
  static final double specialIconButtonWidth = 87.0.w;
  static final double specialIconButtonCorners = 10.0.r;
  static final double specialIconSize = 20.0.r;
  //confirm button
  static final double confirmIconSize = 40.0.r;

  //list of task types
  static final double taskTypeRectangleSize = 16.0.r;

  //search screen
  static final double backButtonSize = 48.0.r;
  static final double searchScreenTitle = 24.0.h;
  static final double checkboxSize = 24.0.r;

  //menu bottom sheet
  static final double itemHeight = 48.0.h;
  static final double menuIconSize = 24.0.h;
  static final double statisticLeadingWidth = 140.0.w;

  //statistics
  static final double toggleButtonCorners = 10.0.r;
  static final double togglePlugHeight = 40.0.h;
  static final double toggleButtonHeight = 32.0.h;
  static final double toggleButtonWidth = 75.0.w;
  static final double countAndPercentHeigth = 76.0.h;
  static final double countAndPercentWidth = 160.0.w;
  static final double scheduleHeight = 132.0.h;
  static final double scheduleHeightWithPadding = 116.0.h;
  static final double dashItemLength = 5.0.h;
  static final double separatorWidth = 50.0.w;
  static final double taskTypeHeight = 20.0.h;

  static const Color lightGrey = Color.fromRGBO(192, 195, 201, 1);
  static const Color grey = Color.fromRGBO(126, 132, 145, 1);
  static const Color green = Color.fromRGBO(0, 168, 107, 1);
  static const Color orange = Color.fromRGBO(244, 175, 37, 1);
  static const Color textColor = Color.fromRGBO(14, 16, 15, 1);
  static const Color lightTextColor = Color.fromRGBO(126, 132, 145, 1);
  static const Color extraLightGrey = Color.fromRGBO(241, 243, 243, 1);
  static const Color checkboxColor = Color.fromRGBO(244, 246, 246, 1);

  static const Color redType = Color.fromRGBO(244, 71, 37, 1);
  static const Color blueType = Color.fromRGBO(3, 127, 255, 1);
  static const Color greenType = Color.fromRGBO(0, 168, 107, 1);
  static const Color yellowType = Color.fromRGBO(244, 175, 37, 1);

  static final appBarStyle = TextStyle(
      fontFamily: _fontNameDefault,
      fontSize: _titleFontSize,
      fontWeight: FontWeight.w600,
      color: textColor,
      height: 16 / 10);

  static final textForDayStyle = TextStyle(
      fontFamily: _fontNameDefault,
      fontSize: calendarDayFontSize,
      fontWeight: FontWeight.w500,
      color: lightTextColor,
      height: 16 / 10);

  static final dotStyle = TextStyle(
      fontFamily: _fontNameDefault,
      fontSize: calendarDayFontSize,
      fontWeight: FontWeight.w500,
      color: extraLightGrey,
      height: 14 / 10);
  static final taskTextStyle = TextStyle(
      fontFamily: _fontNameDefault,
      fontSize: taskNameSize,
      fontWeight: FontWeight.w500,
      color: textColor,
      height: 20 / 14);

  static final taskTypeText = TextStyle(
      fontFamily: _fontNameDefault,
      fontSize: calendarDayFontSize,
      fontWeight: FontWeight.w500,
      color: lightTextColor,
      height: 16 / 10);

  static final textFieldHintStyle = TextStyle(
      fontFamily: _fontNameDefault,
      fontSize: taskNameSize,
      fontWeight: FontWeight.w500,
      color: lightGrey,
      height: 20 / 14);

  static final specialButtonText = TextStyle(
      fontFamily: _fontNameDefault,
      fontSize: specialIconTextSize,
      fontWeight: FontWeight.w500,
      color: lightTextColor,
      height: 14 / 12);

  //search screen
  static final searchScreenTaskTitle = TextStyle(
      fontFamily: _fontNameDefault,
      fontSize: calendarDayFontSize,
      fontWeight: FontWeight.w500,
      color: grey,
      height: 16 / 10);

  //menu BottomSheet
  static final menuBottomSheet = TextStyle(
      fontFamily: _fontNameDefault,
      fontSize: taskNameSize,
      fontWeight: FontWeight.w500,
      color: textColor,
      height: 20 / 14);

  //statistics screen
  static final statisticScreenTitle = TextStyle(
      fontFamily: _fontNameDefault,
      fontSize: _titleFontSize,
      fontWeight: FontWeight.w600,
      color: textColor,
      height: 28 / 20);

  static final toggleButtonActive = TextStyle(
      fontFamily: _fontNameDefault,
      fontSize: specialIconTextSize,
      fontWeight: FontWeight.w500,
      color: textColor,
      height: 16 / 12);

  static final toggleButtonUnActive = TextStyle(
      fontFamily: _fontNameDefault,
      fontSize: specialIconTextSize,
      fontWeight: FontWeight.w500,
      color: lightTextColor,
      height: 16 / 12);

  static final countDescriptionStyle = TextStyle(
      fontFamily: _fontNameDefault,
      fontSize: taskNameSize,
      fontWeight: FontWeight.w500,
      color: lightTextColor,
      height: 20 / 14);
  static final countNumberStyle = TextStyle(
      fontFamily: _fontNameDefault,
      fontSize: numbersFontSize,
      fontWeight: FontWeight.w600,
      color: textColor,
      height: 36 / 36);
  static final countTextStyle = TextStyle(
      fontFamily: _fontNameDefault,
      fontSize: _titleFontSize,
      fontWeight: FontWeight.w600,
      color: lightTextColor,
      height: 32 / 20);

  static final List<TaskType> taskTypes = [
    TaskType(0, 'Work'),
    TaskType(1, 'Hobby'),
    TaskType(2, 'Personal'),
    TaskType(3, 'Lifestyle'),
  ];
  static const List<Color> colorsList = [
    yellowType,
    redType,
    blueType,
    greenType,
  ];

  static const List<String> listOfPeriod = [
    TextString.weekly,
    TextString.moonthly,
    TextString.yearly,
    TextString.all
  ];
}
