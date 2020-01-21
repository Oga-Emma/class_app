import 'dart:async';

import 'package:class_app/model/app_info_dto.dart';
import 'package:class_app/model/course_dto.dart';
import 'package:class_app/service/app_info_dao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseDAO {
  static void saveCourse(
      AppInfoDTO appInfo, CourseDTO course, Function(bool success) callback) {
    var batch = Firestore.instance.batch();

    course.lectureIds.forEach((id) => batch.updateData(
        AppInfoDAO.getDocumentPath(appInfo).collection("classes").document(id),
        {"course": course.toMap()}));
    course.eventIds.forEach((id) => batch.updateData(
        AppInfoDAO.getDocumentPath(appInfo).collection("events").document(id),
        {"course": course.toMap()}));

    batch.setData(
        AppInfoDAO.getDocumentPath(appInfo)
            .collection("courses")
            .document(course.id),
        course.toMap(),
        merge: true);

    batch.commit().then((_) {
      callback(true);
    }).catchError((error) {
      print(error);
      callback(false);
    });
  }

  static Future<QuerySnapshot> getCourse(
      AppInfoDTO appInfo, String courseCode) {
    return AppInfoDAO.getDocumentPath(appInfo)
        .collection("courses")
        .where("code", isEqualTo: courseCode)
        .limit(1)
        .getDocuments();
  }

  static void deleteCourse(AppInfoDTO appInfo, CourseDTO course, bool delete,
      Function(bool success) callback) {
    course.deleted = delete;

    AppInfoDAO.getDocumentPath(appInfo)
        .collection("courses")
        .document(course.id)
        .setData(course.toMap())
        .then((_) {
      callback(true);
    }).catchError((error) {
      print(error);
      callback(false);
    });
  }

  static Stream<QuerySnapshot> fetchAllCourses(AppInfoDTO appInfo) {
    return AppInfoDAO.getDocumentPath(appInfo)
        .collection("courses")
        .snapshots();
  }

  static Future<DocumentSnapshot> getCourseById(
      AppInfoDTO appInfo, String courseId) {
    return AppInfoDAO.getDocumentPath(appInfo)
        .collection("courses")
        .document(courseId)
        .get();
  }
}
