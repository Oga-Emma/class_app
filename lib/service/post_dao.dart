import 'dart:async';

import 'package:class_app/model/app_info_dto.dart';
import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/post_dto.dart';
import 'package:class_app/service/app_info_dao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostDAO {
  static Future<void> savePost(PostDTO post) async {
    var firestore = Firestore.instance;
    if (post.id == null || post.id.isEmpty) {
      return await firestore.collection('posts').add(post.toMap());
    } else {
      return await firestore
          .collection('posts')
          .document(post.id)
          .setData(post.toMap(), merge: true);
    }
  }

  static Future<QuerySnapshot> getRecentPosts(AppInfoDTO appInfo) {
    var firestore = Firestore.instance;
    return firestore
        .collection('posts')
        .where("group", whereIn: [
          'all',
          '${appInfo.school.code}',
          '${appInfo.department.departmentCode}-${appInfo.department.entryYear}'
        ])
        .orderBy("datePublished", descending: true)
        .getDocuments();
  }

  static Future<QuerySnapshot> getTrendingPosts(AppInfoDTO appInfo) {
    var firestore = Firestore.instance;
    return firestore
        .collection('posts')
        .where("group", whereIn: [
          'all',
          '${appInfo.school.code}',
          '${appInfo.department.departmentCode}-${appInfo.department.entryYear}'
        ])
        .orderBy("commentCount", descending: true)
        .orderBy("datePublished", descending: true)
        .getDocuments();
  }
}
