import 'date_event.dart';

class LectureDTO implements DateEvent{
  String id;
  String courseCode;
  int day;
  String startTime;
  String endTime;
  String venue;

  LectureDTO(){
    id = "";
    courseCode = "";
    day = 1;
    startTime = "";
    endTime = "";
    venue = "";
  }
  LectureDTO.withId(String id){
    this.id = id;
    courseCode = "";
    day = 1;
    startTime = "";
    endTime = "";
    venue = "";
  }

  LectureDTO.fromJson(Map<String, dynamic> data)
      :
        courseCode = data['courseCode'] ?? "",
        day = data['day'] ?? 1,
        startTime = data['startTime'] ?? "",
        endTime = data['endTime'] ?? "",
        venue = data['venue'] ?? "";

  Map<String, dynamic> toMap(){
    return<String, dynamic>{
      "courseCode": courseCode,
      "day": day,
      "startTime": startTime,
      "endTime": endTime,
      "venue": venue,
    };
}

  @override
  DateTime timeStamp;

}