class UserDTO {
  String id = "";
  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNumber = "";
  String gender = "";
  String dateOfBirth = "";
  bool isAdmin;
  bool isSuperAdmin;
  var adminPrivilages;

  bool get noProfile => id == null || id.isEmpty;
  UserDTO();
  UserDTO.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    firstName = data['firstName'];
    lastName = data['lastName'];
    email = data['email'];
    phoneNumber = data['phoneNumber'];
    gender = data['gender'];
    dateOfBirth = data['dateOfBirth'];
    isSuperAdmin = data['isSuperAdmin'] ?? false;
    isAdmin = data['isAdmin'] ?? false;
  }

  String get fullName => firstName + " " + lastName;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'dateOfBirth': dateOfBirth
    };
  }
}
