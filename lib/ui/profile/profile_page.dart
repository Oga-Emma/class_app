import 'dart:async';

import 'package:class_app/model/user_dto.dart';
import 'package:class_app/service/user_dao.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/profile/no_profile_page.dart';
import 'package:class_app/ui/profile/profile_setup_page.dart';
import 'package:class_app/ui/router/router.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class ProfilePage extends StatelessWidget {
  TextTheme textStyle;
  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    textStyle = Theme.of(context).textTheme;

//    print('current => ${appState.currentUser.uid}');
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: appState.user != null && !appState.user.noProfile
            ? buildBody(context, appState.user)
            : StreamBuilder<UserDTO>(
                stream: Observable.fromFuture(
                    UserDAO.getUser(appState.currentUser.uid)),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.noProfile) {
                      return NoProfilePage();
                    }
                    Future.delayed(
                        Duration.zero, () => appState.user = snapshot.data);
                    return buildBody(context, snapshot.data);
                  }

                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Center(child: Text('Network error, try again'));
                  }

                  return Center(child: CircularProgressIndicator());
                }));
  }

  Widget categoryGroup(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        child: Column(children: children),
      ),
    );
  }

  buildBody(BuildContext context, UserDTO user) {
    return Column(
      children: <Widget>[
        Material(
          color: ColorUtils.primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.grey,
                ),
                EmptySpace(multiple: 2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Hello',
                          style: textStyle.caption
                              .copyWith(color: Colors.grey[200])),
                      EmptySpace(multiple: .2),
                      Text('${user.fullName}',
                          style: textStyle.headline
                              .copyWith(fontSize: 18.0, color: Colors.white)),
                    ],
                  ),
                ),
                EmptySpace(),
                SizedBox(
                  height: 28,
                  width: 28,
                  child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.3),
                      child: InkWell(
                          child:
                              Icon(Icons.edit, color: Colors.white, size: 16),
                          onTap: () {
                            Router.gotoWidget(
                                ProfileSetupPage(user: user), context);
                          })),
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: appState.user.isAdmin,
          child: categoryGroup([
            ListTile(
              title: Text("Admin Console"),
              trailing: Icon(Icons.verified_user),
              onTap: (){
                Router.gotoNamed(Routes.ADMIN, context);
              },
            )
          ]),
        ),
        categoryGroup([
          ListTile(
            title: Text("Settings"),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text("Notifications"),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text("Downloads"),
            trailing: Icon(Icons.chevron_right),
          ),
        ]),
        categoryGroup([
          ListTile(
            title: Text("Change Password"),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text("Support"),
            trailing: Icon(Icons.chevron_right),
          ),
        ]),
        categoryGroup([
          ListTile(
            onTap: () {
              Router.gotoNamed(Routes.HOME, context, clearStack: true);
              appState.logout();
            },
            title: Text("Logout"),
            trailing: Icon(Icons.exit_to_app),
          ),
        ])
      ],
    );
  }

  noProfile() {}
}
