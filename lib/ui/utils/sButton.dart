import 'package:class_app/ui/helper_widgets/ca_button.dart';
import 'package:flutter/material.dart';

import 'color_utils.dart';

class SButton extends StatelessWidget {
  SButton({this.labelText, this.onTap});

  final String labelText;
  final Function() onTap;


  @override
  Widget build(BuildContext context) {
    return CAButton(title: labelText, onPressed: onTap);
    return Container(
      height: 48.0,
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)),
        color: ColorUtils.accentColor,
        child: Text(
          labelText,
          style: TextStyle(
              fontSize: 16.0, color: Colors.white),
        ), onPressed: onTap,
      ),
    );
  }


}
