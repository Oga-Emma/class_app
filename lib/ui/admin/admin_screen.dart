import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/event_dto.dart';
import 'package:class_app/model/exco_dto.dart';
import 'package:class_app/model/lecture_dto.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/admin/general_info.dart';
import 'package:class_app/ui/helper_widgets/ca_button.dart';
import 'package:class_app/ui/utils/sButton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'add_edit_event_screen.dart';
import 'add_edit_exco_screen.dart';
import 'add_edit_lectures.dart';
import 'classes.dart';
import 'add_edit_course_screen.dart';
import 'courses.dart';
import 'events.dart';
import 'exco.dart';

class AdminScreen extends StatelessWidget {
  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
            title: Text("Super Admin", textAlign: TextAlign.center),
            elevation: 0.0,
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: "General Info"),
                Tab(text: "Classes"),
                Tab(text: "Events"),
                Tab(text: "Courses"),
                Tab(text: "Excos"),
//                Padding(
//                  padding: const EdgeInsets.all(4.0),
//                  child: Text(
//                    "Classes",
//                    style: TextStyle(fontSize: 15),
//                  ),
//                ),
              ],
            )),
        body: TabBarView(
          children: [
            GeneralInfo(),
            Column(
              children: <Widget>[
                Expanded(child: Classes()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CAButton(
                      title: "ADD LECTURE",
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddEditLectures(
                                LectureDTO.withId(Uuid().v1()))));
                      }),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Expanded(child: Events()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CAButton(
                      title: "ADD EVENT",
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                AddEditEvent(EventDTO.withId(Uuid().v1()))));
                      }),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Expanded(child: Courses()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CAButton(
                      title: "ADD COURSE",
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddEditCourse(
                                course: CourseDTO.withId(Uuid().v1()))));
                      }),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Expanded(child: Exco()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CAButton(
                      title: "ADD EXCO",
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                AddEditExco(ExcoDTO.withId(Uuid().v1()))));
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
