import 'dart:async';

import 'package:class_app/model/app_info_dto.dart';
import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/lecture_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'app_info_dao.dart';

class LectureDAO {
  static void saveLecture(AppInfoDTO appInfo, LectureDTO lecture,
      CourseDTO course, Function(bool success) callback) {
    var firestore = Firestore.instance;
    var batch = firestore.batch();

    var lectureRef = AppInfoDAO.getDocumentPath(appInfo)
        .collection("classes")
        .document(lecture.id);

    if (course != appInfo) {
      var lectureIds = Set.from(course.lectureIds);
      lectureIds.add(lecture.id);

      var courseRef = AppInfoDAO.getDocumentPath(appInfo)
          .collection("courses")
          .document(lecture.course.id);

      lecture.course = course;
      batch.updateData(courseRef, {"lectureIds": lectureIds.toList()});
    }

    batch.setData(lectureRef, lecture.toMap(), merge: true);

    batch.commit().then((_) {
      callback(true);
    }).catchError((error) {
      print(error);
      callback(false);
    });
  }

  static Stream<QuerySnapshot> fetchLectures(AppInfoDTO appInfo, int day) {
    return AppInfoDAO.getDocumentPath(appInfo)
        .collection("classes")
        .where("day", isEqualTo: day)
        .snapshots();
  }

  static Stream<QuerySnapshot> fetchAllLectures(AppInfoDTO appInfo) {
    return AppInfoDAO.getDocumentPath(appInfo)
        .collection("classes")
        .snapshots();
  }

  static void deleteLecture(AppInfoDTO appInfo, LectureDTO lecture) {
    print("deleting");
    var firestore = Firestore.instance;
    var batch = firestore.batch();

    var lectureRef = AppInfoDAO.getDocumentPath(appInfo)
        .collection("classes")
        .document(lecture.id);

    var courseRef = AppInfoDAO.getDocumentPath(appInfo)
        .collection("courses")
        .document(lecture.course.id);

    batch.updateData(courseRef, {
      "lectureIds": FieldValue.arrayRemove([lecture.id])
    });
    batch.delete(lectureRef);

    batch.commit().then((_) {}).catchError((error) {
      print(error);
    });
  }

  static Stream<QuerySnapshot> fetchAllCourseLectures(
      AppInfoDTO appInfo, String courseId) {
    return AppInfoDAO.getDocumentPath(appInfo)
        .collection("classes")
        .where("course.id", isEqualTo: courseId)
        .snapshots();
  }
}
