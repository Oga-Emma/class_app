import 'package:class_app/model/event_dto.dart';
import 'package:class_app/ui/utils/dimen.dart';
import 'package:class_app/ui/utils/fixed_dropdown.dart';
import 'package:class_app/ui/utils/sButton.dart';
import 'package:class_app/ui/utils/sTextField.dart';
import 'package:flutter/material.dart';

class AddEditEvent extends StatefulWidget {
  @override
  _AddEditEventState createState() => _AddEditEventState();
}

class _AddEditEventState extends State<AddEditEvent> {
  var eventTypeError = false;
  var _eventType = EventType.SUBMISSION;

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        _eventType == EventType.OTHERS ?
              STextField(
                label: "TITLE",
                onSaved: (value) {},
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please select course";
                  }
                  return null;
                },
//              hint: "Course Code",
              ) :
              STextField(
                label: "COURSE",
                onSaved: (value) {},
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please select course";
                  }
                  return null;
                },
//              hint: "Course Code",
              ),
              gap,
              gap,
              STextField(
                label: "DESCRIPTION",
                onSaved: (value) {},
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
              STextField(
                label: "VENUE",
                onSaved: (value) {},
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter venue";
                  }
                  return null;
                },
//              hint: "Course Code",
              ),gap,
              gap,
              STextField(
                label: "DATE",
                onSaved: (value) {},
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter date";
                  }
                  return null;
                },
//              hint: "Course Code",
              ),
              gap,
              gap,
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
