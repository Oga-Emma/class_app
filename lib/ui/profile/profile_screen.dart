import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/auth/no_account_screen.dart';
import 'package:class_app/ui/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Profile", textAlign: TextAlign.center),
        ),
        body: appState.currentUser == null ? NoAccountScreen() : ProfilePage());
  }
}
