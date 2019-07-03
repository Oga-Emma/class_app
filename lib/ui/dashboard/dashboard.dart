import 'package:class_app/ui/admin/admin_screen.dart';
import 'package:class_app/ui/dashboard/lectures.dart';
import 'package:class_app/ui/dashboard/today.dart';
import 'package:class_app/ui/utils/decoration_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: GestureDetector(onHorizontalDragEnd: (details){
//            print("Drag happened");
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminScreen()));
          }, child: Text("Dashboard", textAlign: TextAlign.center)),
          elevation: 0.0),
      body: Container(
          color: Colors.grey[200],
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 100.0),
                child: _body(),
              ),
              Positioned(top: 0, right: 0, left: 0, child: _topBar()),
            ],
          )),
    );
  }

  Widget category(title, color, icon, {Function() onTap}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 2.0,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        child: ClipRect(
          child: InkWell(
            onTap: onTap,
            child: Container(
//                              height: 70,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(icon, color: color, size: 16.0),
                        SizedBox(height: 8.0),
                        Text(title, style: Theme.of(context).textTheme.subhead)
                      ],
                    ),
                  ),
                  Container(height: 4, color: color)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return Stack(
      children: <Widget>[
        /* Container(
          height: 80,
          color: Colors.transparent,
//            color: Theme.of(context).scaffoldBackgroundColor
        ),*/
        Container(height: 40, color: Theme.of(context).primaryColor),
        Container(
          height: 80,
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: Offset(1, 5),
                color: Colors.grey,
                blurRadius: 20,
                spreadRadius: 1)
          ], color: Colors.white, borderRadius: borderRadius),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // This next line does the trick.
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("100L",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("1ST SEMS",
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w300))
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("16",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text("MAY, 2019",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w300))
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("08",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("TODAY",
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w300))
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _body() {
    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate(<Widget>[
          Container(
            padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
            alignment: Alignment.centerLeft,
            height: 220,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("TODAY'S TIMELINE",
                              style: Theme.of(context).textTheme.caption),
                          SizedBox(height: 3),
                          Text("Mon, Oct 22, 2018",
                              style: Theme.of(context).textTheme.subhead),
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      RaisedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Today();
                            }));
                          },
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: borderRadius),
                          child: Text("View all",
                              style: TextStyle(color: Colors.white)))
                    ],
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                right: 8.0, top: 8.0, bottom: 8.0),
                            padding: EdgeInsets.all(4.0),
                            child: Material(
                              elevation: 4.0,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                  borderRadius: borderRadius),
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                width: 280,
//                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: borderRadius,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.watch_later,
                                            color: Colors.grey, size: 14.0),
                                        SizedBox(width: 5),
                                        Text(
                                          "04-4:30PM",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                        Expanded(child: SizedBox()),
                                        Icon(Icons.play_circle_filled,
                                            color: Colors.green, size: 10.0),
                                        SizedBox(width: 5),
                                        Text(
                                          "ONGOING",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "CS4512 -  Theory of Computation Theory of Computation",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          Theme.of(context).textTheme.subhead,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.near_me,
                                            color: Colors.grey, size: 14.0),
                                        SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            "PHYSICAL SCIENCES LECTURE THEATRE",
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
                          );
                        }))
              ],
            ),
          ),
        ])),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 6 / 5,
            ),
            delegate: SliverChildListDelegate(<Widget>[
              category(
                  "Classes", Colors.red, FontAwesomeIcons.chalkboardTeacher,
                onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Lectures()));
                }
              ),
              category("Fixed Class", Colors.red, Icons.library_books,
                  onTap: (){}
              ),
              category("Assignment", Colors.red, FontAwesomeIcons.twitch,
                  onTap: (){}
              ),
              category(
                  "Test", Theme.of(context).primaryColor, FontAwesomeIcons.tasks,
                  onTap: (){}
              ),
              category("Exam", Colors.red, FontAwesomeIcons.clipboardList,
                  onTap: (){}
              ),
              category("Class excos", Colors.red, FontAwesomeIcons.users,
                  onTap: (){}
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
