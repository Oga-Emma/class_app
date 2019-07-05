class CourseDTO{
  String id;
  String code;
  String unitLoad;
  String type;
  String title;
  String department;
  bool deleted;
  String faculty;
  String lecturers;
  List<String> outline;

  CourseDTO(){
    id =  "";
    code = "";
    type = "";
    unitLoad = "";
    title = "";
    department = "";
    faculty = "";
    deleted = false;
    lecturers = "";
    outline = [];
  }

  CourseDTO.withId(String id): super(){
    this.id =  id;
    code = "";
    type = "";
    unitLoad = "";
    title = "";
    department = "";
    faculty = "";
    deleted = false;
    lecturers = "";
    lecturers = "";
    outline = [];
  }


  CourseDTO.fromJson(Map<String, dynamic> data)
      :
        id = data['id'] ?? "",
        unitLoad = data['unitLoad'] ?? "",
        type = data['type'] ?? "",
        code = data['code'] ?? "",
        title = data['title'] ?? "",
        faculty = data['faculty'] ?? "",
        department = data['department'] ?? "",
        lecturers = data['lecturers'] ?? "",
        outline = data['outline'] ?? [],
  deleted = data['deleted'] ?? false;

  Map<String, dynamic> toMap(){
    return<String, dynamic>{
      "id": id,
      "unitLoad": unitLoad,
      "type": type,
      "code": code,
      "title": title,
      "deleted": deleted,
      "department": department,
      "faculty": faculty,
      "lecturers": lecturers,
      "outline": outline,
    };
  }

}