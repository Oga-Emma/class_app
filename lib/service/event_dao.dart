import 'dart:async';

import 'package:class_app/model/app_info_dto.dart';
import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/event_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'app_info_dao.dart';

class EventDAO {
  static void savEvent(AppInfoDTO appInfo, 
      EventDTO event, CourseDTO course, Function(bool success) callback) {
    var firestore = Firestore.instance;

    var eventRef = AppInfoDAO.getFullDocumentPath(appInfo).collection("events").document(event.id);

    var batch = firestore.batch();
    batch.setData(eventRef, event.toMap(), merge: true);

//    if (course != appInfo) {
//      var courseRef = AppInfoDAO.getDocumentPath()
//          .collection("courses")
//          .document(event.courseId);
//
//      var eventIds = Set.from(course.eventIds);
//      eventIds.add(course.id);
//
//      batch.updateData(courseRef, {"eventIds": eventIds.toList()});
//    }

    batch.commit().then((_) {
      callback(true);
    }).catchError((error) {
      print(error);
      callback(false);
    });
  }

  static Stream<QuerySnapshot> fetchAllEvents(AppInfoDTO appInfo) {
    return AppInfoDAO.getFullDocumentPath(appInfo).collection("events").snapshots();
  }

  static Stream<QuerySnapshot> queryEventsByType(AppInfoDTO appInfo, String type) {
    return AppInfoDAO.getFullDocumentPath(appInfo)
        .collection("events")
        .where("type", isEqualTo: type)
        .snapshots();
  }

  static Stream<QuerySnapshot> queryEventsByDate(AppInfoDTO appInfo, String date) {
    return AppInfoDAO.getFullDocumentPath(appInfo)
        .collection("events")
        .where("date", isEqualTo: date)
        .snapshots();
  }

  static void deleteEvent(AppInfoDTO appInfo, 
      EventDTO event, Function(bool success) callback) {

    AppInfoDAO.getFullDocumentPath(appInfo)
        .collection("events")
        .document(event.id)
    .delete()
        .then((_) {
      callback(true);
    }).catchError((error) {
      print(error);
      callback(false);
    });
  }
}
