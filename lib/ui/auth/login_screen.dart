import 'package:class_app/ui/helper_widgets/ca_button.dart';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.grey[200],
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.grey[700]),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                EmptySpace(),
                Text("Log In", style: Theme.of(context).textTheme.headline),
                EmptySpace(multiple: 3),
                TextFormField(decoration: InputDecoration(labelText: "Email")),
                EmptySpace(multiple: 3),
                TextFormField(
                    decoration: InputDecoration(labelText: "Password")),
                EmptySpace(multiple: 5),
                CAButton(title: "Sign In", onPressed: () {}),
                EmptySpace(multiple: 2),
                Row(
                  children: <Widget>[
                    EmptySpace(multiple: 2),
                    Text("Dont have an account?"),
                    EmptySpace(),
                    InkWell(onTap: () {}, child: Text("Signup here")),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
