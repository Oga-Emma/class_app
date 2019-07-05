class PersonDTO {
  String id;
  String firstName = "";
  String lastName = "";
  String otherName = "";
  String gender = "";
  String post = "";
  String phone = "";
  String imageUrl = "";

  PersonDTO.withId(String id) : super() {
    this.id = id;
  }

  PersonDTO.fromJson(Map<String, dynamic> data)
      : id = data['id'] ?? "",
        firstName = data['firstName'] ?? "",
        lastName = data['lastName'] ?? "",
        gender = data['gender'] ?? "",
        otherName = data['otherName'] ?? "",
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
      "post": post,
      "phone": phone,
      "imageUrl": imageUrl,
    };
  }
}
