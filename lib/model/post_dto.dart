import 'dart:io';

import 'package:class_app/model/short_user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostDTO {
  String id = "";
  String course;
  String heading = "";
  String content = "";
  String group;
  var dateModified;
  var datePublished;
  bool isDeleted = false;
  List<Media> medias = [];
  ShortUserInfo user = ShortUserInfo();
  List<dynamic> likes = [];
  List<dynamic> dislikes = [];
  int commentCount = 0;
  int get likeCount => likes.length;
  int get dislikeCount => dislikes.length;
  var tags = [];

  PostDTO();

  PostDTO.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    course = data['course'];
    heading = data['heading'];
    content = data['content'];
    dateModified = data['dateModified'] ?? Timestamp.now();
    datePublished = data['datePublished'] ?? Timestamp.now();
    isDeleted = data['isDeleted'];
    user = ShortUserInfo.fromJson(data['user'] ?? {});
    likes = data['likes'];
    dislikes = data['dislikes'];
    commentCount = data['commentCount'];
    tags = data['tags'];
    group = data['group'];

    if (data["medias"] != null) {
      data["medias"].forEach((att) {
//      print("attachment $att");
        medias.add(Media.fromJson(att));
      });
    }
  }

  Map<String, dynamic> toMap() {
    var map = {
      'id': id,
      'course': course,
      'heading': heading,
      'content': content,
      'dateModified': FieldValue.serverTimestamp(),
      'isDeleted': isDeleted ?? false,
      'medias': []..addAll(medias.map((md) => md.toMap())),
      'user': user.toMap(),
      'tags': tags,
      'group': group,
    };

    if (datePublished == null) {
      map['datePublished'] = FieldValue.serverTimestamp();
    }

    if (likes == null || likes.isEmpty) {
      map['likes'] = likes;
    }
    if (dislikes == null || dislikes.isEmpty) {
      map['dislikes'] = dislikes;
    }
    if (commentCount == null || commentCount == 0) {
      map['commentCount'] = commentCount;
    }
    return map;
  }

  getCategory() {
    if (course != null && course.isNotEmpty) {
      return course;
    }
    return 'GENERAL';
  }
}

class Media {
  String type;
//  String name;
  String content;
  File file;

  Media(this.type, {this.content, this.file});

  Media.fromJson(Map<dynamic, dynamic> data)
      : type = data['type'],
        content = data['content'];

  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "content": content,
    };
  }
}

class MediaTypes {
  static String IMAGE = "image";
  static String VIDEO = "video";
  static String AUDIO = "audio";
}

class Categories {
  static String EXAM = "exam";
  static String LECTURE = "lecture";
  static String FIXED_CLASS = "fixed class";
  static String GENERAL = "general";
  static String ANOUNCEMENT = "announcement";
}
