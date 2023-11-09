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

  //create base list of week
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
    getMoreNextWeeks();
  }

  DateTime getStartDate(bool isLast) {
    return listOfWeeks.isEmpty
        ? DateTime.now()
        : listOfWeeks[currentWeekIndex].isEmpty
            ? DateTime.now()
            : listOfWeeks[currentWeekIndex][isLast ? 0 : 6];
  }

  //add previous week
  getMorePreviousWeeks() {
    List<DateTime> minus7Days = [];
    DateTime startFrom = getStartDate(true);

    for (int index = 0; index < 7; index++) {
      DateTime minusDate = startFrom.add(Duration(days: -(index + 1)));
      minus7Days.add(minusDate);
    }
    listOfWeeks.add(minus7Days.reversed.toList());
    setState(() {});
  }

  //add next week
  getMoreNextWeeks() {
    for (int i = 0; i < 10; i++) {
      List<DateTime> plus7Days = [];
      DateTime startFrom = getStartDate(false);
      for (int index = 0; index < 7; index++) {
        DateTime plusDate = startFrom.add(Duration(days: (index + 1)));
        plus7Days.add(plusDate);
      }
      listOfWeeks.insert(0, plus7Days.toList());
    }
    setState(() {});
  }

  onDateSelect(DateTime date) {
    setState(() {
      selectedDate = date;
    });
    widget.onDateChange?.call(selectedDate);
  }

  //change current week for other
  onWeekChange(index) {
    currentWeekIndex = index;
    currentWeek = listOfWeeks[currentWeekIndex];
    if (currentWeekIndex + 1 == listOfWeeks.length) {
      getMorePreviousWeeks();
    }

    widget.onWeekChange?.call(currentWeek);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
            carouselController: carouselController,
            items: [
              if (listOfWeeks.isNotEmpty)
                for (int ind = 0; ind < listOfWeeks.length; ind++)
                  Container(
                    margin: EdgeInsets.fromLTRB(20.0.w, 4.0.h, 20.0.w, 0.0.h),
                    height: Styles.oneDayHeight,
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
                                height: Styles.oneDayHeight,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${listOfWeeks[ind][weekIndex].day}",
                                      textAlign: TextAlign.center,
                                      style: numberFromListtextStyle(
                                          ind, weekIndex),
                                    ),
                                    Text(
                                        DateFormat(
                                          'EEE',
                                        ).format(
                                          listOfWeeks[ind][weekIndex],
                                        ),
                                        textAlign: TextAlign.center,
                                        style: dayFromListtextStyle(
                                            ind, weekIndex)),
                                    SizedBox(
                                      height: 12.0.h,
                                    ),
                                    _billet(ind, weekIndex)
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
              initialPage: 10,
              height: Styles.dayListHeight,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              reverse: true,
              onPageChanged: (index, reason) {
                onWeekChange(index);
              },
            )),
        Container(height: 1.0.h, color: Styles.extraLightGrey)
      ],
    );
  }

  Container _billet(int ind, int weekIndex) {
    return Container(
      height: 2.0.h,
      width: Styles.dayFromListWidth,
      decoration: BoxDecoration(
          color: defineBilletColor(ind, weekIndex),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2.0.r),
              topRight: Radius.circular(2.0.r))),
    );
  }

  TextStyle numberFromListtextStyle(int ind, int weekIndex) {
    return TextStyle(
        fontSize: Styles.calendarNumberFontSize,
        fontWeight: FontWeight.w600,
        height: 32.h / 18.sp,
        color: defineColor(ind, weekIndex));
  }

  TextStyle dayFromListtextStyle(int ind, int weekIndex) {
    return TextStyle(
        fontSize: Styles.calendarDayFontSize,
        fontWeight: FontWeight.w500,
        height: 14.h / 10.sp,
        color: defineColor(ind, weekIndex));
  }

  Color defineColor(int ind, int weekIndex) {
    DateTime date = listOfWeeks[ind][weekIndex];
    DateTime now = DateTime.now();
    return DateFormat('dd-MM-yyyy').format(date) ==
            DateFormat('dd-MM-yyyy').format(selectedDate)
        ? Styles.green
        : date.year == now.year &&
                date.month == now.month &&
                date.day == now.day
            ? Styles.orange
            : listOfWeeks[ind][weekIndex].isBefore(DateTime.now())
                ? Styles.lightGrey
                : Styles.textColor;
  }

  Color defineBilletColor(int ind, int weekIndex) {
    DateTime date = listOfWeeks[ind][weekIndex];
    return DateFormat('dd-MM-yyyy').format(date) ==
            DateFormat('dd-MM-yyyy').format(selectedDate)
        ? Styles.green
        : Colors.white;
  }
}
