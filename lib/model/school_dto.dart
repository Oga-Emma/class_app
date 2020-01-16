class SchoolDTO {
  String id;
  String name;
  String code;
  String state;
  SchoolDTO();
  SchoolDTO.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    code = data['code'];
    state = data['state'];
  }
}
