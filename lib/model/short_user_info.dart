import 'package:class_app/model/user_dto.dart';

class ShortUserInfo {
  String id;
  String name = "";
  String profilePicture = "";

  ShortUserInfo();

  ShortUserInfo.fromJson(Map<dynamic, dynamic> data) {
//    print(data);
    id = data["id"] ?? "";
    name = data["name"] ?? "";
    profilePicture = data["profilePicture"] ?? "";
  }

  ShortUserInfo.fromUser(UserDTO user)
      : id = user.id,
        name = "${user.fullName}",
        profilePicture = user.profilePicture;

  bool get isNull => id == null || id.isEmpty;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "profilePicture": profilePicture,
    };
  }
}
