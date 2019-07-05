import 'package:class_app/ui/admin/add_edit_lectures.dart';

int getDay(String day) {
  switch(day){
    case Days.MONDAY: return 1;
    case Days.TUESDAY: return 2;
    case Days.WEDNESDAY: return 3;
    case Days.THURSDAY: return 4;
    case Days.FRIDAY: return 5;
    case Days.SATURDAY: return 6;
    default: return 1;
  }
}
String getDayLabel(int day) {
  switch(day){
    case 1: return Days.MONDAY;
    case 2: return Days.TUESDAY;
    case 3: return Days.WEDNESDAY;
    case 4: return Days.THURSDAY;
    case 5: return Days.FRIDAY;
    case 6: return Days.SATURDAY;
    default: return Days.MONDAY;
  }
}