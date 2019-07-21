import 'dart:async';

import 'package:class_app/ui/list_items/lecture_list_item.dart';
import 'package:class_app/ui/shared/LectureListBuilder.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/widgets/defaultAppBar.dart';
import 'package:flutter/material.dart';

class Lectures extends StatefulWidget {
  @override
  _LecturesState createState() => _LecturesState();
}

class _LecturesState extends State<Lectures> {

  PageController controller = PageController();
  int selectedDate;
  DateTime date = DateTime.now();
  List<DaysAndDates> daysAndDates = [];

  @override
  void initState() {
    print("today is => ${date.weekday}");
    print("today's Date is => ${date.day}");


    var today = date.weekday;
    var todayDate = date.day;

    selectedDate = today;
    if(today == 7) {
      selectedDate = 0;
    }
    var mondayDate = todayDate - (today - 1);
    print("Monday date => $mondayDate");

    var isLeapYear = date.month != DateTime.february ? false : (date.year % 4 == 0 && date.year % 100 != 0 && date.year % 400 ==0);

    daysAndDates.add(DaysAndDates(1, "Mon", mondayDate));
    daysAndDates.add(DaysAndDates(2, "Tue", getNextDate(mondayDate + 1,
        getDaysInMonth(date.month, isLeapYear: isLeapYear))));
    daysAndDates.add(DaysAndDates(3, "Wed", getNextDate(mondayDate + 2,
        getDaysInMonth(date.month, isLeapYear: isLeapYear))));
    daysAndDates.add(DaysAndDates(4, "Thur", getNextDate(mondayDate + 3,
        getDaysInMonth(date.month, isLeapYear: isLeapYear))));
    daysAndDates.add(DaysAndDates(5, "Fri", getNextDate(mondayDate + 4,
        getDaysInMonth(date.month, isLeapYear: isLeapYear))));
    daysAndDates.add(DaysAndDates(6, "Sat", getNextDate(mondayDate + 5,
        getDaysInMonth(date.month, isLeapYear: isLeapYear))));
    daysAndDates.add(DaysAndDates(6, "Sun", getNextDate(mondayDate + 6,
        getDaysInMonth(date.month, isLeapYear: isLeapYear))));

    super.initState();
  }

  int getNextDate(int current, int totalDaysInMonth){
    if(current == totalDaysInMonth){
      return 1;
    }
    return current % totalDaysInMonth;
  }

  int getDaysInMonth(int month, {bool isLeapYear = false}){
    switch(month){
      case DateTime.february: return isLeapYear ? 29 : 28;
      case DateTime.april:
      case DateTime.june:
      case DateTime.september:
      case DateTime.november: return 30;
      default: return 31;
    }
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      initialIndex: selectedDate,
      length: 7,
      child: Scaffold(
        appBar: AppBar(
          title: Text("LECTURES"),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),//Size.fromHeight(kToolbarHeight),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0)
                ),
                  height: 46.0,
                  child: TabBar(
                    unselectedLabelColor: Colors.white,
                    /*indicator: BoxDecoration(
                        color: ColorUtils.accentColor,
                        borderRadius: BorderRadius.circular(16)

                    ),*/
                    isScrollable: true,
                    tabs: ["Sun", "Mon", "Tue", "Wed", "Thur", "Fri", "Sat"].map((str) => Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        str, style: TextStyle(fontSize: 15.0, color: ColorUtils.primaryColor),
                      ),
                    ),).toList(),
                  ),)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TabBarView(
            children: [
              LectureListBuilder(day: 7),
              LectureListBuilder(day: 1),
              LectureListBuilder(day: 2),
              LectureListBuilder(day: 3),
              LectureListBuilder(day: 4),
              LectureListBuilder(day: 5),
              LectureListBuilder(day: 6),
            ],
          ),
        ),
      ),
    );

//    return Scaffold(
//      appBar: DefaultAppBar('Classes', elevation: 0.0),
//      body: Container(
//        color: Colors.grey.withOpacity(0.3),
//        child: Column(
//          children: <Widget>[
//            Material(
//              elevation: 4.0,
//              child: Container(
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceAround,
//                  children: daysAndDates.map(
//                          (dayTime) => getDay(dayTime.dayOfWeek, dayTime.day,
//                              dayTime.date,
//                          selected: dayTime.dayOfWeek == selectedDate
//                          )).toList()
//                ),
//              ),
//            ),
//            Expanded(
//                child: Padding(
//              padding:
//                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
//              child: PageView.builder(
//                controller: controller,
//                onPageChanged: (position){
//                  setState(() {
//                    selectedDate = position + 1;
//                  });
//                },
//                itemBuilder: (context, position) {
//
//                 /* if(selectedDate - 1 != position) {
//                    Future.delayed(Duration.zero, () {
//                      setState(() {
//                        selectedDate = position + 1;
//                      });
//                    });
//                  }*/
//                  return LectureListBuilder(day: position + 1);
//                },
//                itemCount: 6, // Can be null
//              )
//            ))
//          ],
//        ),
//      ),
//    );
  }

  Widget getDay(int dayOfWeek, String dayText, int date, {bool selected = false}) {
    return InkWell(
      onTap: (){
        setState(() {
          selectedDate = dayOfWeek;
        });
        controller.animateToPage(selectedDate - 1, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            color: selected ? Theme.of(context).primaryColor : null,
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: Column(
          children: <Widget>[
            Text(
              dayText,
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: selected ? Colors.white : null,
                  ),
            ),
            Text(
              date.toString(),
              style: Theme.of(context).textTheme.subhead.copyWith(
                    color: selected ? Colors.white : null,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class DaysAndDates{
  int dayOfWeek;
  String day;
  int date;

  DaysAndDates(this.dayOfWeek, this.day, this.date);
}
