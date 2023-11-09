import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/task_type.dart';
import '../../../styles/styles.dart';

class ListOfTasks extends StatelessWidget {
  const ListOfTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: EdgeInsets.only(top: 12.0.h),
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 120,
            itemBuilder: (context, index) {
              return _day(index);
            }),
      ),
    );
  }

  Container _day(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0.h),
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      height: Styles.titleHeight +
          Styles.itemCountForTest * (Styles.taskHeight + 2.0.h),
      child: Column(children: [_textItem(), _taskList()]),
    );
  }

  Widget _textItem() => SizedBox(
        height: Styles.titleHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Today', style: Styles.textForDayStyle),
            SizedBox(width: 8.0.w),
            Text('•', style: Styles.dotStyle),
            SizedBox(width: 8.0.w),
            Text('Wednesday', style: Styles.textForDayStyle),
          ],
        ),
      );

  Container _taskList() {
    return Container(
      decoration: const BoxDecoration(
          border: Border.symmetric(
              horizontal:
                  BorderSide(color: Styles.extraLightGrey, width: 1.0))),
      height: Styles.itemCountForTest * (Styles.taskHeight + 2.0.h),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            return _taskItem(false);
          }),
    );
  }

  Widget _taskItem(bool value) => Container(
        color: Colors.white,
        height: Styles.taskHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _checkBox(value),
            _title(),
            _typeOfTask(Styles.tastTypes[0])
          ],
        ),
      );

  Widget _typeOfTask(TaskType taskType) => Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 4.0.w),
            height: Styles.taskTypeCheck,
            width: Styles.taskTypeCheck,
            decoration: BoxDecoration(
                border: Border.all(color: taskType.color),
                borderRadius: BorderRadius.circular(2.0.r)),
          ),
          Text(taskType.name)
        ],
      );

  Flexible _title() {
    return Flexible(
      child: Container(
        padding: EdgeInsets.only(bottom: 6.0.h, right: 12.0.w),
        child: Text(
            'Design gd kfl df  fdffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
            overflow: TextOverflow.ellipsis,
            style: Styles.taskTextStyle),
      ),
    );
  }

  Checkbox _checkBox(bool value) {
    return Checkbox(
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
        onChanged: (val) {
          value = val!;
        });
  }
}
