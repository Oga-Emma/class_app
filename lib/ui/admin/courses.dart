import 'package:class_app/model/course_dto.dart';
import 'package:class_app/service/course_dao.dart';
import 'package:class_app/ui/list_items/course_list_item.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Courses extends StatelessWidget {

  List<CourseDTO> courses = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<QuerySnapshot>(
            stream: CourseDAO.fetchAllCourses(),
            builder: (context, stream){
          if(stream.hasData){
            courses.clear();
            stream.data.documents.forEach((doc){
              courses.add(CourseDTO.fromJson(doc.data));
            });
//            courses.forEach((f) => print(f.toMap()));
            return ListView.builder(
                itemCount: courses.length,
                itemBuilder: (context, index) => CourseListItem(courses[index], onTap: (course){

                },));
          }

          if(stream.hasError){
            return Center(child: Text("Error fetcing data, please try again"));
          }

          return Loading();
        })
    );
  }
}
