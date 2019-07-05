import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/event_dto.dart';
import 'package:class_app/model/lecture_dto.dart';
import 'package:class_app/ui/utils/sButton.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'add_edit_event_screen.dart';
import 'add_edit_exco_screen.dart';
import 'add_edit_lectures.dart';
import 'classes.dart';
import 'add_edit_course_screen.dart';
import 'courses.dart';
import 'events.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
            title: GestureDetector(
                onHorizontalDragEnd: (details) {},
                child: Text("Admin", textAlign: TextAlign.center)),
            elevation: 0.0,
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Classes",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Events",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Courses",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Excos",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            )),
        body: TabBarView(
          children: [
            Column(
              children: <Widget>[
                Expanded(child: Classes()),
                SButton(labelText: "ADD LECTURE", onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddEditLectures(LectureDTO.withId(Uuid().v1())))
                  );
                }),
              ],
            ),
            Column(
              children: <Widget>[
                Expanded(child: Events()),
                SButton(labelText: "ADD EVENT", onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddEditEvent(EventDTO.withId(Uuid().v1())))
                  );
                }),
              ],
            ),
            Column(
              children: <Widget>[
                Expanded(child: Courses()),
                SButton(labelText: "ADD COURSE", onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddEditCourse(course: CourseDTO.withId(Uuid().v1())))
                  );
                }),
              ],
            ),
            Column(
              children: <Widget>[
                Expanded(child: Container()),
                SButton(labelText: "ADD EXCO", onTap: (){
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AddEditExco())
                  );
                }),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
