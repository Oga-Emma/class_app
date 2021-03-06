import 'dart:async';

import 'package:class_app/model/user_dto.dart';
import 'package:class_app/service/user_dao.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/profile/no_profile_page.dart';
import 'package:class_app/ui/profile/profile_setup_page.dart';
import 'package:class_app/ui/router/router.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/widgets/empty_space.dart';
import 'package:class_app/ui/widgets/profile_avatar.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Material(
            color: ColorUtils.primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  ProfileAvatar(
                    radius: 32,
                    url: appState.user.profilePicture,
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
            visible: appState.isSuperAdmin,
            child: categoryGroup([
              ListTile(
                dense: true,
                title: Text("Admin Console"),
                subtitle: Text('App settings accross all users'),
                leading: Icon(Icons.verified_user),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Router.gotoNamed(Routes.ADMIN, context);
                },
              )
            ]),
          ),
          categoryGroup([
            ListTile(
              dense: true,
              title: Text("Swap School or Department"),
              subtitle: Text('Change school or department'),
              leading: Icon(Icons.swap_horizontal_circle),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Router.gotoNamed(Routes.SCHOOL_SELECT, context);
              },
            ),
//          ListTile(
//            title: Row(
//              children: <Widget>[
//                Text("Notification"),
//                emptySpace(),
//                Visibility(
//                  visible: false,
//                  child: CircleAvatar(
//                    radius: 12.0,
//                    child: Text('1',
//                        style: textStyle.caption.copyWith(color: Colors.white)),
//                  ),
//                )
//              ],
//            ),
//            leading: Icon(Icons.notifications),
//            trailing: Icon(Icons.chevron_right),
//            onTap: () {
//              Router.gotoNamed(Routes.NOTIFICATION, context);
//            },
//          ),
            ListTile(
              dense: true,
              title: Text('Preferences'),
              subtitle: Text('Personlaize your app settings'),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Router.gotoNamed(Routes.SETTINGS, context);
              },
            ),
//          ListTile(
//            title: Text("Downloads"),
//            trailing: Icon(Icons.chevron_right),
//          ),
          ]),
//          categoryGroup([
//            ListTile(
//              title: Text("Follow Department"),
//              subtitle: Text('Get notification from this department'),
//              leading: Icon(Icons.notifications_active),
//              trailing: FollowDepartmentCheck(),
//            ),
//          ]),
          categoryGroup([
            ListTile(
              dense: true,
              title: Text("Change Password"),
              subtitle: Text('Reset your login password'),
              leading: Icon(Icons.lock),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Router.gotoNamed(Routes.PASSWORD_RESET, context);
              },
            ),
            ListTile(
              dense: true,
              title: Text("Help and Support"),
              subtitle: Text('Get help and suggestions'),
              leading: Icon(Icons.help),
              trailing: Icon(Icons.chevron_right),
            ),
          ]),
          categoryGroup([
            ListTile(
              dense: true,
              onTap: () {
                Router.gotoNamed(Routes.HOME, context, clearStack: true);
                appState.logout();
              },
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
              trailing: Icon(Icons.exit_to_app, color: Colors.red),
            ),
          ])
        ],
      ),
    );
  }

  noProfile() {}
}

class FollowDepartmentCheck extends StatefulWidget {
  @override
  _FollowDepartmentCheckState createState() => _FollowDepartmentCheckState();
}

class _FollowDepartmentCheckState extends State<FollowDepartmentCheck> {
  var checked = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: checked,
        onChanged: (value) {
          setState(() {
            checked = value;
          });
        });
  }
}
