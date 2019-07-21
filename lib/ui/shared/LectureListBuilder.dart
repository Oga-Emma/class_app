import 'package:class_app/model/lecture_dto.dart';
import 'package:class_app/service/lecture_dao.dart';
import 'package:class_app/ui/list_items/lecture_admin_list_item.dart';
import 'package:class_app/ui/list_items/lecture_list_item.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LectureListBuilder extends StatelessWidget {
  LectureListBuilder({@required this.day, this.isAdmin = false});

  final bool isAdmin;
  final int day;
  final List<LectureDTO> classes = [];
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: LectureDAO.fetchLectures(day),
        builder: (context, stream){

          if(stream.hasData){
            classes.clear();

            if(stream.data.documents.isEmpty){
              return Center(child: Text("No Lecture today"));
            }

            stream.data.documents.forEach((doc)
                {
                  var lec = LectureDTO.fromJson(doc.data);
                  lec.id = doc.documentID;
                  classes.add(lec);
                });

            classes.sort((a, b) => a.startTime.compareTo(b.startTime));

            return ListView.builder(
                itemCount: classes.length,
                itemBuilder: (context, index){
              return isAdmin ? LectureAdminListItem(classes[index]) : LectureListItem(classes[index]);
            });
          }

          if(stream.hasError){
            return Center(child: Text("Error fecting data, "
                "check your network and try again"));
          }

          return Loading();
    });
  }
}
