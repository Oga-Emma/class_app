import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {

  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    var textStyle = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
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
                        Text('Ani Emmanuel',
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
                            onTap: () {})),
                  )
                ],
              ),
            ),
          ),
          categoryGroup([
            ListTile(
              title: Text("Admin Console"),
              trailing: Icon(Icons.verified_user),
            )
          ]),
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
              title: Text("Logout"),
              trailing: Icon(Icons.exit_to_app),
            ),
          ])
        ],
      ),
    );
  }

  Widget categoryGroup(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        child: Column(children: children),
      ),
    );
  }
}
