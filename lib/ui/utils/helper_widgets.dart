import 'dart:io';

import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/loading_spinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget raisedButtonWrapper({String labelText, Function onPressed}) {
  return Expanded(
    child: SizedBox(
      height: 42.0,
      child: FlatButton(
        color: Colors.transparent,
        onPressed: onPressed,
        shape: StadiumBorder(
            side: BorderSide(color: Colors.grey[400].withOpacity(0.5))),
//            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Text(labelText,
            style: TextStyle(color: ColorUtils.accentColor, fontSize: 16.0)),
      ),
    ),
  );
}

Widget Loading() {
  return Center(child: LoadingSpinner());
}

void showError(
    {String message =
        "Error fetching data, make sure you have a working internet connection"}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: ColorUtils.accentColor,
      textColor: Colors.white);
}

void showLongErrorToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: ColorUtils.primaryColor.withOpacity(0.5),
      textColor: Colors.white);
}

void showShortToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: ColorUtils.accentColor,
      textColor: Colors.white);
}

Widget emptySpace({multiple: 1.0}) {
  var size = 8.0 * multiple;
  return SizedBox(height: size, width: size);
}
