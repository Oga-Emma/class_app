class CourseDTO{
  String id;
  String code;
  String title;
  String department;
  String faculty;
  List<String> lecturers;

  CourseDTO.fromJson(Map<String, dynamic> data)
      :
        id = data['id'] ?? "",
        code = data['code'] ?? "",
        title = data['title'] ?? "",
        department = data['department'] ?? "",
        faculty = data['faculty'] ?? "",
        lecturers = data['lecturers'] ?? "";

  Map<String, dynamic> toMap(){
    return<String, dynamic>{
      "id": id,
      "code": code,
      "title": title,
      "department": department,
      "faculty": faculty,
      "lecturers": lecturers,
    };
  }

}