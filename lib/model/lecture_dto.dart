import 'course_dto.dart';
import 'date_event.dart';

class LectureDTO implements DateEvent{
  String id;
  int day;
  String startTime;
  String endTime;
  String venue;
  CourseDTO course;

  LectureDTO(){
    id = "";
    day = 1;
    startTime = "";
    endTime = "";
    venue = "";
  }
  LectureDTO.withId(String id){
    this.id = id;
    day = 1;
    startTime = "";
    endTime = "";
    venue = "";
  }

  LectureDTO.fromJson(Map<String, dynamic> data)
      :
        id = data['id'] ?? "",
        day = data['day'] ?? 1,
        startTime = data['startTime'] ?? "",
        endTime = data['endTime'] ?? "",
        venue = data['venue'] ?? "",
        course = CourseDTO.fromEvent(data['course'] ?? {}) ?? null;

  Map<String, dynamic> toMap(){
    return<String, dynamic>{
      "id": id,
      "day": day,
      "startTime": startTime,
      "endTime": endTime,
      "venue": venue,
      "course": course.toMap(),
    };
}

  @override
  int timeStamp;

}