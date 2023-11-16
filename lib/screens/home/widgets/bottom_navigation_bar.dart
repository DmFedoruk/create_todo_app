import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8.0.w),
                  child: Row(
                    children: [
                      _bottomButton('assets/icons/menu.png'),
                      SizedBox(width: 4.0.w),
                      _bottomButton('assets/icons/search.png'),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16.0.w),
                  child: ScopedModelDescendant<ScopedTasks>(
                      builder: (context, child, model) => GestureDetector(
                            onTap: () {
                              _showModalButtomSheet(context, model);
                            },
                            child: Image.asset(
                              'assets/icons/add.png',
                              height: Styles.addIconSize,
                              width: Styles.addIconSize,
                            ),
                          )),
                )
              ],
            )),
      ],
    );
  }

  GestureDetector _bottomButton(String asset) {
    return GestureDetector(
      onTap: () {},
      child: Image.asset(
        asset,
        height: Styles.iconSize,
        width: Styles.iconSize,
      ),
    );
  }

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
                    child: TextField(
                      autofocus: true,
                      cursorColor: Styles.textColor,
                      decoration: InputDecoration(
                          focusColor: Colors.white,
                          focusedBorder: InputBorder.none,
                          hintText: TextString.writeTask,
                          hintStyle: Styles.textFieldHintStyle),
                    ),
                  ),
                  SizedBox(
                      height: Styles.specialIconButtonHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              _specialIconButton(
                                  'assets/icons/calendar.png', TextString.today,
                                  () async {
                                await model.selectDate(context);
                              }),
                              SizedBox(width: 8.0.w),
                              _specialIconButton('assets/icons/no_list.png',
                                  TextString.noList, () {}),
                            ],
                          ),
                          _addTaskButton(model.dateForNewTask)
                        ],
                      )),
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

  Widget _addTaskButton(DateTime date) {
    return GestureDetector(
        onTap: () {
          print(date);
        },
        child: Image.asset("assets/icons/confirm.png",
            height: Styles.confirmIconSize, width: Styles.confirmIconSize));
  }
}
