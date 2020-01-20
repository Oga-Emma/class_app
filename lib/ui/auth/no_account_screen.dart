import 'package:class_app/ui/helper_widgets/ca_button.dart';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/router/router.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: ColorUtils.primaryColor,
          height: MediaQuery.of(context).size.height / 3,
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    EmptySpace(multiple: 3),
                    SvgPicture.asset(
                      'assets/svg/create_account.svg',
                      height: 100,
                      width: 100,
                    ),
                    EmptySpace(multiple: 3),
                    Text("You are not signed in",
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 20)),
                    Text("Please create an account or sign in below",
                        style: Theme.of(context).textTheme.caption),
                    EmptySpace(multiple: 2),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CAButton(
                          title: "Sign in",
                          onPressed: () =>
                              Router.gotoNamed(Routes.LOGIN, context),
                          outline: true),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CAButton(
                          title: "Sign up",
                          onPressed: () =>
                              Router.gotoNamed(Routes.SIGNUP, context)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                          child: Text("Change School or Department",
                              style: TextStyle(color: ColorUtils.primaryColor)),
                          onPressed: () {
                            Router.gotoNamed(Routes.SCHOOL_SELECT, context);
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
