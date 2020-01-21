import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/lecture_dto.dart';
import 'package:class_app/service/course_dao.dart';
import 'package:class_app/service/lecture_dao.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/admin/add_edit_lectures.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LectureAdminListItem extends StatelessWidget {
  LectureAdminListItem(this.lecture);
  final LectureDTO lecture;

  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    return Container(
      height: 200.0,
      child: Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                lecture.startTime,
                style: Theme.of(context).textTheme.subhead.copyWith(
                    color: Theme.of(context).primaryColor, fontSize: 12.0),
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
                    size: 16.0, color: Theme.of(context).primaryColor),
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
                      border: Border.all(
                          color: ColorUtils.accentColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(16.0)),
                  child: Column(
                    children: <Widget>[
                      Text(
                        lecture.course.code,
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(color: ColorUtils.primaryColor),
                      ),
                      gap,
                      Expanded(
                        child: Text(
                          lecture.course.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .body2
                              .copyWith(color: Colors.black.withOpacity(0.5)),
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
                              style: Theme.of(context).textTheme.caption,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child: SizedBox()),
                          FlatButton(
                              shape: StadiumBorder(
                                  side: BorderSide(
                                      color: ColorUtils.accentColor)),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        AddEditLectures(lecture)));
                              },
                              child: Text("Edit")),
                          gap2x,
                          FlatButton(
                              shape: StadiumBorder(
                                  side: BorderSide(color: Colors.redAccent)),
                              onPressed: () async {
                                bool delete = await showDialog<bool>(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text("Delete Lecture"),
                                              content: Text(
                                                  "Are you sure?\nThis aciton cannot be undone"),
                                              actions: <Widget>[
                                                FlatButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(false),
                                                    child: Text("Cancel")),
                                                FlatButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(true),
                                                    child: Text("Delete"))
                                              ],
                                            )) ??
                                    false;

                                if (delete) {
                                  LectureDAO.deleteLecture(
                                      appState.appInfo, lecture);
                                }
                              },
                              child: Text("Delete"))
                        ],
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  )))
        ],
      ),
    );
  }
}
