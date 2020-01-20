class UserDTO {
  String id = "";
  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNumber = "";
  String gender = "";
  String dateOfBirth = "";

  bool get noProfile => id == null || id.isEmpty;
  UserDTO();
  UserDTO.fromMap(Map<String, dynamic> data) {
    id = 'id';
    firstName = 'firstName';
    lastName = 'lastName';
    email = 'email';
    phoneNumber = 'phoneNumber';
    gender = 'gender';
    dateOfBirth = 'dateOfBirth';
  }

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
