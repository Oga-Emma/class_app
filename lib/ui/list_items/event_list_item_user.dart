import 'package:class_app/model/event_dto.dart';
import 'package:class_app/model/event_dto.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/decoration_utils.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventListItemUser extends StatelessWidget {
  EventListItemUser(this.event, {this.onTap});
  final EventDTO event;
  final Function(EventDTO event) onTap;

  static var dateFormat = DateFormat('EEEE, dd-MMM-yyyy');
  static var timeFormat = DateFormat('hh:mm a');

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 16.0, horizontal: 16.0),
      child: Material(
          elevation: 8.0,
          borderRadius: BorderRadius.circular(16.0),
          child: InkWell(
            onTap: (){
              onTap(event);

              },
            child: Container(
              padding: const EdgeInsets.all(16.0),
//              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: eventColors[event.type],
                            borderRadius: borderRadius),
                        padding: EdgeInsets.all(8.0),
                        child: Text(event.type,
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white)),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                  gap2x,
                  Text(
                    "${event.courseCode.isEmpty ? '' : event.courseCode + ' - '}${event.title}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline.copyWith(fontSize: 18),
                  ),

                  Container(
                    height: 1,
                    color: Colors.grey.withOpacity(0.5),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                  ),

                  Text(
                    "${event.description}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  gap2x,
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                        size: 20,
                        color: ColorUtils.accentColor,
                      ),
                      SizedBox(width: 5),
                      Text(
                        dateFormat.format(DateTime.parse(event.date)),
                        style: Theme.of(context)
                            .textTheme
                            .caption,
                      ),
                      Expanded(child: SizedBox()),
                      Icon(
                        Icons.timer,
                        size: 20,
                        color: ColorUtils.accentColor,
                      ),
                      SizedBox(width: 5),
                      Text(
                        timeFormat.format(DateTime.parse("2019-02-27 ${event.time}")),
                        style: TextStyle(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
