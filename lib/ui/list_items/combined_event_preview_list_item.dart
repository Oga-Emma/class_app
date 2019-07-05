import 'package:class_app/model/date_event.dart';
import 'package:class_app/model/event_dto.dart';
import 'package:class_app/model/event_dto.dart';
import 'package:class_app/model/lecture_dto.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/decoration_utils.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:flutter/material.dart';

class CombinedPreviewEventListItem extends StatelessWidget {
  CombinedPreviewEventListItem(this.event, {this.onTap, this.isLecture = false});
  final DateEvent event;
  final isLecture;
  final Function(DateEvent event) onTap;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(
          right: 8.0, top: 8.0, bottom: 8.0),
      padding: EdgeInsets.all(4.0),
      child: Material(
        elevation: 4.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: borderRadius),
        child: InkWell(
          onTap: (){
            if(onTap != null) {
              onTap(event);
            }
          },
          child: Container(
            padding: EdgeInsets.all(16.0),
            width: 280,
//                                height: 50,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.watch_later,
                        color: Colors.grey, size: 14.0),
                    SizedBox(width: 5),
                    Text(
                      isLecture ? "${(event as LectureDTO).startTime} - ${(event as LectureDTO).endTime}" : "${(event as EventDTO).time}",
                      style: Theme.of(context)
                          .textTheme
                          .caption,
                    ),
                    Expanded(child: SizedBox()),
                    SizedBox(width: 5),
                    Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: eventColors[isLecture ? EventType.LECTURES : (event as EventDTO).type].withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: Text(
                        isLecture ? "LECTURE" : "${(event as EventDTO).type}",
                        style: Theme.of(context)
                            .textTheme
                            .caption.copyWith(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        isLecture ? "${(event as LectureDTO).courseCode}" : "${(event as EventDTO).title}",
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style:
                        Theme.of(context).textTheme.subhead,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.near_me,
                        color: Colors.grey, size: 14.0),
                    SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        isLecture ? "${(event as LectureDTO).venue}" : "${(event as EventDTO).venue}",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .caption,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
