import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../styles/styles.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Styles.scheduleHeight,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Stack(
        fit: StackFit.loose,
        children: [listOfLines(), listOfTypes()],
      ),
    );
  }

  Widget listOfLines() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [dash(), dash(), dash(), dash(), dash(), dash(), dash()]),
    );
  }

  Widget dash() {
    return Dash(
        direction: Axis.vertical,
        length: Styles.scheduleHeightWithPadding,
        dashLength: Styles.dashItemLength,
        dashColor: Styles.extraLightGrey);
  }

  Widget listOfTypes() {
    return ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8.0.h),
        itemBuilder: (context, index) {
          return taskType(Styles.colorsList[index]);
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 12.0.h);
        },
        itemCount: Styles.colorsList.length);
  }

  Widget taskType(Color color) {
    return Stack(
      children: [
        line(200, color.withOpacity(0.16)),
        line(130, color),
      ],
    );
  }

  Container line(double length, Color color) {
    return Container(
      height: Styles.taskTypeHeight,
      width: length,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(Styles.dashItemLength)),
    );
  }
}
