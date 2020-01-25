import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Notifications')),
        body: Container(
          color: Colors.grey[200],
          child: ListView.builder(itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Material(
                borderRadius: BorderRadius.circular(8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('COS 303 Lecture postponed',
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(fontSize: 16)),
                      EmptySpace(multiple: 0.4),
                      Text(
                        'COS 303 Lecture has been postponed to next week',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      EmptySpace(),
                      Divider(),
                      Text('Today | 3:00PM',
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .copyWith(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            );
          }),
        ));
  }

  get noNotification => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset("assets/svg/no_notification.svg",
                width: 100, height: 100),
            emptySpace(),
            Text("No Notification",
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .copyWith(fontSize: 20)),
            Text("New sotifications will appear here"),
            emptySpace(multiple: 2),
          ],
        ),
      );
}
