import 'dart:async';

import 'package:class_app/model/lecture_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LectureDAO {
  static void saveLecture(LectureDTO lecture, Function(bool success) callback) {
    var firestore = Firestore.instance;

    firestore
        .collection("classes")
        .document(lecture.id)
        .setData(lecture.toMap())
        .then((_) {
      callback(true);
    }).catchError((error) {
      print(error);
      callback(false);
    });
  }
  static Stream<QuerySnapshot> fetchLectures(int day) {
    var firestore = Firestore.instance;

    return firestore
        .collection("classes").where("day", isEqualTo: day).snapshots();
  }

  static void deleteLecture(String id) {
    print("deleting");
    var firestore = Firestore.instance;
    firestore
        .collection("classes")
        .document(id)
    .delete()
        .then((_) {
          print("deleted");
    }).catchError((error) {
      print(error);
    });
  }

}
