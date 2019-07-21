import 'dart:async';

import 'package:class_app/model/date_event.dart';
import 'package:class_app/model/event_dto.dart';
import 'package:class_app/model/lecture_dto.dart';
import 'package:class_app/service/event_dao.dart';
import 'package:class_app/service/lecture_dao.dart';
import 'package:class_app/ui/admin/admin_screen.dart';
import 'package:class_app/ui/dashboard/lectures.dart';
import 'package:class_app/ui/dashboard/today.dart';
import 'package:class_app/ui/event/event_details_screen.dart';
import 'package:class_app/ui/lecture/lecture_details_screen.dart';
import 'package:class_app/ui/list_items/combined_event_preview_list_item.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/decoration_utils.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'class_excos_screen.dart';
import 'courses.dart';
import 'events_screen.dart';


class Dashboard extends StatefulWidget {
  Dashboard(this.calendarScreen);
  final Function() calendarScreen;
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  var monthYear;
  var dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    var date = DateTime.now();
    monthYear = DateFormat("EEEE, MMM dd, yyyy").format(date);

    super.initState();
  }

  var todayEvents = <EventDTO>[];
  var todayLectures = <LectureDTO>[];
  var checked = false;

  @override
  Widget build(BuildContext context) {
    refresh();
    return Scaffold(
      appBar: AppBar(
          title: GestureDetector(
              onHorizontalDragEnd: (details)  {
//            print(details.primaryVelocity);
//            print(details.velocity);

          if(details.primaryVelocity > 500){
            showPasswordDialog();
          }
//            print("Drag happened");
//            showPasswordDialog();

          },

              onDoubleTap: (){
                showPasswordDialog();
              },

              child: Text("Dashboard", textAlign: TextAlign.center)),
          elevation: 0.0),
      body:


      StreamBuilder<QuerySnapshot>(
          stream: lectureStream,
          builder: (context, lecturesStream){
//
//            if(!checked) {
//              checkForNewVersion();
//              checked = true;
//            }

        if(lecturesStream.hasData){
          todayLectures.clear();

          lecturesStream.data.documents.forEach((doc){
            var lecture = LectureDTO.fromJson(doc.data);
            String date = "${dateFormat.format(today)} ${lecture.startTime}";
            lecture.timeStamp = DateTime.parse(date).millisecondsSinceEpoch;
            todayLectures.add(lecture);
          });

          return StreamBuilder<QuerySnapshot>(
            stream: eventStream,
            builder: (context, eventsStream){

              if(eventsStream.hasData){
                todayEvents.clear();

                eventsStream.data.documents.forEach((doc) => todayEvents.add(EventDTO.fromJson(doc.data)));

                return Container(
                    color: Colors.grey[200],
                    child: Stack(
                      children: <Widget>[
                        Positioned(top: 0, right: 0, left: 0, child: _topBar()),
                        Container(
                          padding: EdgeInsets.only(top: 100.0),
                          child: _body(),
                        ),
                      ],
                    ));
              }

              if(eventsStream.hasError){
                return Center(child: Text("Error fetching data, please check your network and try again"));
              }

              return Loading();
            },
          );
        }

        if(lecturesStream.hasError){
          return Center(child: Text("Error fetching data, please check your network and try again"));
        }

        return Loading();
      })
    );
  }

  Stream<QuerySnapshot> lectureStream;
  Stream<QuerySnapshot> eventStream;

  var today = DateTime.now();
  refresh(){
    lectureStream = LectureDAO.fetchLectures(today.weekday);
    eventStream = EventDAO.queryEventsByDate(dateFormat.format(today));
  }

  Widget category(title, color, icon, {Function() onTap, int total = 0}) {
    return Stack(
      children: <Widget>[
        Padding(
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
                            Icon(icon, color: color, size: 20.0),
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
        ),
        total > 0 ? Positioned(child: Container(
          padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorUtils.accentColor,
              shape: BoxShape.circle
            ),
            child: Text("$total", style: TextStyle(color: Colors.white),)), top: 0, right: 0) : SizedBox()
      ],
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // This next line does the trick.
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("2ND ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("Semester",
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w300))
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("200L",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text("Computer Science.",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w300))
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("${(todayEvents.length + todayLectures.length).toString().padLeft(2, "0")}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("Activities Today",
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
        summaryDisplay(),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 6 / 5,
            ),
            delegate: SliverChildListDelegate(<Widget>[
              category(
                  "Lectures", eventColors[EventType.LECTURES], FontAwesomeIcons.chalkboardTeacher,
                total: todayLectures.length,
                onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Lectures()));
                   }
              ),
              category("Fixed Class", eventColors[EventType.CLASS], Icons.library_books,
                  total: todayEvents.where((event) => event.type == EventType.CLASS).toList().length,
                  onTap: () {
                    navigateToEvent(EventType.CLASS);
                  }
              ),
              category("Assignment/CA", eventColors[EventType.ASSIGNEMTCA], FontAwesomeIcons.twitch,
                  total: todayEvents.where((event) => event.type == EventType.ASSIGNEMTCA).toList().length,
                  onTap: (){
                    navigateToEvent(EventType.ASSIGNEMTCA);}
              ),
              category(
                  "Test",  eventColors[EventType.TEST], FontAwesomeIcons.tasks,
                  total: todayEvents.where((event) => event.type == EventType.TEST).toList().length,
                  onTap: (){
                    navigateToEvent(EventType.TEST);}
              ),
              category("Exam", eventColors[EventType.EXAM], FontAwesomeIcons.clipboardList,
                  total: todayEvents.where((event) => event.type == EventType.EXAM).toList().length,
                  onTap: (){
                    navigateToEvent(EventType.EXAM);}
              ),
              category(
                  "Others", eventColors[EventType.OTHERS], FontAwesomeIcons.tasks,
                  total: todayEvents.where((event) => event.type == EventType.OTHERS).toList().length,
                  onTap: (){
                    navigateToEvent(EventType.OTHERS);
                  }
              ),
              category("Courses", Colors.grey, FontAwesomeIcons.book,
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CoursesScreen()));
                  }
              ),
              category("Class excos", Colors.brown, FontAwesomeIcons.users,
                  onTap: (){
                Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ClassExcoScreen()));
                  }
              ),
            ]),
          ),
        ),
      ],
    );
  }

  summaryDisplay() {
    var combinedList = <DateEvent>[];
    combinedList.addAll(todayLectures);
    combinedList.addAll(todayEvents);

    combinedList.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));
    combinedList = combinedList.toList();

    return SliverList(
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
                          Text(monthYear,
                              style: Theme.of(context).textTheme.subhead),
                        ],
                      ),
                      Expanded(child: SizedBox()),
                      RaisedButton(
                          onPressed: () {

                            widget.calendarScreen();
//
                           /* Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Today(events: combinedList, date: monthYear);
                            }));*/
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
                    child: combinedList.isEmpty ? Center(child: Text("No event today")) :
                    ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: combinedList.length,
                        itemBuilder: (context, index) {
                          return CombinedPreviewEventListItem(combinedList[index],
                              isLecture: combinedList[index] is LectureDTO,

                          onTap: (event){
                              Navigator.of( context)
                                  .push(MaterialPageRoute(
                                  builder: (context) => event is LectureDTO ?
                                  LectureDetailsScreen(lecture: event) : EventDetailsScreen(event: event as EventDTO)
                              ));


                          },
                          );
                        })


    )
              ],
            ),
          ),
        ]));
  }

  String pass;
  showPasswordDialog() async {
    var password = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text("Admin Login", textAlign: TextAlign.center,),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)
            ),
            contentPadding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextField(
                onChanged: (value){
                  pass = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password"
                ),
              ),
              RaisedButton(onPressed: (){
                Navigator.of(context).pop(pass);
              }, child: Text("Login"))
            ],
          );
        }) ?? "";

    if(password == "admin1234"){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminScreen()));
    }else{
      if(password.isNotEmpty) {
        showError(message: "Wrong password");
      }
    }
  }

  void navigateToEvent(String eventType) {
    Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => EventsScreen(eventType)));
  }

  void checkForNewVersion() {
    Future.delayed(Duration.zero, (){
      showDialog(
          context: context, builder: (context){
        return SimpleDialog(
          title: Text("New version available", textAlign: TextAlign.left,),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          contentPadding: EdgeInsets.all(16.0),
          children: <Widget>[
            Text("What is new"),
            Container(height: 1, color: Colors.grey.withOpacity(0.5),),
            gap2x,

          ],
        );
      });
    });
  }
}
