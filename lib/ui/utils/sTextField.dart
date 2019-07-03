import 'package:flutter/material.dart';

import 'color_utils.dart';

class STextField extends StatelessWidget {
  STextField({this.label, this.hint,
    this.enabled = true,
    this.focusNode,
    this.nextFocusNode,
    this.inputAction,
    this.validator,
    this.onSaved,
    this.textInputType,
    this.controller,
    this.initialValue,
    this.maxLine = 1});

  String label;
  String hint;
  bool enabled;
  FocusNode focusNode;
  FocusNode nextFocusNode;
  TextInputAction inputAction;
  Function(String) validator;
  Function(String) onSaved;
  TextInputType textInputType;
  TextEditingController controller;
  String initialValue;
  int maxLine;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      textInputAction: inputAction,
      enabled: enabled,
      style: TextStyle(fontSize: 16.0, color: Colors.black),
//          autofocus: true,
      onSaved: onSaved,
//          onFieldSubmitted: (tem){
//            _fieldFocusChange(context, focusNode, nextFocusNode);
//          },
      validator: validator,
      keyboardType: textInputType,
      autovalidate: _autoValidate,
      controller: controller,
      maxLines: maxLine,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 16.0),
        helperStyle: TextStyle(fontSize: 16.0),
        hintStyle: TextStyle(fontSize: 16.0),
        hintText: hint,
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
    );
  }

  bool _autoValidate = false;
}

