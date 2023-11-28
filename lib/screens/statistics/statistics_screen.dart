import 'package:create_todo_app/scoped_models/scoped_statistic.dart';
import 'package:create_todo_app/screens/statistics/widgets/count_and_percent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../styles/styles.dart';
import '../../styles/text_string.dart';
import 'widgets/schedule.dart';
import 'widgets/toggle_button.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScopedStatistic statisticManager = ScopedStatistic();
    statisticManager.calculateStatistics();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: Styles.extraLightGrey,
              height: 1.0,
            )),
        leadingWidth: Styles.statisticLeadingWidth,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/arrow_back.png',
                  height: Styles.backButtonSize,
                ),
                Text(
                  TextString.statistics,
                  style: Styles.statisticScreenTitle,
                )
              ],
            )),
      ),
      body: Container(
        color: Colors.white,
        child: ScopedModel<ScopedStatistic>(
          model: statisticManager,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Column(children: [
              SizedBox(height: 12.0.h),
              const ToggleButton(),
              SizedBox(height: 16.0.h),
              const CountAndPercent(),
              SizedBox(height: 20.0.h),
              const Schedule()
            ]),
          ),
        ),
      ),
    );
  }
}
