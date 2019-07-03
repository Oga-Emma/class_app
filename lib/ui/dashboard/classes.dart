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
                    return Container(
                      height: 150.0,
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                "08:00 AM",
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 12.0),
                              ),
                              Text(
                                "10:00 AM",
                                style: Theme.of(context)
                                    .textTheme
                                    .subhead
                                    .copyWith(fontSize: 12.0),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                      width: 1.0,
                                      height: double.infinity,
                                      color: Colors.grey.withOpacity(0.5)),
                                ),
                                Icon(Icons.check_box_outline_blank,
                                    size: 16.0,
                                    color: Theme.of(context).primaryColor),
                                Expanded(
                                  child: Container(
                                      width: 1.0,
                                      height: double.infinity,
                                      color: Colors.grey.withOpacity(0.5)),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              child: Container(
                            margin: EdgeInsets.symmetric(vertical: 16.0),
                            child: Material(
                              elevation: 2.0,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0)),
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      "COS 205",
                                      style: Theme.of(context).textTheme.title,
                                    ),
                                    gap,
                                    Expanded(
                                      child: Text(
                                        "Introduction to Computer Science",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .body2
                                            .copyWith(
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                      ),
                                    ),
                                    gap,
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.near_me,
                                          size: 18,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        gap,
                                        Expanded(
                                          child: Text(
                                            "Room 412, Abuja Building, Room 412, Abuja Building, Room 412, Abuja Building",
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                            ),
                          ))
                        ],
                      ),
                    );
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
