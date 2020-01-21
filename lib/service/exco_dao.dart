import 'dart:async';

import 'package:class_app/model/app_info_dto.dart';
import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/exco_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'app_info_dao.dart';

class ExcoDAO {
  static void saveExco(AppInfoDTO appInfo, ExcoDTO exco, Function(bool success) callback) {
    AppInfoDAO.getDocumentPath(appInfo)
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

  static Future<DocumentSnapshot> getExco(AppInfoDTO appInfo, String excoId) {
    return AppInfoDAO.getDocumentPath(appInfo)
        .collection("excos")
        .document(excoId)
        .get();
  }

  static void deleteExco(AppInfoDTO appInfo, String excoId, Function(bool success) callback) {
    AppInfoDAO.getDocumentPath(appInfo)
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

  static Stream<QuerySnapshot> fetchAllExcos(AppInfoDTO appInfo) {
    return AppInfoDAO.getDocumentPath(appInfo).collection("excos").snapshots();
  }
}
