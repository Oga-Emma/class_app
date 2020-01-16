import 'package:class_app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';

class CAButton extends StatelessWidget {
  CAButton(
      {@required this.title, @required this.onPressed, this.outline = false});
  String title;
  Function() onPressed;
  bool outline;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      width: double.maxFinite,
      child: outline
          ? OutlineButton(
              color: ColorUtils.primaryColor,
              shape: StadiumBorder(),
              borderSide:
                  BorderSide(width: 1.5, color: ColorUtils.primaryColor),
              child: Text(
                title,
                style: TextStyle(color: ColorUtils.primaryColor),
              ),
              onPressed: onPressed)
          : FlatButton(
              color: ColorUtils.primaryColor,
              shape: StadiumBorder(),
              child: Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
              onPressed: onPressed),
    );
  }
}
