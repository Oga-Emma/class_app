import 'package:class_app/model/user_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentDTO {
  UserDTO user = UserDTO();
  String id;
  String posterId;
  String comment;
  var dateCreated;
  bool isDeleted = false;
  List<dynamic> likes = [];

  CommentDTO() {}

  CommentDTO.fromJson(Map<String, dynamic> data)
      : id = data['id'] ?? "",
        posterId = data['posterId'] ?? "",
        comment = data['comment'] ?? "",
        dateCreated = data['dateCreated'] ?? Timestamp.now(),
        isDeleted = data['isDeleted'],
        likes = data['likes'] ?? [];

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "comment": comment,
      "posterId": posterId,
      "dateCreated": FieldValue.serverTimestamp(),
      "likes": likes,
      "isDeleted": isDeleted,
    };

    return map;
  }
}
