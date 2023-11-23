import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/styles.dart';

Widget checkBox(bool value) {
  return Container(
    height: Styles.checkboxSize,
    width: Styles.checkboxSize,
    margin: EdgeInsets.only(right: 12.0.w),
    child: Checkbox(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0.r)),
        side: BorderSide.none,
        checkColor: Styles.orange,
        activeColor: Styles.checkboxColor,
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (!states.contains(MaterialState.selected)) {
            return Styles.checkboxColor;
          }
          return null;
        }),
        value: value,
        onChanged: null),
  );
}
