class CourseDTO{
  String id;
  String code;
  String unitLoad;
  String type;
  String title;
  String department;
  bool deleted;
  String faculty;
  List<String> lecturers;

  CourseDTO(){
    id =  "";
    code = "";
    type = "";
    unitLoad = "";
    title = "";
    department = "";
    faculty = "";
    lecturers = [];
  }


  CourseDTO.fromJson(Map<String, dynamic> data)
      :
        id = data['id'] ?? "",
        unitLoad = data['unitLoad'] ?? "",
        type = data['type'] ?? "",
        code = data['code'] ?? "",
        title = data['title'] ?? "",
  deleted = data['deleted'] ?? false;

  Map<String, dynamic> toMap(){
    return<String, dynamic>{
      "id": id,
      "unitLoad": unitLoad,
      "type": type,
      "code": code,
      "title": title,
      "deleted": deleted,
    };
  }

}