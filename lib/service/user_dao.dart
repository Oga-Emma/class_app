import 'dart:async';

import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/event_dto.dart';
import 'package:class_app/model/user_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'app_info_dao.dart';

class UserDAO {
  static Future<UserDTO> saveUser(UserDTO user) async {
    var firestore = Firestore.instance;
    await firestore
        .collection('users')
        .document(user.id)
        .updateData(user.toMap());
  }

  static Future<UserDTO> getUser(String userId) async {
    var firestore = Firestore.instance;
    var user = await firestore.collection('users').document(userId).get();

    if (!user.exists || user.data == null) {
      throw Exception('User not found');
    }
    return UserDTO.fromMap(user.data);
  }
}
