import 'package:class_app/service/app_info_dao.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/auth/base_auth.dart';
import 'package:class_app/ui/helper_widgets/ca_button.dart';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/helper_widgets/toast_helper.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/error_handler.dart';
import 'package:class_app/ui/utils/sTextField.dart';
import 'package:class_app/ui/utils/ui_snackbar.dart';
import 'package:class_app/ui/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GeneralInfo extends StatefulWidget {
  @override
  _GeneralInfoState createState() => _GeneralInfoState();
}

class _GeneralInfoState extends State<GeneralInfo>
    with BaseAuth, UISnackBarProvider, ErrorHandler {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  var editMode = false;

  var currentLevel;
  var currentSemester;
  var currentSession;

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
                        currentLevel = int.parse(value);
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
                          currentSession = value;
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
                          currentSemester = int.parse(value);
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
    if (!editMode) {
      setState(() {
        editMode = true;
      });
      return;
    }

    var updateData = <String, dynamic>{
      'currentLevel': currentLevel,
      'currentSemester': currentSemester,
      'currentSession': currentSession
    };
    try {
      AppInfoDAO.updateDepartment(updateData, appState.appInfo);
      var department = appState.appInfo.department;
      department
        ..currentLevel = currentLevel
        ..currentSemester = currentSemester
        ..currentSession = currentSession;
      appState.appInfo.department = department;
      showSuccessToast('Changes saved');
    } catch (err) {
      print(err);
      showErrorToast(err.message);
    }
  }

  modifyDisabledFields() {
    showDialog(
        context: context, builder: (context) => ModifyDisabledFieldsDialog());
  }
}

class ModifyDisabledFieldsDialog extends StatefulWidget {
  @override
  _ModifyDisabledFieldsDialogState createState() =>
      _ModifyDisabledFieldsDialogState();
}

class _ModifyDisabledFieldsDialogState
    extends State<ModifyDisabledFieldsDialog> {
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'To prevent unauthorized data modification, you can\'t modify private fields directly. Please send us an email or voice call bellow to modify data.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.body2.copyWith(height: 1.5),
          ),
          EmptySpace(
            multiple: 2,
          ),
          CAButton(title: 'SEND EMAIL', onPressed: _sendMail),
          EmptySpace(),
          CAButton(
              title: 'CALL ADMINISTRATOR', onPressed: _call, outline: true),
        ],
      ),
    ));
  }

  _call() async {
    const url = 'tel:+234 701 244 6202';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendMail() async {
    const url =
        'mailto:sevenapps2018@gmail.com?subject=Modification%of%disabled%field%on%Class%App&body=New%20plugin';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
