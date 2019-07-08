import 'package:class_app/model/date_event.dart';
import 'package:class_app/model/event_dto.dart';
import 'package:class_app/model/event_dto.dart';
import 'package:class_app/model/lecture_dto.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/decoration_utils.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CombinedListItemUser extends StatelessWidget {
  CombinedListItemUser(this.event, {this.onTap});
  final DateEvent event;
  final Function(DateEvent event) onTap;

  static var dateFormat = DateFormat('EEEE, dd-MMM-yyyy');
  static var timeFormat = DateFormat('hh:mm');
  static var timeOfDayFormat = DateFormat('a');
  var lightGrey = ColorUtils.primaryColor.withOpacity(0.8);//Colors.grey[300];

  @override
  Widget build(BuildContext context) {
    return event is EventDTO ? eventView(context, event) : lectureView(context, event);
  }

  Widget eventView(BuildContext context, EventDTO event){
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 4.0, horizontal: 8.0),
      child: InkWell(
        onTap: (){
          onTap(event);},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[

                Text(timeFormat.format(DateTime.parse("2019-02-27 ${event.time}")),
                  style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w700, fontSize: 20, color: lightGrey),),
                Text(timeOfDayFormat.format(DateTime.parse("2019-02-27 ${event.time}")),
                  style: TextStyle(color: Colors.grey[800]),),
              ],
            ),
            gap,
            Column(
              children: <Widget>[
                SizedBox(height: 6),
                Icon(Icons.add_circle, size: 12, color: lightGrey,),
                gap,
                Container(width: 1, height: 90, color: lightGrey,
                  margin: EdgeInsets.symmetric(horizontal: 10),)
              ],
            ),
            gap,
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${event.courseId.isEmpty ? '' : event.courseId + ' - '}${event.title}",
                      style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w700,
                          fontSize: 18, color: lightGrey),
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${event.description}",
                      style: Theme.of(context).textTheme.display1
                          .copyWith(fontSize: 14, color: Colors.grey[800]),
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                    gap2x,
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: ColorUtils.primaryColor,
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            event.venue,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .caption.copyWith(color: Colors.grey[800]),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget lectureView(BuildContext context, LectureDTO event){
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 4.0, horizontal: 8.0),
      child: InkWell(
        onTap: (){
          onTap(event);},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[

                Text(timeFormat.format(DateTime.parse("2019-02-27 ${event.startTime}")),
                  style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w700, fontSize: 20, color: lightGrey),),
                Text(timeOfDayFormat.format(DateTime.parse("2019-02-27 ${event.startTime}")),
                  style: TextStyle(color: Colors.grey[800]),),
              ],
            ),
            gap,
            Column(
              children: <Widget>[
                SizedBox(height: 6),
                Icon(Icons.add_circle, size: 12, color: lightGrey,),
                gap,
                Container(width: 1, height: 90, color: Colors.grey[800],
                  margin: EdgeInsets.symmetric(horizontal: 10),)
              ],
            ),
            gap,
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${event.course.code}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.display1.copyWith(fontWeight: FontWeight.w700,
                          fontSize: 20, color: lightGrey),
                    ),
                    Text(
                      "Lecture",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.display1.copyWith(fontSize: 16, color: Colors.grey[800]),
                    ),
                    gap2x,
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: lightGrey,
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            event.venue,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .caption.copyWith(color: Colors.grey[800]),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
