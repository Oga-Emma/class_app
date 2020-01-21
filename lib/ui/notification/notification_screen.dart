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
        body: Center(
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
        ));
  }
}
