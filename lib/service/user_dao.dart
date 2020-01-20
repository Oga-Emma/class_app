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
        .setData(user.toMap(), merge: true);
  }

  static Future<UserDTO> getUser(String userId) async {
    var firestore = Firestore.instance;
    var user = await firestore.collection('users').document(userId).get();

//    print('User id: ${userId}');
//    print(user.exists);
    if (!user.exists || user.data == null) {
      return UserDTO();
    }
    return UserDTO.fromMap(user.data);
  }
}
