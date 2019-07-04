import 'package:class_app/model/course_dto.dart';
import 'package:class_app/service/course_dao.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SelectCourse extends StatefulWidget {
  SelectCourse({@required this.onCourseSelected});
  final Function(CourseDTO course) onCourseSelected;


  @override
  _SelectCourseState createState() => _SelectCourseState();
}

class _SelectCourseState extends State<SelectCourse> {

  List<CourseDTO> courses = [];

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text("SELECT COURSE", style: Theme.of(context).textTheme.subtitle,),
      content: Container(
        height: MediaQuery.of(context).size.width,
        width: 300.0, // Change as per your requirement
        child: StreamBuilder<QuerySnapshot>(
            stream: CourseDAO.fetchAllCourses(),
            builder: (context, stream){
              if(stream.hasData){
                courses.clear();
                stream.data.documents.forEach((doc){
                  courses.add(CourseDTO.fromJson(doc.data));
                });
                return ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      var course = courses[index];
                      return Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(course.code),
                            subtitle: Text(course.title),
                              onTap: (){
                                widget.onCourseSelected(course);
                              }
                          ),
                          Container(height: 1,
                              color: Colors.grey.withOpacity(0.4),
                          margin: EdgeInsets.symmetric(vertical: 16.0),)
                        ],
                      );
                    }
                );
              }

              if(stream.hasError){
                return Center(child: Text("Error fetcing data, please try again"));
              }

              return Loading();
            })
      ),
    );
  }
}