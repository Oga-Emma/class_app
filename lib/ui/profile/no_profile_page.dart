import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/helper_widgets/ca_button.dart';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/router/router.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NoProfilePage extends StatelessWidget {
  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
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
                      'assets/svg/success.svg',
                      height: 100,
                      width: 100,
                    ),
                    EmptySpace(multiple: 3),
                    Text("You are almost there",
                        style: Theme.of(context)
                            .textTheme
                            .headline
                            .copyWith(fontSize: 20)),
                    EmptySpace(multiple: 2),
                    Text("One more step to go",
                        style: Theme.of(context).textTheme.body2),
                    Text("Click below to complete your profile setup below",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption),
                    EmptySpace(multiple: 2),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CAButton(
                          title: "Complete Profile Setup",
                          onPressed: () =>
                              Router.gotoNamed(Routes.EDIT_PROFILE, context)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CAButton(
                        title: "Logout",
                        outline: true,
                        onPressed: () {
                          appState.logout();
                          Router.gotoNamed(Routes.HOME, context,
                              clearStack: true);
                        },
                      ),
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
