import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/widgets/defaultAppBar.dart';
import 'package:flutter/material.dart';

class Today extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar('Today', elevation: 0.0),
      body: Container(
        color: Colors.grey.withOpacity(0.3),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: ListView.builder(
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 150.0,
                      child: Container(
                        margin: EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.indeterminate_check_box,
                                        size: 16.0, color: Colors.green),
                                    gap,
                                    Text(
                                      "LECTURE",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                    Expanded(child: SizedBox()),
                                    Icon(Icons.access_time,
                                        size: 16.0,
                                        color: Theme.of(context).accentColor),
                                    gap,
                                    Text(
                                      "12:00 PM",
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                gap,
                                Text(
                                  "COS 205",
                                  style: Theme.of(context).textTheme.title,
                                ),
                                gap,
                                Expanded(
                                  child: Text(
                                    "Assignment due for submission",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .body2
                                        .copyWith(
                                            color:
                                                Colors.black.withOpacity(0.5)),
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
                                        style:
                                            Theme.of(context).textTheme.caption,
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
