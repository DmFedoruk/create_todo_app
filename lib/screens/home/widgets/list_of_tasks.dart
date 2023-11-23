import 'package:create_todo_app/scoped_models/scoped_tasks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../models/dto/task_for_date.dart';
import '../../../models/dto/task_for_list.dart';
import '../../../styles/styles.dart';
import '../../widgets/check_box.dart';
import '../../widgets/title.dart';
import '../../widgets/type_of_task.dart';

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
              builder: (context, child, model) =>
                  ScrollablePositionedList.builder(
                      itemScrollController: model.listViewController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: model.listOfTaskForDays.length,
                      itemBuilder: (context, index) {
                        return model
                                .listOfTaskForDays[index].listOfTasks.isEmpty
                            ? const SizedBox()
                            : _day(model.listOfTaskForDays[index], index);
                      }),
            )),
      ),
    );
  }

  Container _day(TaskForDate taskForDate, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0.h),
      padding: EdgeInsets.symmetric(horizontal: 20.0.w),
      height: Styles.titleHeight +
          taskForDate.listOfTasks.length * (Styles.taskHeight + 2.0.h),
      child: Column(children: [
        _firstTextItem(taskForDate.date),
        _taskList(taskForDate.listOfTasks, index)
      ]),
    );
  }

  Widget _firstTextItem(DateTime date) =>
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

  SizedBox _taskList(List<TaskForList> taskList, int dayIndex) {
    return SizedBox(
      height: taskList.length * (Styles.taskHeight + 2.0.h),
      child: ScopedModelDescendant<ScopedTasks>(
        builder: (context, child, model) => ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    model.completeTask(taskList[index], dayIndex);
                  },
                  child: _taskItem(taskList[index]));
            }),
      ),
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
                  checkBox(task.isCompleted),
                  title(task.text),
                ],
              ),
            ),
            typeOfTask(task.type)
          ],
        ),
      );
}
