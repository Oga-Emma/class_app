import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

import 'color_utils.dart';

class STimePicker extends StatelessWidget {
  STimePicker(
      this.inputType,
      {this.label,
        this.validator,
        this.onSaved,
        this.textInputType,
        this.controller,
        this.initialValue});

InputType inputType;
String label;
Function(String) validator;
Function(String) onSaved;
TextInputType textInputType;
TextEditingController controller;
String initialValue;

  final formats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };

  @override
  Widget build(BuildContext context) {
    return DateTimePickerFormField(
      inputType: inputType,
      format: formats[inputType],
      editable: false,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 16.0),
        helperStyle: TextStyle(fontSize: 16.0),
        hintStyle: TextStyle(fontSize: 16.0),
        contentPadding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(8.0)),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorUtils.accentColor),
            borderRadius: BorderRadius.circular(8.0)),
      ),
//
//          decoration: InputDecoration(
//              labelText: 'Date/Time',
//              hasFloatingPlaceholder: false),
      onChanged: (dt) {
        onSaved("${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}");
      },
    );
  }

}
