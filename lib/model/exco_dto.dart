class ExcoDTO {
  String id;
  String firstName = "";
  String lastName = "";
  String otherName = "";
  String type = "";
  String gender = "";
  String post = "";
  String phone = "";
  String imageUrl = "";

  ExcoDTO.withId(String id) : super() {
    this.id = id;
  }

  ExcoDTO.fromJson(Map<String, dynamic> data)
      : id = data['id'] ?? "",
        firstName = data['firstName'] ?? "",
        lastName = data['lastName'] ?? "",
        gender = data['gender'] ?? "",
        otherName = data['otherName'] ?? "",
        type = data['type'] ?? "",
        post = data['post'] ?? "",
        phone = data['phone'] ?? "",
        imageUrl = data['imageUrl'] ?? "";

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
      "gender": gender,
      "otherName": otherName,
      "type": type,
      "post": post,
      "phone": phone,
      "imageUrl": imageUrl,
    };
  }
}

class ExcoType{
  static String EXCO = "CLASS EXCO";
  static String COURSE_REP = "COURSE REP";
}

var excoList = [ExcoType.COURSE_REP, ExcoType.EXCO];
