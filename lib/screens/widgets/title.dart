import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/styles.dart';

Flexible title(String text) {
  return Flexible(
    child: Container(
      padding: EdgeInsets.only(bottom: 6.0.h, right: 12.0.w),
      child: Text(text,
          overflow: TextOverflow.ellipsis, style: Styles.taskTextStyle),
    ),
  );
}
