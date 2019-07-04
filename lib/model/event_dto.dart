import 'date_event.dart';

class EventDTO implements DateEvent{
  String eventType;
  String title;
  String courseCode;
  String description;
  String venue;
  var date;

  @override
  DateTime timeStamp;

}

class EventType{
static const ASSIGNEMTCA = "ASSIGNEMT & CA";
static const CLASS = "CLASS";
static const TEST = "TEST";
static const EXAM = "EXAM";
static const OTHERS = "OTHERS";
}

var eventList = [EventType.ASSIGNEMTCA, EventType.CLASS,
  EventType.TEST, EventType.EXAM];