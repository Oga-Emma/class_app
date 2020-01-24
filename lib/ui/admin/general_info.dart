import 'package:class_app/ui/auth/base_auth.dart';
import 'package:class_app/ui/helper_widgets/ca_button.dart';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/error_handler.dart';
import 'package:class_app/ui/utils/ui_snackbar.dart';
import 'package:class_app/ui/utils/validators.dart';
import 'package:flutter/material.dart';

class GeneralInfo extends StatefulWidget {
  @override
  _GeneralInfoState createState() => _GeneralInfoState();
}

class _GeneralInfoState extends State<GeneralInfo>
    with BaseAuth, UISnackBarProvider, ErrorHandler {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Faculty"),
                onSaved: (value) {
//                    email = value;
                },
                validator: Validators.validateEmail(),
              ),
              EmptySpace(multiple: 2),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Department Name"),
                onSaved: (value) {
//                    email = value;
                },
                validator: Validators.validateEmail(),
              ),
              EmptySpace(multiple: 2),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Department Code"),
                onSaved: (value) {
//                    email = value;
                },
                validator: Validators.validateEmail(),
              ),
              EmptySpace(multiple: 2),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Entry Year"),
                onSaved: (value) {
//                    email = value;
                },
                validator: Validators.validateEmail(),
              ),
              EmptySpace(multiple: 2),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(labelText: "Current Level"),
                onSaved: (value) {
//                    email = value;
                },
                validator: Validators.validateEmail(),
              ),
              EmptySpace(multiple: 2),
              TextFormField(
//                    controller: passwordController,
                  decoration: InputDecoration(labelText: "Current Semester"),
                  onSaved: (value) {
//                      password = value;
                  },
                  validator: Validators.validateSimplePassword()),
              EmptySpace(multiple: 2),
              TextFormField(
//                    controller: passwordController,
                  decoration: InputDecoration(labelText: "Current Session"),
                  onSaved: (value) {
//                      password = value;
                  },
                  validator: Validators.validateSimplePassword()),
              EmptySpace(multiple: 2),
              TextFormField(
//                    controller: passwordController,
                  decoration: InputDecoration(labelText: "Study Duration"),
                  onSaved: (value) {
//                      password = value;
                  },
                  validator: Validators.validateSimplePassword()),
              EmptySpace(multiple: 2),
              CAButton(title: "Update Changes", onPressed: updateInfo),
            ],
          ),
        ),
      ),
    )));
  }

  updateInfo() {}
}
