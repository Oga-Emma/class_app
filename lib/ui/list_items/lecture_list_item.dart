import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/lecture_dto.dart';
import 'package:class_app/service/course_dao.dart';
import 'package:class_app/ui/lecture/lecture_details_screen.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LectureListItem extends StatelessWidget {
  LectureListItem(this.lecture);
  final LectureDTO lecture;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      child: InkWell(
        onTap: (){
          Navigator.of(context)
              .push(MaterialPageRoute(
              builder: (context) => LectureDetailsScreen(lecture: lecture,)));
        },
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  lecture.startTime,
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12.0),
                ),
                Text(
                  lecture.endTime,
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(fontSize: 12.0),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        width: 1.0,
                        height: double.infinity,
                        color: Colors.grey.withOpacity(0.5)),
                  ),
                  Icon(Icons.check_box_outline_blank,
                      size: 16.0,
                      color: Theme.of(context).primaryColor),
                  Expanded(
                    child: Container(
                        width: 1.0,
                        height: double.infinity,
                        color: Colors.grey.withOpacity(0.5)),
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: ColorUtils.accentColor.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(16.0)
                  ),
                  child: FutureBuilder<QuerySnapshot>(
                    future: CourseDAO.getCourse(lecture.courseCode),
                    builder:
                      (context, snapshot) {
                    if(snapshot.hasData && snapshot.data.documents.isNotEmpty){
                      var course = CourseDTO.fromJson(snapshot.data.documents[0].data);

                      return Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                course.code,
                                style: Theme.of(context).textTheme.title.copyWith(
                                    color: ColorUtils.primaryColor),
                              ),
                            ],
                          ),
                          gap,
                          Expanded(
                            child: Text(
                              course.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .body2
                                  .copyWith(
                                  color: Colors.black
                                      .withOpacity(0.5)),
                            ),
                          ),
                          gap,
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.near_me,
                                size: 18,
                                color: Theme.of(context).accentColor,
                              ),
                              gap,
                              Expanded(
                                child: Text(
                                  lecture.venue,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              )
                            ],
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      );

                    }

                    if(snapshot.hasError){
                      print(snapshot.error);

                      return Center(
                        child: Text("Error fetching data\nPlease check your network")
                      );
                    }

                    return Container(
                      child: Loading(),
                    );
                      },

                  )
                ))
          ],
        ),
      ),
    );
  }
}
