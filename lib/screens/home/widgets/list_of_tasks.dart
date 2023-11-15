import 'package:create_todo_app/scoped_models/scoped_tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/dto/task_for_date.dart';
import '../../../models/dto/task_for_list.dart';
import '../../../models/task_type.dart';
import '../../../styles/styles.dart';

class ListOfTasks extends StatelessWidget {
  const ListOfTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: Styles.fillPartOfScreen,
        child: Padding(
            padding: EdgeInsets.only(top: 12.0.h),
            child: ScopedModelDescendant<ScopedTasks>(
              builder: (context, child, model) => ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: model.listOfTaskForDays.length,
                  itemBuilder: (context, index) {
                    return _day(model.listOfTaskForDays[index]);
                  }),
            )),
      ),
    );
  }

  Container _day(TaskForDate taskForDate) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0.h),
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      height: Styles.titleHeight +
          taskForDate.listOfTasks.length * (Styles.taskHeight + 2.0.h),
      child: Column(children: [
        _textItem(taskForDate.date),
        _taskList(taskForDate.listOfTasks)
      ]),
    );
  }

  Widget _textItem(DateTime date) =>
      ScopedModelDescendant<ScopedTasks>(builder: (context, child, model) {
        List<String> namesOfDays = model.calculateNameOfDays(date);
        return SizedBox(
            height: Styles.titleHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(namesOfDays[1], style: Styles.textForDayStyle),
                SizedBox(width: 8.0.w),
                Text('•', style: Styles.dotStyle),
                SizedBox(width: 8.0.w),
                Text(namesOfDays[0], style: Styles.textForDayStyle),
              ],
            ));
      });

  SizedBox _taskList(List<TaskForList> taskList) {
    return SizedBox(
      height: taskList.length * (Styles.taskHeight + 2.0.h),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: taskList.length,
          itemBuilder: (context, index) {
            return _taskItem(taskList[index]);
          }),
    );
  }

  Widget _taskItem(TaskForList task) => Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border.symmetric(
                horizontal:
                    BorderSide(color: Styles.extraLightGrey, width: 1.0))),
        height: Styles.taskHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  _checkBox(task.isCompleted),
                  _title(task.text),
                ],
              ),
            ),
            _typeOfTask(task.type)
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
                border: Border.all(color: Styles.colorsList[taskType.color]),
                borderRadius: BorderRadius.circular(2.0.r)),
          ),
          Text(taskType.name)
        ],
      );

  Flexible _title(String text) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.only(bottom: 6.0.h, right: 12.0.w),
        child: Text(text,
            overflow: TextOverflow.ellipsis, style: Styles.taskTextStyle),
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
