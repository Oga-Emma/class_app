import 'package:class_app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';

import 'course_dto.dart';
import 'date_event.dart';

class EventDTO implements DateEvent{

  String id;
  String type;
  String time;
  String title;
  String courseId;
  String description;
  String venue;
  String date;
  CourseDTO course;

  bool deleted;

  EventDTO(){
    this.id = "";
    this.type = "";
    this.time = "";
    this.title = "";
    this.courseId = "";
    this.description = "";
    this.venue = "";
    this.date = "";
    this.deleted = false;
  }

  EventDTO.withId(String id){
    this.id = id;
    this.type = "";
    this.time = "";
    this.title = "";
    this.courseId = "";
    this.description = "";
    this.venue = "";
    this.date = "";
    this.deleted = false;
  }

  EventDTO.fromJson(Map<String, dynamic> data):
        id = data["id"] ?? "",
        type = data["type"] ?? "",
        time = data["time"] ?? "",
        title = data["title"] ?? "",
        description = data["description"] ?? "",
        courseId = data["courseId"] ?? "",
        venue = data["venue"] ?? "",
        date = data["date"] ?? "",
        course = CourseDTO.fromEvent(data["date"] ?? {}) ?? null,
        deleted = data["deleted"] ?? false,
  timeStamp = data["timeStamp"] ?? 0;

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      "id" : id,
      "type" : type,
      "time" : time,
      "title" : title,
      "description" : description,
      "courseId" : courseId,
      "venue" : venue,
      "date" : date,
      "deleted" : deleted,
      "course" : course.toMap(),
      "timeStamp" : timeStamp,
    };
  }

  @override
  int timeStamp = 0;

}

class EventType{
static const LECTURES = "Lectures";
static const ASSIGNEMTCA = "ASSIGNEMT & CA";
static const CLASS = "FIXED CLASS";
static const TEST = "TEST";
static const EXAM = "EXAM";
static const OTHERS = "OTHERS";
}


Map<String, Color> eventColors = {
  EventType.LECTURES: Colors.red,
  EventType.EXAM: ColorUtils.accentColor,
  EventType.TEST: Colors.yellow[500],
  EventType.ASSIGNEMTCA: Colors.teal,
  EventType.CLASS: ColorUtils.primaryColor,
  EventType.OTHERS: Colors.purple,
};

var eventList = [EventType.ASSIGNEMTCA, EventType.CLASS,
  EventType.TEST, EventType.EXAM, EventType.OTHERS];