import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class AppSettingDAO {
  var firestore = Firestore.instance;

  Future<QuerySnapshot> getSchools() async {
    return await firestore.collection('schools').getDocuments();
  }

  Future<QuerySnapshot> getDepartments(String schooId) async {
    return await firestore
        .collection('schools')
        .document(schooId)
        .collection('departments')
        .getDocuments();
  }
}

final appSettingDao = AppSettingDAO();
