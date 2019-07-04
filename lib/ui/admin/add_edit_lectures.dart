import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/utils/sButton.dart';
import 'package:class_app/ui/utils/sTextField.dart';
import 'package:class_app/ui/utils/sTimePicker.dart';
import 'package:class_app/ui/utils/validators.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';

class AddEditLectures extends StatefulWidget {
  @override
  _AddEditLecturesState createState() => _AddEditLecturesState();
}

class _AddEditLecturesState extends State<AddEditLectures> {

  var _formKey = GlobalKey<FormState>();
  var startTime = TextEditingController();
  var endTime = TextEditingController();
  @override
  void dispose() {
    startTime.dispose();
    endTime.dispose();
    super.dispose();
  }

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
              Row(
                children: <Widget>[
                  Expanded(
                    child: STimePicker(
                      InputType.time,
                      controller: startTime,
                      label: "Start time",
                      onSaved: (value) {
//                        print(value);
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
                      label: "End time",
                      onSaved: (value) {
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
