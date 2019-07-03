import 'package:class_app/ui/list_items/lecture_list_item.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/widgets/defaultAppBar.dart';
import 'package:flutter/material.dart';

class Classes extends StatefulWidget {
  @override
  _ClassesState createState() => _ClassesState();
}

class _ClassesState extends State<Classes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar('Classes', elevation: 0.0),
      body: Container(
        color: Colors.grey.withOpacity(0.3),
        child: Column(
          children: <Widget>[
            Material(
              elevation: 4.0,
              child: Container(
//              padding: EdgeInsets.only(top: 8.0),
//              height: 50.0,
//              color: Theme.of(context).primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    getDay('Sun', '4'),
                    getDay('Mon', '14'),
                    getDay('Tue', '4'),
                    getDay('Wed', '24'),
                    getDay('Thur', '4'),
                    getDay('Fri', '4', selected: true),
                    getDay('Sat', '4'),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return LectureListItem();
                  }),
            ))
          ],
        ),
      ),
    );
  }

  getDay(String dayOfWeek, String date, {bool selected = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          color: selected ? Theme.of(context).primaryColor : null,
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Column(
        children: <Widget>[
          Text(
            dayOfWeek,
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: selected ? Colors.white : null,
                ),
          ),
          Text(
            date,
            style: Theme.of(context).textTheme.subhead.copyWith(
                  color: selected ? Colors.white : null,
                ),
          ),
        ],
      ),
    );
  }
}
