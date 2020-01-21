import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/lecture_dto.dart';
import 'package:class_app/service/course_dao.dart';
import 'package:class_app/service/lecture_dao.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/lecture/lecture_details_screen.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/utils/helper_methods.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseDetailsScreen extends StatefulWidget {
  CourseDetailsScreen({this.courseCode});

  final String courseCode;

  @override
  _CourseDetailsScreenState createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  var selected = 0;
  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    var selectedDecoration = BoxDecoration(
        color: ColorUtils.primaryColor,
        borderRadius: BorderRadius.circular(24.0));
    var deselectedDecoration = BoxDecoration();

    var selectedInputStyle = Theme.of(context)
        .textTheme
        .title
        .copyWith(color: Colors.white, fontSize: 16);
    var deselectedInputStyle = Theme.of(context).textTheme.subtitle;

    return Scaffold(
      appBar: AppBar(
        title: Text("COURSE DETAILS"),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<QuerySnapshot>(
          future: CourseDAO.getCourse(appState.appInfo, widget.courseCode),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.documents.isEmpty) {
                return Center(
                    child: Text("Course details not found\n"
                        "check your network and try again"));
              }
              var course = CourseDTO.fromJson(snapshot.data.documents[0].data);
              return Container(
//                          color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0, top: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(course.code,
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: ColorUtils.primaryColor)),
                          Text(course.title)
                        ],
                      ),
                    ),
                    gap2x,
                    gap2x,
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            Material(
                              borderRadius: BorderRadius.circular(24.0),
                              elevation: 4.0,
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            selected = 0;
                                          });
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "DETAILS",
                                              style: selected == 0
                                                  ? selectedInputStyle
                                                  : deselectedInputStyle,
                                            ),
                                            decoration: selected == 0
                                                ? selectedDecoration
                                                : deselectedDecoration),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            selected = 1;
                                          });
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              "OUTLINE",
                                              style: selected == 1
                                                  ? selectedInputStyle
                                                  : deselectedInputStyle,
                                            ),
                                            decoration: selected == 1
                                                ? selectedDecoration
                                                : deselectedDecoration),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            selected = 2;
                                          });
                                        },
                                        child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(8.0),
                                            child: Text("CLASSES",
                                                style: selected == 2
                                                    ? selectedInputStyle
                                                    : deselectedInputStyle),
                                            decoration: selected == 2
                                                ? selectedDecoration
                                                : deselectedDecoration),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 24.0, horizontal: 8.0),
                              child: getPage(course, selected),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error fetching data"));
            }

            return Loading();
          }),
    );
  }

  Widget getPage(CourseDTO course, int position) {
    if (position == 0) {
      return details(course);
    } else if (position == 1) {
      return courseOutline(course);
    } else {
      return classes(course);
    }
  }

  Widget details(CourseDTO course) {
    return Container(
      alignment: Alignment.topLeft,
      child: ListView(
        children: <Widget>[
          Text("DETAILS",
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Colors.grey[500], fontSize: 16)),
          gap,
          Container(
            color: Colors.grey[300],
            height: 2,
          ),
          gap2x,
          headingDetails(context, "Unit Load", course.unitLoad),
          headingDetails(context, "Type", course.type),
          headingDetails(context, "Lecturers", course.lecturers),
          headingDetails(context, "Department", course.department),
          headingDetails(context, "Faculty", course.faculty),
        ],
      ),
    );
  }

  Widget courseOutline(CourseDTO course) {
    return Container(
      alignment: Alignment.topLeft,
      child: course.outline.isEmpty
          ? Center(
              child: Text("Not available"),
            )
          : ListView(
              children: <Widget>[
                Text(
                  "COURSE OUTLINE",
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.grey[500], fontSize: 16),
                ),
                gap,
                Container(
                  color: Colors.grey[300],
                  height: 2,
                ),
                gap2x,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: course.outline
                      .map((str) => Container(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: ColorUtils.accentColor
                                            .withOpacity(0.3)))),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.chevron_right,
                                  size: 16,
                                ),
                                gap,
                                Expanded(
                                    child: Text(
                                  str,
                                  style: Theme.of(context).textTheme.subhead,
                                )),
                              ],
                            ),
                          ))
                      .toList(),
                )
              ],
            ),
    );
  }

  var lectures = <LectureDTO>[];

  Widget classes(CourseDTO course) {
    return Container(
        alignment: Alignment.topLeft,
        child: StreamBuilder<QuerySnapshot>(
            stream: LectureDAO.fetchAllCourseLectures(appState.appInfo, course.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
//          print(snapshot.data.documents);
                lectures.clear();

                snapshot.data.documents.forEach(
                    (doc) => lectures.add(LectureDTO.fromJson(doc.data)));

                return lectures.isEmpty
                    ? Center(child: Text("No classes"))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "CLASSES",
                            style: Theme.of(context).textTheme.title.copyWith(
                                color: Colors.grey[500], fontSize: 16),
                          ),
                          gap,
                          Container(
                            color: Colors.grey[300],
                            height: 2,
                          ),
                          gap2x,
                          Expanded(
                              child: ListView.builder(
                                  itemCount: lectures.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      child: Column(
                                        children: <Widget>[
                                          gap2x,
                                          Material(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            elevation: 4.0,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LectureDetailsScreen(
                                                              lecture: lectures[
                                                                  index],
                                                            )));
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: <Widget>[
                                                    Text(
                                                      "${getDayLabel(lectures[index].day).toUpperCase()}S",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subhead,
                                                    ),
                                                    Container(
                                                      height: 1,
                                                      color: ColorUtils
                                                          .primaryColor,
                                                    ),
                                                    gap2x,
                                                    Text(
                                                        "TIME: ${lectures[index].startTime} - ${lectures[index].endTime}"),
                                                    gap,
                                                    Text(
                                                        "VENUE: ${lectures[index].venue}"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }))
                        ],
                      );
              }

              if (snapshot.hasError) {
                return Center(child: Text("Error fetching data"));
              }

              return Loading();
            }));
  }

  Widget headingDetails(BuildContext context, String title, String details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(title, style: Theme.of(context).textTheme.caption),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8.0)),
          child: Text(
            details,
            style: Theme.of(context).textTheme.subhead,
          ),
        ),
        gap2x
      ],
    );
  }
}
