import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/auth/base_auth.dart';
import 'package:class_app/ui/helper_widgets/ca_button.dart';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/error_handler.dart';
import 'package:class_app/ui/utils/sTextField.dart';
import 'package:class_app/ui/utils/ui_snackbar.dart';
import 'package:class_app/ui/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneralInfo extends StatefulWidget {
  @override
  _GeneralInfoState createState() => _GeneralInfoState();
}

class _GeneralInfoState extends State<GeneralInfo>
    with BaseAuth, UISnackBarProvider, ErrorHandler {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  var editMode = false;

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
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
              STextField(
                initialValue: appState.department.faculty,
                enabled: false,
                textInputType: TextInputType.emailAddress,
                label: "Faculty",
                onSaved: (value) {
//                    email = value;
                },
                validator: Validators.validateEmail(),
              ),
              EmptySpace(multiple: 2),
              STextField(
                initialValue: appState.department.name,
                enabled: false,
                textInputType: TextInputType.emailAddress,
                label: "Department Name",
                onSaved: (value) {
//                    email = value;
                },
                validator: Validators.validateEmail(),
              ),
              EmptySpace(multiple: 2),
              STextField(
                initialValue: appState.department.departmentCode,
                enabled: false,
                textInputType: TextInputType.emailAddress,
                label: "Department Code",
                onSaved: (value) {
//                    email = value;
                },
                validator: Validators.validateEmail(),
              ),
              EmptySpace(multiple: 2),
              Row(
                children: <Widget>[
                  Expanded(
                    child: STextField(
                      initialValue: appState.department.entryYear,
                      enabled: false,
                      textInputType: TextInputType.datetime,
                      label: "Entry Year",
                      onSaved: (value) {
//                    email = value;
                      },
                      validator: Validators.validateEmail(),
                    ),
                  ),
                  EmptySpace(multiple: 2),
                  Expanded(
                    child: STextField(
                      initialValue: "${appState.department.currentLevel}",
                      enabled: editMode,
                      textInputType: TextInputType.number,
                      label: "Current Level",
                      onSaved: (value) {
//                    email = value;
                      },
                      validator: Validators.validateEmail(),
                    ),
                  ),
                ],
              ),
              EmptySpace(multiple: 2),
              Row(
                children: <Widget>[
                  Expanded(
                    child: STextField(
                        initialValue: appState.department.currentSession,
                        enabled: editMode,
//                    controller: passwordController,
                        label: "Current Session",
                        textInputType: TextInputType.datetime,
                        onSaved: (value) {
//                      password = value;
                        },
                        validator: Validators.validateString()),
                  ),
                  EmptySpace(multiple: 2),
                  Expanded(
                    child: STextField(
                        initialValue: "${appState.department.currentSemester}",
                        enabled: editMode,
                        textInputType: TextInputType.number,
//                    controller: passwordController,
                        label: "Semester",
                        onSaved: (value) {
//                      password = value;
                        },
                        validator: Validators.validateString()),
                  ),
                ],
              ),
              EmptySpace(multiple: 2),
              STextField(
                  initialValue: appState.department.studyDuration,
                  enabled: false,
//                    controller: passwordController,
                  label: "Study Duration",
                  onSaved: (value) {
//                      password = value;
                  },
                  validator: Validators.validateString()),
              EmptySpace(multiple: 2),
              CAButton(
                  title: editMode ? 'SAVE CHANGED' : "MODIFY INFO",
                  onPressed: updateInfo),
              EmptySpace(multiple: 2),
              Visibility(
                visible: editMode,
                child: CAButton(
                    title: 'MODIFY DISABLED FIELDS',
                    onPressed: modifyDisabledFields,
                    outline: true),
              ),
            ],
          ),
        ),
      ),
    )));
  }

  updateInfo() {
    setState(() {
      editMode = !editMode;
    });
  }

  modifyDisabledFields() {
  }
}
