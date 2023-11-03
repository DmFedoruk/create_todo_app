import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Styles {
  static const _fontNameDefault = 'Plus Jakarta Sans';

  static final double _titleFontSize = 20.0.sp;
  static final double appStatusStrokeHeight = 28.0.h;
  static final double appBarHeight = 80.0.h;
  static final double avatarRadius = 32.0.r;
  static final double iconSize = 48.0.r;

  static final double dayListHeight = 68.0.h;

  static final double dayFromListHeight = 50.0.h;
  static final double dayFromListWidth = 46.0.w;

  static const Color lightGrey = Color.fromRGBO(192, 195, 201, 1);
  static const Color grey = Color.fromRGBO(126, 132, 145, 1);
  static const Color green = Color.fromRGBO(0, 168, 107, 1);
  static const Color orange = Color.fromRGBO(244, 175, 37, 1);
  static const Color textColor = Color.fromRGBO(14, 16, 15, 1);

  static final appBarStyle = TextStyle(
      fontFamily: _fontNameDefault,
      fontSize: _titleFontSize,
      fontWeight: FontWeight.w600,
      color: textColor,
      height: 32 / 20);
}
