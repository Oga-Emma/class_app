import 'package:class_app/model/event_dto.dart';
import 'package:class_app/model/event_dto.dart';
import 'package:class_app/service/event_dao.dart';
import 'package:class_app/ui/admin/add_edit_event_screen.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:flutter/material.dart';

class EventListItemAdmin extends StatelessWidget {
  EventListItemAdmin(this.event, {this.onTap});
  final EventDTO event;
  final Function(EventDTO event) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ColorUtils.accentColor.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(16.0)
      ),
      child: InkWell(
        onTap: (){
          onTap(event);
        },
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  event.courseId,
                  style: Theme.of(context).textTheme.title.copyWith(
                      color: ColorUtils.primaryColor),
                ),
                Expanded(child: SizedBox()),
                FlatButton.icon(onPressed: () async {
                  bool delete = await showDialog<bool>(context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Delete Event"),
                        content: Text("Are you sure?\nThis aciton cannot be undone"),
                        actions: <Widget>[
                          FlatButton(onPressed: () => Navigator.of(context).pop(false), child: Text("Cancel")),
                          FlatButton(onPressed: () => Navigator.of(context).pop(true), child: Text("Delete"))
                        ],
                      )
                  ) ?? false;

                  if(delete){
                    EventDAO.deleteEvent(event, (success){});
                  }
                },
                    icon: Icon(Icons.delete, size: 14,),
                    label: Text("Delete")),
                FlatButton.icon(onPressed: (){
                  Navigator.of(context)
                      .push(
                      MaterialPageRoute(
                          builder: (context) => AddEditEvent(event))
                  );
                },
                    icon: Icon(Icons.edit, size: 14,),
                    label: Text("Edit"))
              ],
            ),
            gap,
            Text(
              event.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .body2
                  .copyWith(
                  color: Colors.black
                      .withOpacity(0.5)),
            ),
            gap,
           Container(height: 1, color: Colors.grey.withOpacity(0.3),
             margin: EdgeInsets.symmetric(vertical: 8.0),
           ),
            Row(
              children: <Widget>[
                Text("DATE: ${event.date}",
                  style: Theme.of(context)
                      .textTheme
                      .caption,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Expanded(child: SizedBox()),
                Text("TIME: ${event.time}",
                  style: Theme.of(context)
                      .textTheme
                      .caption,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                )
              ],
            )
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
