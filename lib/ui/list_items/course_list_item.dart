import 'package:class_app/model/course_dto.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:flutter/material.dart';

class CourseListItem extends StatelessWidget {
  CourseListItem(this.course, {this.onTap});
  final CourseDTO course;
  final Function(CourseDTO course) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ColorUtils.accentColor.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(16.0)
      ),
      child: InkWell(
        onTap: (){
          onTap(course);
        },
        child: Column(
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
            Text(
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
            gap,
           Container(height: 1, color: Colors.grey.withOpacity(0.3),
             margin: EdgeInsets.symmetric(vertical: 8.0),
           ),
           Row(
             children: <Widget>[
               Text("TYPE: ${course.type}",
                 style: Theme.of(context)
                     .textTheme
                     .caption,
                 overflow: TextOverflow.ellipsis,
                 maxLines: 2,
               ),
               Expanded(child: SizedBox()),
               Text("Unit Load: ${course.unitLoad}",
                 style: Theme.of(context)
                     .textTheme
                     .caption,
                 overflow: TextOverflow.ellipsis,
                 maxLines: 2,
               )
             ],
           )
          ],
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
