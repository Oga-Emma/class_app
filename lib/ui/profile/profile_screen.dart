import 'package:class_app/ui/auth/no_account_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Profile", textAlign: TextAlign.center),
        ),
        body: NoAccountScreen());
  }
}
