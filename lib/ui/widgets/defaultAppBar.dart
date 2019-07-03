import 'package:flutter/material.dart';

Widget DefaultAppBar(String title, {elevation = 4.0}) {
  return AppBar(
    elevation: elevation,
    title: Text(title),
  );
}
