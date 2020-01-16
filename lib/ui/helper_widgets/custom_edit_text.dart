import 'package:flutter/material.dart';

import 'empty_space.dart';

class CustomEditText extends StatelessWidget {
  CustomEditText(
      {@required this.label,
      this.onSaved,
      this.validator,
      this.multiLine = false,
      this.initialValue,
      this.enabled});
  final String initialValue;
  final String label;
  final bool multiLine;
  final bool enabled;
  final Function(String value) onSaved;
  final Function(String value) validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label),
        EmptySpace(),
        TextFormField(
          enabled: enabled,
          initialValue: initialValue,
          minLines: multiLine ? 3 : 1,
          maxLines: multiLine ? 4 : 1,
          onSaved: onSaved,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
//                  focusColor: Colors.red,
            fillColor: Colors.grey[200],
            isDense: true,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[300]),
                borderRadius: BorderRadius.circular(8.0)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.circular(8.0)),
          ),
        ),
        EmptySpace(
          multiple: 3,
        )
      ],
    );
  }
}
