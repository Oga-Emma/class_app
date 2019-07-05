import 'dart:async';

import 'package:class_app/model/course_dto.dart';
import 'package:class_app/service/course_dao.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/utils/fixed_dropdown.dart';
import 'package:class_app/ui/utils/sButton.dart';
import 'package:class_app/ui/utils/sTextField.dart';
import 'package:class_app/ui/utils/ui_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddEditCourse extends StatefulWidget {
  AddEditCourse({@required this.course});
  final CourseDTO course;
  @override
  _AddEditCourseState createState() => _AddEditCourseState();
}

class _AddEditCourseState extends State<AddEditCourse> with UISnackBarProvider {

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  var _courseType;
  bool courseTypeError = false;

  @override
  void initState() {
    _courseType = widget.course.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Course Details", textAlign: TextAlign.center)),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(

            children: <Widget>[
              STextField(
                initialValue: widget.course.code,
                label: "Course Code",
onSaved: (value){
                  widget.course.code = value.toUpperCase();
},
                validator: (value){
                  if(value.isEmpty){
                    return "Please enter course code";
                  }
                  return null;
                },
//              hint: "Course Code",
              ),
              gap,
              gap,
              STextField(
                initialValue: widget.course.title,
                label: "Course Title",
                onSaved: (value){
                  widget.course.title = value.toUpperCase();},
                validator: (value){
                  if(value.isEmpty){
                    return "Please enter course title";
                  }
                  return null;
                },
//              hint: "Course Code",
              ), gap,
              gap,
              STextField(
                initialValue: widget.course.unitLoad,
                label: "Unit Load",
                textInputType: TextInputType.number,
                onSaved: (value){
                  widget.course.unitLoad = value.toUpperCase();},
                validator: (value){
                  if(value.isEmpty){
                    return "Please enter unit load";
                  }
                  return null;
                },
//              hint: "Course Code",
              ),
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
                        hint: Text('Select the course type'),
                        value: _courseType,
                        items: ["COMPULSORY", "GENERAL STUDIES", "ELECTIVE"].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(child: Text(value)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _courseType = value;
                          });
                        },
                      ),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: courseTypeError ? Colors.red : Colors.grey),
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
                          child: Text("COURSE TYPE",
                              style: TextStyle(fontSize: 12.0)))),
                ],
              ),
              gap,
              gap,
              SButton(labelText: "Save Changes", onTap: saveChanges,),
            ],
          ),
        ),
      ),
    );
  }

  saveChanges() {
    if(_courseType == null || _courseType.isEmpty){
      showInSnackBar("Please select course type");
      setState(() {
        courseTypeError = true;
      });
    }else{
      widget.course.type = _courseType.toUpperCase();
    }
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      showLoadingSnackBar();

      CourseDAO.saveCourse(widget.course, (success){
        if(success){
          showInSnackBar("Changes saved");
          Future.delayed(Duration(seconds: 2), () => Navigator.pop(context));

        }else{
          showInSnackBar("Error saving changes, please check your network and try again");
        }
      });

//      print(widget.course.toMap());
    }else{
      showInSnackBar("Please review the errors in red");
    }
  }

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
}
