import 'package:flutter/cupertino.dart';

Widget emptySpace({double multiple = 1}){
  double vhsize = 8.0 * multiple;
  return SizedBox(
    height: vhsize,
    width: vhsize,
  );
}