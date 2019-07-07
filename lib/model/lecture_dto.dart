import 'package:uuid/uuid.dart';

import 'date_event.dart';

class LectureDTO implements DateEvent{
  String id;
  String courseCode;
  String courseId;
  int day;
  String startTime;
  String endTime;
  String venue;

  LectureDTO(){
    id = "";
    courseCode = "";
    courseId = "";
    day = 1;
    startTime = "";
    endTime = "";
    venue = "";
  }
  LectureDTO.withId(String id){
    this.id = id;
    courseCode = "";
    courseId = "";
    day = 1;
    startTime = "";
    endTime = "";
    venue = "";
  }

  LectureDTO.fromJson(Map<String, dynamic> data)
      :
        id = data['id'] ?? "",
        courseCode = data['courseCode'] ?? "",
        courseId = data['courseId'] ?? "",
        day = data['day'] ?? 1,
        startTime = data['startTime'] ?? "",
        endTime = data['endTime'] ?? "",
        venue = data['venue'] ?? "";

  Map<String, dynamic> toMap(){
    return<String, dynamic>{
      "courseCode": courseCode,
      "id": id,
      "courseId": courseId,
      "day": day,
      "startTime": startTime,
      "endTime": endTime,
      "venue": venue,
    };
}

  @override
  int timeStamp;

}