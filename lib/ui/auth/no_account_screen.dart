import 'package:class_app/ui/helper_widgets/ca_button.dart';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/router/router.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';

class NoAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Expanded(child: Container()),
          EmptySpace(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CAButton(
                title: "Sign in",
                onPressed: () => Router.gotoNamed(Routes.LOGIN, context),
                outline: true),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CAButton(
                title: "Sign up",
                onPressed: () => Router.gotoNamed(Routes.SIGNUP, context)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
                child: Text("Terms of service",
                    style: TextStyle(color: ColorUtils.primaryColor)),
                onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
