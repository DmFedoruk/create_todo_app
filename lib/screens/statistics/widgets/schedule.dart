import 'package:create_todo_app/scoped_models/scoped_statistic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../styles/styles.dart';

class Schedule extends StatelessWidget {
  const Schedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Styles.scheduleHeight,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: ScopedModelDescendant<ScopedStatistic>(
        builder: (context, child, model) => Stack(
          fit: StackFit.loose,
          children: [listOfLines(), listOfTypes(model)],
        ),
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

  Widget listOfTypes(ScopedStatistic model) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 8.0.h),
        itemBuilder: (context, index) {
          return taskType(model.allLength[index], model.realLength[index],
              Styles.colorsList[index]);
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 12.0.h);
        },
        itemCount: Styles.colorsList.length);
  }

  Widget taskType(double allLength, double realLength, Color color) {
    return Stack(
      children: [
        line(allLength, color.withOpacity(0.16)),
        line(realLength, color),
      ],
    );
  }

  Container line(double length, Color color) {
    return Container(
      height: Styles.taskTypeHeight,
      width: length.isNaN ? 0 : length,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(Styles.dashItemLength)),
    );
  }
}
