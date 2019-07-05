import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/lecture_dto.dart';
import 'package:class_app/service/course_dao.dart';
import 'package:class_app/ui/course/course_details_screen.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/utils/helper_methods.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class LectureDetailsScreen extends StatefulWidget {
  LectureDetailsScreen({@required this.lecture});
  final LectureDTO lecture;
  @override
  _LectureDetailsScreenState createState() => _LectureDetailsScreenState();
}

class _LectureDetailsScreenState extends State<LectureDetailsScreen> {

  var selected = 0;
  @override
  Widget build(BuildContext context) {
    var selectedDecoration = BoxDecoration(
      color: ColorUtils.primaryColor,
      borderRadius: BorderRadius.circular(24.0)
    );
    var deselectedDecoration = BoxDecoration(
    );

    var selectedInputStyle = Theme.of(context).textTheme.title.copyWith(color: Colors.white, fontSize: 18);
    var deselectedInputStyle = Theme.of(context).textTheme.subtitle;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  InkWell(onTap: (){
                    Navigator.pop(context);
                  }, child: Icon(Icons.arrow_back)),
                  gap2x,
                  Text("LECTURE")
                ],
              ),
            ),
            Expanded(
                child: FutureBuilder<QuerySnapshot>(
                    future: CourseDAO.getCourse(widget.lecture.courseCode),
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {

                        if(snapshot.data.documents.isEmpty){
                          return Center(child: Text("Course details not found\n"
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
                                        style: Theme.of(context).
                                        textTheme.display1.copyWith(
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
                                  padding: const EdgeInsets.all(24.0),
                                  child: ListView(
                                    children: <Widget>[
                                      headingDetails(context, "Lecture Starts", widget.lecture.startTime),
                                      headingDetails(context, "Lecture Ends", widget.lecture.endTime),
                                      headingDetails(context, "Lecture Day", getDayLabel(widget.lecture.day)),
                                      headingDetails(context, "Venue", widget.lecture.venue),
                                      gap2x,
                                      gap2x,
                                      gap2x,
                                      Material(
                                        borderRadius: BorderRadius.circular(24.0),
                                        elevation: 4.0,
                                        child: Container(
                                          decoration: BoxDecoration(),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Expanded(
                                                child: InkWell(
                                                  onTap: (){
                                                    /*setState(() {
                                                      selected = 1;
                                                    });*/
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                        builder: (context) => CourseDetailsScreen(courseCode: widget.lecture.courseCode)));
                                                  },
                                                  child: Container(
                                                      alignment: Alignment.center,
                                                      padding: EdgeInsets.all(8.0), child: Text("VIEW COURSE DETAILS", style: selected == 1 ? selectedInputStyle : deselectedInputStyle),
                                                      decoration: selected == 1 ? selectedDecoration : deselectedDecoration),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      if(snapshot.hasError){
                        return Center(child: Text("Error fetching data"));
                      }

                      return Loading();
                    }
                )),
          ],
        ),
      ),
    );
  }

  Widget details(CourseDTO course){
    return Container(
      alignment: Alignment.topLeft,
      child: ListView(
        children: <Widget>[
          Text("DETAILS", style: Theme.of(context).textTheme.title.copyWith(color: Colors.grey[500]),),
          gap,
          Container(color: Colors.grey[300], height: 2, ),
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

  Widget headingDetails(BuildContext context, String title, String details){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(title, style: Theme.of(context).textTheme.caption),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0)
          ),
          child: Text(details, style: Theme.of(context).textTheme.subhead,),
        ),
        gap2x
      ],
    );
  }
}
