import 'dart:async';

import 'package:class_app/model/app_info_dto.dart';
import 'package:class_app/model/comment_dto.dart';
import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/post_dto.dart';
import 'package:class_app/service/app_info_dao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostDAO {
  static Future<void> saveComment(PostDTO post, CommentDTO comment) async {
    var firestore = Firestore.instance;

    var batch = firestore.batch();

    var postRef = firestore.collection('posts').document(post.id);
    var id = postRef.collection('comments').document().documentID;
    var commentRef = postRef.collection('comments').document();

    batch.updateData(postRef, {
      'followers': FieldValue.arrayRemove([comment.posterId])
    });
    batch.setData(commentRef, comment.toMap());

    await batch.commit();
  }

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

  static Stream<QuerySnapshot> watchComments(String postId) {
    var firestore = Firestore.instance;
    return firestore
        .collection('posts/$postId/comments')
        .where('isDeleted', isEqualTo: false)
        .orderBy("dateCreated", descending: true)
        .snapshots();
  }

  static Future<QuerySnapshot> getComments(String postId) {
    var firestore = Firestore.instance;
    return firestore
        .collection('posts/$postId/comments')
        .where('isDeleted', isEqualTo: false)
        .orderBy("dateCreated", descending: true)
        .getDocuments();
  }

  static Future<QuerySnapshot> getRecentPosts(AppInfoDTO appInfo) {
    var firestore = Firestore.instance;
    return firestore
        .collection('posts')
        .where('isDeleted', isEqualTo: false)
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
        .where('isDeleted', isEqualTo: false)
        .where("group", whereIn: [
          'all',
          '${appInfo.school.code}',
          '${appInfo.department.departmentCode}-${appInfo.department.entryYear}'
        ])
        .orderBy("commentCount", descending: true)
        .orderBy("datePublished", descending: true)
        .getDocuments();
  }

  static deletePost(PostDTO post) async {
    var firestore = Firestore.instance;
    return await firestore.collection('posts').document(post.id).updateData(
        {'isDeleted': true, 'dateDeleted': FieldValue.serverTimestamp()});
  }
}
