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
  String courseRep;
  List<dynamic> outline;
  List<dynamic> lectureIds;
  List<dynamic> eventIds;

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
    courseRep = "";
    outline = [];
    lectureIds = [];
    eventIds = [];
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
    courseRep = "";
    outline = [];
    lectureIds = [];
    eventIds = [];
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
        courseRep = data['courseRep'] ?? "",
        outline = data['outline'] ?? [],
        lectureIds = data['lectureIds'] ?? [],
        eventIds = data['eventIds'] ?? [],
  deleted = data['deleted'] ?? false;

  CourseDTO.fromEvent(Map<dynamic, dynamic> res){
    var data = Map<String, dynamic>.from(res);

    id = data['id'] ?? "";
    unitLoad = data['unitLoad'] ?? "";
    type = data['type'] ?? "";
    code = data['code'] ?? "";
    title = data['title'] ?? "";
    faculty = data['faculty'] ?? "";
    department = data['department'] ?? "";
    lecturers = data['lecturers'] ?? "";
    courseRep = data['courseRep'] ?? "";
    outline = data['outline'] ?? [];
    lectureIds = data['lectureIds'] ?? [];
    eventIds = data['lectureIds'] ?? [];
    deleted = data['deleted'] ??
    false;
  }

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
      "courseRep": courseRep,
      "outline": outline,
      "lectureIds": lectureIds,
      "eventIds": eventIds,
    };
  }

}