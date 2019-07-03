import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/utils/fixed_dropdown.dart';
import 'package:class_app/ui/utils/sButton.dart';
import 'package:class_app/ui/utils/sTextField.dart';
import 'package:flutter/material.dart';

class AddEditCourse extends StatefulWidget {
  @override
  _AddEditCourseState createState() => _AddEditCourseState();
}

class _AddEditCourseState extends State<AddEditCourse> {

  var _formKey = GlobalKey<FormState>();
  var _courseType = "COMPULSORY";
  bool courseTypeError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Course Details", textAlign: TextAlign.center)),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(

            children: <Widget>[
              STextField(
                label: "Course Code",
onSaved: (value){},
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
                label: "Course Title",
                onSaved: (value){},
                validator: (value){
                  if(value.isEmpty){
                    return "Please enter course title";
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
                        hint: Text('Select the event type'),
                        value: _courseType,
                        items: ["COMPULSORY", "OPTIONAL"].map((String value) {
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
              SButton(labelText: "Save Changes", onTap: (){
//                print("Button tapped");
                if(_formKey.currentState.validate()){
                  _formKey.currentState.save();
                }

              },),
            ],
          ),
        ),
      ),
    );
  }
}
