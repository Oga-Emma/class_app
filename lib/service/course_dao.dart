import 'package:class_app/model/course_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseDAO {
  void saveCourse(CourseDTO course, Function(bool success) callback) {
    var firestore = Firestore.instance;
    firestore
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

  void deleteCourse(
      CourseDTO course, bool delete, Function(bool success) callback) {
    course.deleted = delete;
    var firestore = Firestore.instance;

    firestore
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

  Stream<QuerySnapshot> fetchAllCourses(
      CourseDTO course, Function(bool success) callback) {
    var firestore = Firestore.instance;
    return firestore.collection("courses").snapshots();
  }
}
