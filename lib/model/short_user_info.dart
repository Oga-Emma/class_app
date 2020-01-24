import 'package:class_app/model/user_dto.dart';

class ShortUserInfo {
  String id;
  String name = "";
  String profilePicture = "";

  ShortUserInfo();

  ShortUserInfo.fromJson(Map<dynamic, dynamic> data) {
    id = data["id"] ?? "";
    name = data["name"] ?? "";
    profilePicture = data["photoUrl"] ?? "";
  }

  ShortUserInfo.fromUser(UserDTO user)
      : id = user.id,
        name = "${user.fullName}",
        profilePicture = user.profilePicture;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "profilePicture": profilePicture,
    };
  }
}
