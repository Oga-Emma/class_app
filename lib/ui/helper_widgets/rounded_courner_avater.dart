//import 'package:flutter/material.dart';
//import 'package:peepoe/ui/helper_widgets/empty_space.dart';
//
//class RoundedCornerAvatar extends StatelessWidget {
//  RoundedCornerAvatar(
//      {Key key, this.radius = 20, this.color = Colors.grey, this.child})
//      : super(key: key);
//  final double radius;
//  final Color color;
//  final Widget child;
//  @override
//  Widget build(BuildContext context) {
//    double size = radius * 2;
//    return ClipRRect(
//        borderRadius: BorderRadius.circular(8.0),
//        child:
//            Container(height: size, width: size, color: color, child: child));
//  }
//}