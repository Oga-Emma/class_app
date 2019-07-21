import 'dart:async';

import 'package:class_app/model/course_dto.dart';
import 'package:class_app/model/event_dto.dart';
import 'package:class_app/service/event_dao.dart';
import 'package:class_app/ui/admin/select_course_dialog.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/utils/fixed_dropdown.dart';
import 'package:class_app/ui/utils/sButton.dart';
import 'package:class_app/ui/utils/sTextField.dart';
import 'package:class_app/ui/utils/sTimePicker.dart';
import 'package:class_app/ui/utils/ui_snackbar.dart';
import 'package:class_app/ui/utils/validators.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEditEvent extends StatefulWidget {
  AddEditEvent(this.event);
  EventDTO event;

  @override
  _AddEditEventState createState() => _AddEditEventState();
}

class _AddEditEventState extends State<AddEditEvent> with UISnackBarProvider {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var eventTypeError = false;
  var _eventType = EventType.ASSIGNEMTCA;
  CourseDTO selectedCourse = CourseDTO();
  var courseController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var selectedDate = DateTime.now();

  @override
  void initState() {
    if(widget.event.type.isNotEmpty){
    _eventType = widget.event.type;
    }
//    selectedCourse = widget.event.course;
    courseController.text = widget.event.courseId;
    timeController.text = widget.event.time;
    dateController.text = widget.event.date;

    super.initState();
  }

  @override
  void dispose() {
    courseController.dispose();
    timeController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text("Event Details", textAlign: TextAlign.center)),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
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
                        hint: Text('Select the event type'),
                        value: _eventType,
                        items: eventList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(child: Text(value)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _eventType = value;
                          });
                        },
                      ),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: eventTypeError ? Colors.red : Colors.grey),
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
                          child: Text("EVENT TYPE",
                              style: TextStyle(fontSize: 12.0)))),
                ],
              ),
              gap,
              gap,
//              _eventType == EventType.OTHERS
                  STextField(
                    initialValue: widget.event.title,
                      label: "TITLE",
                      onSaved: (value) {
                        widget.event.title = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter event title";
                        }
                        return null;
                      },
//              hint: "Course Code",
                    ),
          gap2x,
          _eventType == EventType.OTHERS ? SizedBox() :
                   GestureDetector(
                      onTap: () {
                        showCourseChooser();
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: IgnorePointer(
                          child: STextField(
                            label: "COURSE",
                            onSaved: (value) {
                              widget.event.courseId = value;
                            },
                            controller: courseController,
                            textInputType: TextInputType.text,
                            validator: Validators.validateString(),
                          ),
                        ),
                      )),
              gap,
              gap,
              STextField(
                initialValue: widget.event.description,
                label: "DESCRIPTION",
                onSaved: (value) {
                  widget.event.description = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter a description of the event";
                  }
                  return null;
                },
//              hint: "Course Code",
              ),
              gap,
              gap,
              Row(
                children: <Widget>[
                  Expanded(
                    child: STimePicker(
                      InputType.date,
                      controller: dateController,
                      label: "DATE",
                      onChanged: (dt) {
                        if (dt != null) {
                          selectedDate = dt;
                          widget.event.date =
                              DateFormat('yyyy-MM-dd').format(dt);
                          widget.event.timeStamp = dt.millisecondsSinceEpoch;
                          print(dt.millisecondsSinceEpoch);
                        }
                      },
                      textInputType: TextInputType.text,
                      validator: Validators.validateString(),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: STimePicker(
                      InputType.time,
                      controller: timeController,
                      label: "TIME",
                      onChanged: (dt) {
//                        print("Date changed => ${DateFormat("Hm").format(dt)}");
                        widget.event.time = DateFormat("Hm").format(dt);
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
                initialValue: widget.event.venue,
                label: "VENUE",
                onSaved: (value) {
                  widget.event.venue = value;
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
          return SelectCourse(
            onCourseSelected: (course) {
              selectedCourse = course;
              courseController.text = selectedCourse.code;
              Navigator.pop(context);
            },
          );
        });
  }

  saveChanges() {
    if (dateController.text.isEmpty) {
      showInSnackBar("Select select event date");
      return;
    }

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      widget.event.date = dateController.text;
      widget.event.time = timeController.text;
      widget.event.courseId = courseController.text;
      widget.event.timeStamp = selectedDate.millisecondsSinceEpoch;
      widget.event.type = _eventType;

//      print(widget.event.toMap());
      showLoadingSnackBar();

      EventDAO.savEvent(widget.event, selectedCourse, (success) {
        if (success) {
          showInSnackBar("Changes saved");
          Future.delayed(Duration(seconds: 2), () => Navigator.pop(context));
        } else {
          showInSnackBar(
              "Error saving changes, please check your network and try again");
        }
      });
    } else {
      showInSnackBar("Please review the errors in red");
    }
  }

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
}
