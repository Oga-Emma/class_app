import 'package:flutter/material.dart';
import 'package:date_utils/date_utils.dart';

class CalendarFixedTile extends StatelessWidget {
  final VoidCallback onDateSelected;
  final DateTime date;
  final String dayOfWeek;
  final bool isDayOfWeek;
  final bool isSelected;
  final bool inMonth;
  final List<Map> events;
  final TextStyle dayOfWeekStyles;
  final TextStyle dateStyles;
  final Widget child;
  final Color selectedColor;
  final Color eventColor;
  final Color eventDoneColor;

  CalendarFixedTile({
    this.onDateSelected,
    this.date,
    this.child,
    this.dateStyles,
    this.dayOfWeek,
    this.dayOfWeekStyles,
    this.isDayOfWeek: false,
    this.isSelected: false,
    this.inMonth: true,
    this.events,
    this.selectedColor,
    this.eventColor,
    this.eventDoneColor,
  });

  Widget renderDateOrDayOfWeek(BuildContext context) {
    if (isDayOfWeek) {
      return new InkWell(
        child: new Container(
          alignment: Alignment.center,
          child: new Text(
            dayOfWeek,
            style: dayOfWeekStyles,
          ),
        ),
      );
    } else {
      int eventCount = 0;
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          onTap: onDateSelected,
          child: Container(
            decoration: isSelected
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    shape: BoxShape.rectangle,
                    color: selectedColor != null
                        ? selectedColor
                        : Theme.of(context).primaryColor,
                  )
                : BoxDecoration(),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  Utils.formatDay(date).toString(),
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: inMonth
                          ? isSelected ? Colors.white : Colors.black
                          : Colors.grey),
                ),
                events != null && events.length > 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: events.map((event) {
                          eventCount++;
                          if (eventCount > 3) return Container();
                          return Container(
                            margin: EdgeInsets.only(
                                left: 2.0, right: 2.0, top: 3.0),
                            width: 6.0,
                            height: 6.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: event['isDone']
                                  ? eventDoneColor ??
                                      Theme.of(context).primaryColor
                                  : eventColor ?? Theme.of(context).accentColor,
                            ),
                          );
                        }).toList())
                    : Container(),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return new InkWell(
        child: child,
        onTap: onDateSelected,
      );
    }
    return new Container(
      child: renderDateOrDayOfWeek(context),
    );
  }
}
