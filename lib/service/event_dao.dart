import 'dart:async';

import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/event_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventDAO {
  static void savEvent(EventDTO event, Function(bool success) callback) {
    var firestore = Firestore.instance;
    firestore
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
  static Stream<QuerySnapshot> fetchAllEvents() {
    var firestore = Firestore.instance;
    return firestore
        .collection("events").snapshots();
  }
  static Stream<QuerySnapshot> queryEventsByType(String type) {
    var firestore = Firestore.instance;
    return firestore
        .collection("events").where("type", isEqualTo: type).snapshots();
  }
  static Stream<QuerySnapshot> queryEventsByDate(String date) {
    var firestore = Firestore.instance;
    return firestore
        .collection("events").where("date", isEqualTo: date).snapshots();
  }

  static void deleteEvent(EventDTO event, bool delete, Function(bool success) callback) {
    event.deleted = delete;
    var firestore = Firestore.instance;
    firestore
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
