import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/utils/sButton.dart';
import 'package:class_app/ui/utils/sTextField.dart';
import 'package:flutter/material.dart';

class AddEditLectures extends StatefulWidget {
  @override
  _AddEditLecturesState createState() => _AddEditLecturesState();
}

class _AddEditLecturesState extends State<AddEditLectures> {

  var _formKey = GlobalKey<FormState>();

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
                label: "Course",
                onSaved: (value){},
                validator: (value){
                  if(value.isEmpty){
                    return "Please enter course code";
                  }
                  return null;
                },
              ),
              gap,
              gap,
              /*Row(
                children: <Widget>[
                  Expanded(
                    child: getTimePicker(
                      controller: weekdayOpen,
                      label: "Open",
                      onSaved: (value) {
                        user.weekendsOpen = value;
                      },
                      textInputType: TextInputType.text,
//                              validator: Validators.validateString(),
//                              initialValue: user.address,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: getTimePicker(
                      controller: weekdayClose,
                      label: "Close",
                      onSaved: (value) {
                        user.weekdaysClose = value;
                      },
                      textInputType: TextInputType.text,
//                              validator: Validators.validateString(),
//                              initialValue: user.address,
                    ),
                  ),
                ],
              ),
              gap,
              gap,*/
              STextField(
                label: "Venue",
                onSaved: (value){},
                validator: (value){
                  if(value.isEmpty){
                    return "Please enter lecture venue";
                  }
                  return null;
                },
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
