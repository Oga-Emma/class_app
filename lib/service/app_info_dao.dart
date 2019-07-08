import 'dart:async';

import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/exco_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppInfoDAO {
  static void saveExco(ExcoDTO exco, Function(bool success) callback) {
    var firestore = Firestore.instance;
    firestore
        .collection("excos")
        .document(exco.id)
        .setData(exco.toMap())
        .then((_) {
      callback(true);
    }).catchError((error) {
      print(error);
      callback(false);
    });
  }
  static Future<QuerySnapshot> getAllDepartments(String uni) {
    var firestore = Firestore.instance;
    return firestore
        .collection("uni").getDocuments();
  }

  static void deleteExco(
      String excoId, Function(bool success) callback) {
    var firestore = Firestore.instance;

    firestore
        .collection("excos")
        .document(excoId)
        .delete()
        .then((_) {
      callback(true);
    }).catchError((error) {
      print(error);
      callback(false);
    });
  }

  static Stream<QuerySnapshot> fetchAllExcos() {
    var firestore = Firestore.instance;
    return firestore.collection("excos").snapshots();
  }


  static DocumentReference getDocumentPath({String uni = "unn", String uniId = "pFnWxL7imA2gxkjy6QCT"}){
    var firestore = Firestore.instance;

    return firestore.collection(uni).document(uniId);
  }
}