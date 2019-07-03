import 'date_event.dart';

class LectureDTO implements DateEvent{
  String courseId;
  String day;
  String startTime;
  String endTime;
  String venue;

  LectureDTO.fromJson(Map<String, dynamic> data)
      :
        courseId = data['courseId'] ?? "",
        day = data['day'] ?? "",
        startTime = data['startTime'] ?? "",
        endTime = data['endTime'] ?? "",
        venue = data['venue'] ?? "";

  Map<String, dynamic> toMap(){
    return<String, dynamic>{
      "courseId": courseId,
      "day": day,
      "startTime": startTime,
      "endTime": endTime,
      "venue": venue,
    };
}

  @override
  DateTime timeStamp;

}