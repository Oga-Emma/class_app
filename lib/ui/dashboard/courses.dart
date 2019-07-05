import 'dart:async';

import 'package:class_app/model/course_dto.dart';
import 'package:class_app/service/course_dao.dart';
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Material(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    InkWell(onTap: (){
                      Navigator.pop(context);

                    }, child: Icon(Icons.arrow_back)),
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0,
                              vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(16.0)
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          decoration: InputDecoration.collapsed(
                              hintText: "Search course"
                          ),
                          onChanged: (value){
//                            print(value);
                            setState(() {
                              _searchText = value;
                            });
                          },
                        )
                      ),
                    ),
                    InkWell(
                        onTap: (){},
                        child: Icon(Icons.search)),
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              color: Colors.grey[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0, top: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("COURSES",
                                textAlign: TextAlign.left,
                                style: Theme.of(context).
                                textTheme.display1.copyWith(
                                  fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            Text("Select a course to see more details")
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: CourseDAO.fetchAllCourses(),
                            builder: (context, snapshot) {

                              if(alreadyFetched || snapshot.hasData) {

                                if(!alreadyFetched) {
                                  list.clear();
                                  snapshot.data.documents.forEach(
                                          (doc) =>
                                          list.add(
                                              CourseDTO.fromJson(doc.data)));

                                Future.delayed(Duration.zero, () => alreadyFetched = true);

                                }
                                sortedList = list.where((course) =>
                                course.title.toLowerCase().contains(_searchText)
                                    || course.code.toLowerCase().contains(_searchText)).toList();

                                sortedList.sort((a, b) => a.code.compareTo(b.code));

                                return GridView.count(
                                    crossAxisCount: 2,
                                    childAspectRatio: 6 / 5,
                                    padding: const EdgeInsets.all(4.0),
                                    mainAxisSpacing: 4.0,
                                    crossAxisSpacing: 4.0,
                                    children: sortedList.map((CourseDTO course) {
                                      return InkWell(
                                        onTap: (){

                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(8.0),
                                          padding: EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                              color: Colors.cyan,
                                              borderRadius: BorderRadius.circular(
                                                  16.0)
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: <Widget>[
                                              Text(course.code,
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .display1
                                                      .copyWith(fontSize: 24,
                                                      color: Colors.white)),
                                              Text(course.title,
                                                  maxLines: 2,
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .display1
                                                      .copyWith(fontSize: 14,
                                                      color: Colors.grey[200])),
                                              Container(height: 2, color: Colors.grey[200],
                                                margin: EdgeInsets.symmetric(vertical: 8),
                                              ),
                                              Text("UNIT: ${course.unitLoad}",
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .caption
                                                      .copyWith(
                                                      color: Colors.grey[200])),
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList());
                              }

                              if(snapshot.hasError){
                                return Text("Error fetching data");
                              }

                              return Loading();
                            }
                          ),
                        ),
                      ),
                    ],
                  ),
            ))
          ],
        ),
      ),
    );
  }
}
