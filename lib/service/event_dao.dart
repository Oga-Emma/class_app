import 'dart:async';

import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/event_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'app_info_dao.dart';

class EventDAO {
  static void savEvent(
      EventDTO event, CourseDTO course, Function(bool success) callback) {
    var firestore = Firestore.instance;

    var eventRef = AppInfoDAO.getDocumentPath().collection("events").document(event.id);

    var batch = firestore.batch();
    batch.setData(eventRef, event.toMap(), merge: true);

    if (course != null) {
      var courseRef = AppInfoDAO.getDocumentPath()
          .collection("courses")
          .document(event.courseId);

      var eventIds = Set.from(course.eventIds);
      eventIds.add(course.id);

      batch.updateData(courseRef, {"eventIds": eventIds.toList()});
    }

    batch.commit().then((_) {
      callback(true);
    }).catchError((error) {
      print(error);
      callback(false);
    });
  }

  static Stream<QuerySnapshot> fetchAllEvents() {
    return AppInfoDAO.getDocumentPath().collection("events").snapshots();
  }

  static Stream<QuerySnapshot> queryEventsByType(String type) {
    return AppInfoDAO.getDocumentPath()
        .collection("events")
        .where("type", isEqualTo: type)
        .snapshots();
  }

  static Stream<QuerySnapshot> queryEventsByDate(String date) {
    return AppInfoDAO.getDocumentPath()
        .collection("events")
        .where("date", isEqualTo: date)
        .snapshots();
  }

  static void deleteEvent(
      EventDTO event, bool delete, Function(bool success) callback) {
    event.deleted = delete;

    AppInfoDAO.getDocumentPath()
        .collection("events")
        .document(event.id)
        .setData(event.toMap())
        .then((_) {
      callback(true);
    }).catchError((error) {
      print(error);
      callback(false);
    });
  }
}
