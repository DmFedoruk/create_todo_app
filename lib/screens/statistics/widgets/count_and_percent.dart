import 'package:create_todo_app/scoped_models/scoped_statistic.dart';
import 'package:create_todo_app/styles/text_string.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../styles/styles.dart';

class CountAndPercent extends StatelessWidget {
  const CountAndPercent({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ScopedStatistic>(
      builder: (context, child, model) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          count('${model.completedTasks}', '/${model.allTasks}',
              TextString.taskCompleted),
          count('${model.completedPercent}', '%', TextString.completionRate)
        ],
      ),
    );
  }

  Widget count(String firstText, String secondText, String description) {
    return SizedBox(
      height: Styles.countAndPercentHeigth,
      width: Styles.countAndPercentWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(firstText, style: Styles.countNumberStyle),
              Text(secondText, style: Styles.countTextStyle)
            ],
          ),
          Text(description, style: Styles.countDescriptionStyle)
        ],
      ),
    );
  }
}
