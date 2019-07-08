import 'dart:async';

import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/lecture_dto.dart';
import 'package:class_app/service/lecture_dao.dart';
import 'package:class_app/ui/admin/select_course_dialog.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/utils/fixed_dropdown.dart';
import 'package:class_app/ui/utils/helper_methods.dart';
import 'package:class_app/ui/utils/sButton.dart';
import 'package:class_app/ui/utils/sTextField.dart';
import 'package:class_app/ui/utils/sTimePicker.dart';
import 'package:class_app/ui/utils/ui_snackbar.dart';
import 'package:class_app/ui/utils/validators.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEditLectures extends StatefulWidget {
  AddEditLectures(this.lecture);
  LectureDTO lecture;

  @override
  _AddEditLecturesState createState() => _AddEditLecturesState();
}

class _AddEditLecturesState extends State<AddEditLectures>  with UISnackBarProvider {

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var startTime = TextEditingController();
  var endTime = TextEditingController();
  CourseDTO selectedCourse;
  var courseController = TextEditingController();
  var _day = Days.MONDAY;
  var dayError = false;

  var days = [Days.MONDAY, Days.TUESDAY, Days.WEDNESDAY,
    Days.THURSDAY, Days.FRIDAY, Days.SATURDAY];

  @override
  void initState() {

    if(widget.lecture.course != null) {
      _day = getDayLabel(widget.lecture.day);
      courseController.text = widget.lecture.course.code;
      startTime.text = widget.lecture.startTime;
      endTime.text = widget.lecture.endTime;
      selectedCourse = widget.lecture.course;
    }

    super.initState();
  }

  @override
  void dispose() {

    courseController.dispose();
    startTime.dispose();
    endTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text("Lecture Details", textAlign: TextAlign.center)),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
              onTap: () {
                showCourseChooser();},
          child: Container(
            color: Colors.transparent,
            child: IgnorePointer(
              child: STextField(
                label: "COURSE",
                onSaved: (value) {
                  widget.lecture.course = selectedCourse;
                },
                controller: courseController,
                textInputType: TextInputType.text,
                validator: Validators.validateString(),
              ),
            ),
          )),
              gap,
              gap,
              Stack(
                children: <Widget>[
                  Container(height: 60),
                  Positioned(
                    top: 8.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      padding: EdgeInsets.only(left: 12.0, right: 12.0),
//                            width: double.infinity,
                      child: FixedDropdownButton<String>(
                        hint: Text('Select the day of week'),
                        value: _day,
                        items: days.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(child: Text(value)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _day = value;
                          });
                        },
                      ),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: dayError ? Colors.red : Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: 8.0,
                      child: Container(
                          padding: EdgeInsets.only(left: 4.0, right: 4.0),
                          color: Colors.grey[50],
                          child: Text("LECTURE DAY",
                              style: TextStyle(fontSize: 12.0)))),
                ],
              ),
              gap,
              gap,
              Row(
                children: <Widget>[
                  Expanded(
                    child: STimePicker(
                      InputType.time,
                      controller: startTime,
                      label: "TIME START",
                      onChanged: (dt) {
                        widget.lecture.startTime = DateFormat("Hm").format(dt);
                            //"${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
                      },
                      textInputType: TextInputType.text,
                      validator: Validators.validateString(),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: STimePicker(
                      InputType.time,
                      controller: endTime,
                      label: "TIME END",
                      onChanged: (dt) {
                        widget.lecture.endTime = DateFormat("Hm").format(dt);
                        //"${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
                      },
                      textInputType: TextInputType.text,
                              validator: Validators.validateString(),
                    ),
                  ),
                ],
              ),
              gap,
              gap,
              STextField(
                initialValue: widget.lecture.venue,
                label: "VENUE",
                onSaved: (value){
                  widget.lecture.venue = value;
                },
                validator: (value){
                  if(value.isEmpty){
                    return "Please enter lecture venue";
                  }
                  return null;
                },
              ),
              gap,
              gap,
              SButton(labelText: "SAVE CHANGES", onTap: saveChanges),
            ],
          ),
        ),
      ),
    );
  }

  showCourseChooser() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SelectCourse(onCourseSelected: (course){
            selectedCourse = course;
            courseController.text = selectedCourse.code;
            Navigator.pop(context);
          },);
        });
  }

  saveChanges() {
    if( startTime.text.isEmpty || endTime.text.isEmpty){
      showInSnackBar("Select lecture start time and end time");
      return;
    }else{
      widget.lecture.startTime = startTime.text;
      widget.lecture.endTime = endTime.text;
      widget.lecture.day = getDay(_day);
    }

    if(_formKey.currentState.validate()){
      _formKey.currentState.save();

      showLoadingSnackBar();
      LectureDAO.saveLecture(widget.lecture, selectedCourse, (success){
        if(success){
          showInSnackBar("Changes saved");
          if(mounted) {
            Future.delayed(Duration(seconds: 2), () => Navigator.pop(context));
          }

        }else{
          showInSnackBar("Error saving changes, please check your network and try again");
        }
      });

    }else{
      showInSnackBar("Please review the errors in red");
    }
  }

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
}

class DayOfWeek{
  String label;
  int day;
}

class Days{
  static const MONDAY = "Monday";
  static const TUESDAY = "Tuesday";
  static const WEDNESDAY = "Wednesday";
  static const THURSDAY = "Thursday";
  static const FRIDAY = "Friday";
  static const SATURDAY = "Saturday";
}
