import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/task_type.dart';
import '../../../scoped_models/scoped_tasks.dart';
import '../../../styles/styles.dart';
import '../../../styles/text_string.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 1.0.h,
          color: Styles.extraLightGrey,
        ),
        Container(
            color: Colors.white,
            height: Styles.bottomBarHeightWithoutDiv,
            child: ScopedModelDescendant<ScopedTasks>(
                builder: (context, child, model) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0.w),
                          child: Row(
                            children: [
                              _bottomButton('assets/icons/menu.png', () {}),
                              SizedBox(width: 4.0.w),
                              _bottomButton('assets/icons/search.png', () {
                                model.pushToSearchScreen(context);
                              }),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: 16.0.w),
                            child: GestureDetector(
                              onTap: () {
                                _showModalButtomSheet(context, model);
                                model.resetDate();
                              },
                              child: Image.asset(
                                'assets/icons/add.png',
                                height: Styles.addIconSize,
                                width: Styles.addIconSize,
                              ),
                            )),
                      ],
                    ))),
      ],
    );
  }

  GestureDetector _bottomButton(String asset, Function function) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Image.asset(
        asset,
        height: Styles.iconSize,
        width: Styles.iconSize,
      ),
    );
  }
  ////ALL modals widgets///////////////////////////////////////////////////////////////////////////////////////////

  void _showModalButtomSheet(BuildContext context, ScopedTasks model) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(Styles.corners))),
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Column(
                children: [
                  Container(
                    height: Styles.handleHeight,
                    width: Styles.handleWidth,
                    margin: EdgeInsets.only(top: 16.0.h),
                    decoration:
                        const BoxDecoration(color: Styles.extraLightGrey),
                  ),
                  Container(
                    height: Styles.textFieldHeight,
                    margin: EdgeInsets.symmetric(vertical: 20.0.h),
                    child: Form(
                      key: model.formKey,
                      child: TextFormField(
                        controller: model.textController,
                        autofocus: true,
                        cursorColor: Styles.textColor,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return TextString.emptyTask;
                          }
                          return null;
                        },
                        decoration: InputDecoration.collapsed(
                            focusColor: Colors.white,
                            hintText: TextString.writeTask,
                            hintStyle: Styles.textFieldHintStyle),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: Styles.specialIconButtonHeight,
                      child: StatefulBuilder(
                          builder: (context, StateSetter setState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                _specialIconButton('assets/icons/calendar.png',
                                    model.calculateDayForButton(), () async {
                                  await model.selectDate(context);
                                }),
                                SizedBox(width: 8.0.w),
                                _listIconButton(context, model),
                              ],
                            ),
                            _addTaskButton(model.dateForNewTask, () {
                              setState(() {
                                if (model.createTask()) {
                                  Navigator.pop(context);
                                  model.updateTaskList();
                                }
                                ;
                              });
                            })
                          ],
                        );
                      })),
                  SizedBox(height: 16.0.h),
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _specialIconButton(String asset, String text, Function() function) {
    return GestureDetector(
        onTap: () {
          function();
        },
        child: Container(
          height: Styles.specialIconButtonHeight,
          width: Styles.specialIconButtonWidth,
          decoration: BoxDecoration(
              color: Styles.checkboxColor,
              borderRadius:
                  BorderRadius.circular(Styles.specialIconButtonCorners)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(asset,
                  height: Styles.specialIconSize,
                  width: Styles.specialIconSize),
              SizedBox(
                width: 8.0.w,
              ),
              Text(text, style: Styles.specialButtonText)
            ],
          ),
        ));
  }

  Widget _listIconButton(BuildContext context, ScopedTasks model) {
    return GestureDetector(
      onTap: () {
        _showActionSheet(context, model);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 10.0.h),
        decoration: BoxDecoration(
            color: Styles.checkboxColor,
            border: Border.all(
                color: model.typeIsEmpty ? Colors.red : Styles.checkboxColor),
            borderRadius:
                BorderRadius.circular(Styles.specialIconButtonCorners)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 12.0.w),
              height: Styles.taskTypeRectangleSize,
              width: Styles.taskTypeRectangleSize,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: model.selectedTaskType != null
                          ? Styles.colorsList[model.selectedTaskType!.color]
                          : Styles.lightGrey,
                      width: 2.0),
                  borderRadius: BorderRadius.circular(2.0.r)),
            ),
            SizedBox(
              width: 8.0.w,
            ),
            Text(
                model.selectedTaskType != null
                    ? model.selectedTaskType!.name
                    : TextString.noList,
                style: Styles.specialButtonText)
          ],
        ),
      ),
    );
  }

  Widget _addTaskButton(DateTime date, Function function) {
    return GestureDetector(
        onTap: () {
          function();
        },
        child: Image.asset("assets/icons/confirm.png",
            height: Styles.confirmIconSize, width: Styles.confirmIconSize));
  }

  void _showActionSheet(BuildContext context, ScopedTasks model) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
            actions: List.generate(
                Styles.taskTypes.length,
                (index) =>
                    taskTypeForList(context, Styles.taskTypes[index], model))));
  }

  Widget taskTypeForList(
      BuildContext context, TaskType taskType, ScopedTasks model) {
    return CupertinoActionSheetAction(
      onPressed: () {
        Navigator.pop(context);
        model.changeSelectTaskType(taskType);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.0.w),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 12.0.w),
              height: Styles.taskTypeRectangleSize,
              width: Styles.taskTypeRectangleSize,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Styles.colorsList[taskType.color], width: 2.0),
                  borderRadius: BorderRadius.circular(4.0.r)),
            ),
            Text(
              taskType.name,
              style: Styles.taskTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
