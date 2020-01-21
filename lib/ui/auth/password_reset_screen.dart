import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/auth/base_auth.dart';
import 'package:class_app/ui/helper_widgets/ca_button.dart';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/router/router.dart';
import 'package:class_app/ui/router/routes.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/error_handler.dart';
import 'package:class_app/ui/utils/helper_widgets.dart';
import 'package:class_app/ui/utils/ui_snackbar.dart';
import 'package:class_app/ui/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PasswordResetScreen extends StatefulWidget with BaseAuth {
  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen>
    with BaseAuth, UISnackBarProvider, ErrorHandler {
  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  String email;
  String password;
  var passwordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text('Password Rest'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  EmptySpace(multiple: 3),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {
                        email = value;
                      },
                      validator: Validators.validateEmail(),
                      decoration: InputDecoration(labelText: "Email")),
                  EmptySpace(multiple: 3),
                  EmptySpace(multiple: 5),
                  CAButton(title: "Reset Password", onPressed: reset),
                  EmptySpace(multiple: 2),
                ],
              ),
            ),
          ),
        ));
  }

  reset() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      showLoadingSnackBar();

      try {
        await resetPassword(email.trim());
        closeLoadingSnackBar();
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Request successful',
                          style: Theme.of(context).textTheme.title),
                      emptySpace(),
                      Text(
                          'A password reset mail has been sent to your email, please check your mail box to complete your password reset',
                          textAlign: TextAlign.center),
                      emptySpace(),
                      Divider(),
                      CAButton(
                          title: 'Return to Home',
                          onPressed: () => Router.gotoNamed(
                              Routes.HOME, context,
                              clearStack: true))
                    ],
                  ),
                ));
      } catch (err) {
        print(err);

        showInSnackBar(getErrorMessage(err));
      }
    }
  }
}
