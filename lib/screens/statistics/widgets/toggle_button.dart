import 'package:create_todo_app/scoped_models/scoped_statistic.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../styles/styles.dart';

class ToggleButton extends StatelessWidget {
  const ToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ScopedStatistic>(
      builder: (context, child, model) => Container(
          alignment: Alignment.center,
          height: Styles.togglePlugHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(Styles.toggleButtonCorners)),
              color: Styles.checkboxColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
                Styles.listOfPeriod.length,
                (index) => GestureDetector(
                      onTap: () {
                        model.changePoint(index);
                      },
                      child: item(Styles.listOfPeriod[index],
                          model.selectedPoint[index]),
                    )),
          )),
    );
  }

  Widget item(String text, bool isActive) {
    return Container(
        height: Styles.toggleButtonHeight,
        width: Styles.toggleButtonWidth,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isActive ? Colors.white : Styles.checkboxColor,
            borderRadius: BorderRadius.circular(Styles.toggleButtonCorners)),
        child: Text(text,
            style: isActive
                ? Styles.toggleButtonActive
                : Styles.toggleButtonUnActive));
  }
}
