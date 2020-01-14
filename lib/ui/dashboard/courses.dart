import 'dart:async';

import 'package:class_app/model/course_dto.dart';
import 'package:class_app/service/course_dao.dart';
import 'package:class_app/ui/course/course_details_screen.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CoursesScreen extends StatefulWidget {
  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  String _searchText = "";
  bool alreadyFetched = false;
  var list = <CourseDTO>[];
  var sortedList = <CourseDTO>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text("SEMESTER COURSES")),
      body: StreamBuilder<QuerySnapshot>(
          stream: CourseDAO.fetchAllCourses(),
          builder: (context, snapshot) {
            if (alreadyFetched || snapshot.hasData) {
              if (!alreadyFetched) {
                list.clear();
                snapshot.data.documents
                    .forEach((doc) => list.add(CourseDTO.fromJson(doc.data)));

                Future.delayed(Duration.zero, () => alreadyFetched = true);
              }
              sortedList = list
                  .where((course) =>
                      course.title.toLowerCase().contains(_searchText) ||
                      course.code.toLowerCase().contains(_searchText))
                  .toList();

              sortedList.sort((a, b) => a.code.compareTo(b.code));

              return GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 6 / 5,
                  padding: const EdgeInsets.all(4.0),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  children: sortedList.map((CourseDTO course) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CourseDetailsScreen(courseCode: course.code)));
                      },
                      child: Material(
                        clipBehavior: Clip.hardEdge,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(course.code,
                                        style: Theme.of(context)
                                            .textTheme
                                            .title
                                            .copyWith(
                                                fontSize: 24,
                                                color: ColorUtils.primaryColor
                                                    .withGreen(80))),
                                    Text(course.title,
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .display1
                                            .copyWith(fontSize: 12)),
                                    Container(
                                      height: 2,
                                      color: Colors.grey[200],
                                      margin: EdgeInsets.symmetric(vertical: 8),
                                    ),
                                    Text("UNIT: ${course.unitLoad}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith()),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                                height: 5, color: ColorUtils.primaryColor[200]),
                          ],
                        ),
                      ),
                    );
                  }).toList());
            }

            if (snapshot.hasError) {
              return Text("Error fetching data");
            }

            return Loading();
          }),
    );
  }
}
