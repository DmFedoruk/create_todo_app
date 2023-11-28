import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../models/task_type.dart';
import '../../scoped_models/scoped_search.dart';
import '../../styles/styles.dart';
import '../../styles/text_string.dart';

Widget listItem(TaskType taskType, int count) =>
    ScopedModelDescendant<ScopedSearch>(
      builder: (context, child, model) => GestureDetector(
        onTap: () {
          model.searchTasksForType(taskType);
        },
        child: Container(
          height: Styles.taskHeight,
          decoration: const BoxDecoration(
              color: Colors.white,
              border: Border.symmetric(
                  horizontal:
                      BorderSide(color: Styles.extraLightGrey, width: 1.0))),
          margin: EdgeInsets.symmetric(horizontal: 6.0.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 12.0.w),
                    height: Styles.taskTypeRectangleSize,
                    width: Styles.taskTypeRectangleSize,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Styles.colorsList[taskType.color],
                            width: 2.0),
                        borderRadius: BorderRadius.circular(4.0.r)),
                  ),
                  Text(
                    taskType.name,
                    style: Styles.taskTextStyle,
                  )
                ],
              ),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 4.0.h),
                  child: Text('$count ${TextString.task}'))
            ],
          ),
        ),
      ),
    );
