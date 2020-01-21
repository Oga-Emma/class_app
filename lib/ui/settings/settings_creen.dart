import 'package:class_app/ui/widgets/empty_space.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Preferences')),
        body: Container(
          child: Column(
            children: <Widget>[
              emptySpace(),
              Card(
                child: ListTile(
                  title: Text('Upcoming event reminder'),
                  subtitle: Text('Notify me of upcoming events'),
                  dense: true,
                  trailing:
                      Switch(value: true, onChanged: _notifyUpcomingEvent),
                ),
              )
            ],
          ),
        ));
  }

  void _notifyUpcomingEvent(bool value) {

  }
}
