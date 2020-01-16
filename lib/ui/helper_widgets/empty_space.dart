import 'package:flutter/material.dart';

class EmptySpace extends StatelessWidget {
  EmptySpace(
      {Key key, this.multiple = 1, this.vSize = false, this.hSize = false})
      : super(key: key);
  final double multiple;
  final bool hSize;
  final bool vSize;

  @override
  Widget build(BuildContext context) {
    double size = 8.0 * multiple;
    return SizedBox(
      height: vSize ? 0.0 : size,
      width: hSize ? 0.0 : size,
    );
  }
}
