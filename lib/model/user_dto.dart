class UserDTO {
  String id = "";
  String profilePicture = "";
  String firstName = "";
  String lastName = "";
  String email = "";
  String phoneNumber = "";
  String gender = "";
  String dateOfBirth = "";
  bool isSuperAdmin = false;
  AdminDTO admin;

  bool get noProfile => id == null || id.isEmpty;
  UserDTO();
  UserDTO.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    profilePicture = data['profilePicture'];
    firstName = data['firstName'];
    lastName = data['lastName'];
    email = data['email'];
    phoneNumber = data['phoneNumber'];
    gender = data['gender'];
    dateOfBirth = data['dateOfBirth'];
    isSuperAdmin = data['isSuperAdmin'] ?? false;

    if (data['admin'] != null) {
      admin = AdminDTO.fromMap(data['admin'] ?? {});
    }
  }

  String get fullName => firstName + " " + lastName;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profilePicture': profilePicture,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'dateOfBirth': dateOfBirth
    };
  }
}

class AdminDTO {
  bool isMainAdmin = false;
  String department;
  String entryYear;
  bool course;
  bool exco;
  bool forum;
  bool lecture;
  AdminDTO();
  AdminDTO.fromMap(Map<dynamic, dynamic> data) {
    department = data['department'];
    department = data['entryYear'];
    isMainAdmin = data['isMainAdmin'] ?? false;

    Map<dynamic, dynamic> privilages = data['privilages'];
    if (privilages != null) {
      course = privilages['course'] ?? false;
      exco = privilages['exco'] ?? false;
      forum = privilages['forum'] ?? false;
      lecture = privilages['lecture'] ?? false;
    }
  }
}

class Privilages {
  static String LECTURE = 'lecture';
  static String EXCO = 'lecture';
  static String FORUM = 'lecture';
  static String COURSE = 'lecture';
}
