import 'package:carousel_slider/carousel_slider.dart';
import 'package:create_todo_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HorizontalWeekCalendar extends StatefulWidget {
  final Function(DateTime)? onDateChange;
  final Function(List<DateTime>)? onWeekChange;

  const HorizontalWeekCalendar({
    super.key,
    this.onDateChange,
    this.onWeekChange,
  });

  @override
  State<HorizontalWeekCalendar> createState() => _HorizontalWeekCalendarState();
}

class _HorizontalWeekCalendarState extends State<HorizontalWeekCalendar> {
  CarouselController carouselController = CarouselController();

  DateTime today = DateTime.now();
  DateTime selectedDate = DateTime.now();
  List<DateTime> currentWeek = [];
  int currentWeekIndex = 0;

  List<List<DateTime>> listOfWeeks = [];

  @override
  void initState() {
    initCalender();
    super.initState();
  }

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  initCalender() {
    final date = DateTime.now();

    DateTime startOfCurrentWeek =
        getDate(date.subtract(Duration(days: date.weekday - 1)));

    currentWeek.add(startOfCurrentWeek);
    for (int index = 0; index < 6; index++) {
      DateTime addDate = startOfCurrentWeek.add(Duration(days: (index + 1)));
      currentWeek.add(addDate);
    }

    listOfWeeks.add(currentWeek);

    getMorePreviousWeeks();
  }

  getMorePreviousWeeks() {
    List<DateTime> minus7Days = [];
    DateTime startFrom = listOfWeeks.isEmpty
        ? DateTime.now()
        : listOfWeeks[currentWeekIndex].isEmpty
            ? DateTime.now()
            : listOfWeeks[currentWeekIndex][0];

    for (int index = 0; index < 7; index++) {
      DateTime minusDate = startFrom.add(Duration(days: -(index + 1)));
      minus7Days.add(minusDate);
    }
    // List<DateTime> plus7Days = [];
    // for (int index = 0; index < 7; index++) {
    //   DateTime plusDate = startFrom.add(Duration(days: (index + 1)));
    //   plus7Days.add(plusDate);
    // }
    listOfWeeks.add(minus7Days.reversed.toList());
    //listOfWeeks.add(plus7Days.reversed.toList());
    setState(() {});
  }

  onDateSelect(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    widget.onDateChange?.call(selectedDate);
  }

  onWeekChange(index) {
    currentWeekIndex = index;
    currentWeek = listOfWeeks[currentWeekIndex];

    if (currentWeekIndex + 1 == listOfWeeks.length) {
      getMorePreviousWeeks();
    } else {}

    widget.onWeekChange?.call(currentWeek);
    setState(() {});
  }

  // =================

  isNextDisabled() {
    return listOfWeeks[currentWeekIndex].last.isBefore(DateTime.now());
  }

  isCurrentYear() {
    return DateFormat('yyyy').format(currentWeek[0]) ==
        DateFormat('yyyy').format(today);
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        carouselController: carouselController,
        items: [
          if (listOfWeeks.isNotEmpty)
            for (int ind = 0; ind < listOfWeeks.length; ind++)
              Container(
                margin: EdgeInsets.fromLTRB(20.0.w, 4.0.h, 20.0.w, 0.0.h),
                height: Styles.dayFromListHeight,
                child: Row(
                  children: [
                    for (int weekIndex = 0;
                        weekIndex < listOfWeeks[ind].length;
                        weekIndex++)
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            onDateSelect(
                              listOfWeeks[ind][weekIndex],
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FittedBox(
                                  child: Text(
                                    "${listOfWeeks[ind][weekIndex].day}",
                                    textAlign: TextAlign.center,
                                    style: dayFromListtextStyle(ind, weekIndex),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                    DateFormat(
                                      'EEE',
                                    ).format(
                                      listOfWeeks[ind][weekIndex],
                                    ),
                                    textAlign: TextAlign.center,
                                    style:
                                        dayFromListtextStyle(ind, weekIndex)),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
        ],
        options: CarouselOptions(
          scrollPhysics: const ClampingScrollPhysics(),
          height: Styles.dayFromListHeight,
          viewportFraction: 1,
          enableInfiniteScroll: false,
          reverse: true,
          onPageChanged: (index, reason) {
            onWeekChange(index);
          },
        ));
  }

  TextStyle dayFromListtextStyle(int ind, int weekIndex) {
    return TextStyle(
      color: DateFormat('dd-MM-yyyy').format(listOfWeeks[ind][weekIndex]) ==
              DateFormat('dd-MM-yyyy').format(selectedDate)
          ? Styles.green
          : listOfWeeks[ind][weekIndex] == DateTime.now()
              ? Styles.orange
              : listOfWeeks[ind][weekIndex].isBefore(DateTime.now())
                  ? Styles.lightGrey
                  : Styles.textColor,
      fontWeight: FontWeight.bold,
    );
  }
}
