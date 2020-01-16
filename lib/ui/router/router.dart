import 'package:flutter/material.dart';
export 'routes.dart';

class Router {
  static void gotoWidget(Widget screen, BuildContext context,
      {bool clearStack = false}) {
    !clearStack
        ? Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => screen))
        : Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => screen), (_) => false);
  }

  static void gotoNamed(String route, BuildContext context,
      {bool clearStack = false, dynamic args = Object}) {
    !clearStack
        ? Navigator.of(context).pushNamed(route, arguments: args)
        : Navigator.of(context).pushNamedAndRemoveUntil(route, (_) => false, arguments: args);
  }

  static void goBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
