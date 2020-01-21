import 'package:class_app/model/course_dto.dart';
import 'package:class_app/service/course_dao.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/helper_widgets/ca_button.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'add_edit_course_screen.dart';

class SelectCourse extends StatefulWidget {
  SelectCourse({@required this.onCourseSelected});
  final Function(CourseDTO course) onCourseSelected;

  @override
  _SelectCourseState createState() => _SelectCourseState();
}

class _SelectCourseState extends State<SelectCourse> {
  List<CourseDTO> courses = [];
  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    return AlertDialog(
      title: Text(
        "SELECT COURSE",
        style: Theme.of(context).textTheme.subtitle,
      ),
      content: Container(
          width: double.maxFinite,
//          height: MediaQuery.of(context).size.width,
//          width: 300.0, // Change as per your requirement
          child: StreamBuilder<QuerySnapshot>(
              stream: CourseDAO.fetchAllCourses(appState.appInfo),
              builder: (context, stream) {
                if (stream.hasData) {
                  courses.clear();
                  stream.data.documents.forEach((doc) {
                    courses.add(CourseDTO.fromJson(doc.data));
                  });
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                            itemCount: courses.length,
                            itemBuilder: (context, index) {
                              var course = courses[index];
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                      title: Text(course.code),
                                      subtitle: Text(course.title),
                                      dense: true,
                                      onTap: () {
                                        widget.onCourseSelected(course);
                                      }),
                                  Divider()
                                ],
                              );
                            }),
                      ),
                      Divider(),
                      CAButton(
                          title: "New Course",
                          outline: true,
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddEditCourse(
                                    course: CourseDTO.withId(Uuid().v1()))));
                          })
                    ],
                  );
                }

                if (stream.hasError) {
                  return Center(
                      child: Text("Error fetcing data, please try again"));
                }

                return Loading();
              })),
    );
  }
}
