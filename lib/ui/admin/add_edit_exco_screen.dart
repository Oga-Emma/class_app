import 'package:class_app/model/event_dto.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/utils/fixed_dropdown.dart';
import 'package:class_app/ui/utils/sButton.dart';
import 'package:class_app/ui/utils/sTextField.dart';
import 'package:flutter/material.dart';

class AddEditExco extends StatefulWidget {
  @override
  _AddEditExcoState createState() => _AddEditExcoState();
}

class _AddEditExcoState extends State<AddEditExco> {
  var excoTypeError = false;
  var genderError = false;
  var _gender = "MALE";
  var _excoType = "COURSE REP";

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exco Details", textAlign: TextAlign.center)),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 150,
                        width: 150,
                        color: Colors.red,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 150,
                        width: 150,
                        color: Colors.black.withOpacity(0.4),
                        child: InkWell(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Click to change", style: TextStyle(color: Colors.white),),
                              gap,
                              Icon(Icons.camera_alt, color: Colors.white,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              gapX2,
              gapX2,
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
                        hint: Text('Select the exco type'),
                        value: _excoType,
                        items: ["CLASS EXCO", "COURSE REP"].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(child: Text(value)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _excoType = value;
                          });
                        },
                      ),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: excoTypeError ? Colors.red : Colors.grey),
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
                          child: Text("EXCO TYPE",
                              style: TextStyle(fontSize: 12.0)))),
                ],
              ),
              gapX2,
              STextField(
                label: "FULL NAME",
                onSaved: (value) {},
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter full name";
                  }
                  return null;
                },
//              hint: "Course Code",
              ),
              gapX2,
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
                        hint: Text('Select gender'),
                        value: _gender,
                        items: ["MALE", "FEMALE", "OTHERS"].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: SizedBox(child: Text(value)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _gender = value;
                          });
                        },
                      ),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1.0,
                              style: BorderStyle.solid,
                              color: genderError ? Colors.red : Colors.grey),
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
                          child: Text("GENDER",
                              style: TextStyle(fontSize: 12.0)))),
                ],
              ),
              gapX2,
              STextField(
                label: "PHONE NUMBER",
                onSaved: (value) {},
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter phone number";
                  }
                  return null;
                },
//              hint: "Course Code",
              ),
              gapX2,
              STextField(
                label: "POST",
                onSaved: (value) {},
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter post";
                  }
                  return null;
                },
//              hint: "Course Code",
              ),
              gapX2,
              SButton(
                labelText: "SAVE CHANGES",
                onTap: () {
//                print("Button tapped");
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
