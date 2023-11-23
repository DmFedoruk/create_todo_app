import 'package:create_todo_app/models/task_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../styles/styles.dart';

Widget typeOfTask(TaskType taskType) => Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 4.0.w),
          height: Styles.taskTypeCheck,
          width: Styles.taskTypeCheck,
          decoration: BoxDecoration(
              border: Border.all(color: Styles.colorsList[taskType.color]),
              borderRadius: BorderRadius.circular(2.0.r)),
        ),
        Text(taskType.name)
      ],
    );
