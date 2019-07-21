import 'package:class_app/model/date_event.dart';
import 'package:class_app/model/event_dto.dart';
import 'package:class_app/model/lecture_dto.dart';
import 'package:class_app/ui/event/event_details_screen.dart';
import 'package:class_app/ui/lecture/lecture_details_screen.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:flutter/material.dart';

class CalendarEventListItem extends StatelessWidget {
  CalendarEventListItem(this.dateEvent);
  final DateEvent dateEvent;

  @override
  Widget build(BuildContext context) {
    var isLecture = dateEvent is LectureDTO;
    var color = getColor(isLecture
        ? EventType.LECTURES
        : (dateEvent as EventDTO).type.toUpperCase());

    return Container(
        padding: const EdgeInsets.all(12.0),
        child: Material(
          borderRadius: BorderRadius.circular(8.0),
          elevation: 4.0,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => isLecture
                      ? LectureDetailsScreen(lecture: dateEvent as LectureDTO)
                      : EventDetailsScreen(event: dateEvent as EventDTO)));
            },
            child: Container(
              padding: EdgeInsets.only(right: 16.0),
              height: 120,
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0)),
                    child: Container(width: 5, color: color),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        emptySpace(),
                        getCheck(
                            color: color,
                            isCheck: DateTime.now().millisecondsSinceEpoch >
                                dateEvent.timeStamp),
                        emptySpace(),
                        Text(
                          "${isLecture ? '${(dateEvent as LectureDTO).startTime}\n${(dateEvent as LectureDTO).startTime}' : (dateEvent as EventDTO).time}",
                          style: Theme.of(context).textTheme.caption,
                        ),
                        emptySpace(multiple: 2),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              "${isLecture ? '${(dateEvent as LectureDTO).course.title} - Lecture' : (dateEvent as EventDTO).title}"
                                  .toUpperCase(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(fontSize: 16),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 8),
                              width: double.maxFinite,
                              height: 0.5,
                              color: color.withOpacity(0.5),
                            ),
                            Text(
                                "Venue: ${isLecture ? '${(dateEvent as LectureDTO).venue}' : (dateEvent as EventDTO).venue}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.body2),
                          ],
                        )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  getCheck({isCheck = true, color = Colors.orange}) {
    return Container(
      margin: EdgeInsets.all(8.0),
      height: 24,
      width: 24,
      decoration: isCheck
          ? BoxDecoration(color: color, borderRadius: BorderRadius.circular(15))
          : BoxDecoration(
              border: Border.all(color: color, width: 2),
              borderRadius: BorderRadius.circular(15)),
      child: isCheck
          ? Icon(
              Icons.check,
              size: 16,
              color: Colors.white,
            )
          : SizedBox(),
    );
  }

  Color getColor(String s) {
    return eventColors[s];
  }
}
