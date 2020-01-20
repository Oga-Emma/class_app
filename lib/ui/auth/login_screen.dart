import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/auth/base_auth.dart';
import 'package:class_app/ui/helper_widgets/ca_button.dart';
import 'package:class_app/ui/helper_widgets/empty_space.dart';
import 'package:class_app/ui/router/router.dart';
import 'package:class_app/ui/router/routes.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:class_app/ui/utils/error_handler.dart';
import 'package:class_app/ui/utils/ui_snackbar.dart';
import 'package:class_app/ui/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget with BaseAuth {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
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
          elevation: 0.0,
          backgroundColor: Colors.grey[200],
          brightness: Brightness.light,
          iconTheme: IconThemeData(color: Colors.grey[700]),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  EmptySpace(),
                  Text("Log In", style: Theme.of(context).textTheme.headline),
                  EmptySpace(multiple: 3),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) {
                        email = value;
                      },
                      validator: Validators.validateEmail(),
                      decoration: InputDecoration(labelText: "Email")),
                  EmptySpace(multiple: 3),
                  TextFormField(
                      decoration: InputDecoration(labelText: "Password"),
                      onSaved: (value) {
                        password = value;
                      },
                      validator: Validators.validateSimplePassword()),
                  EmptySpace(multiple: 5),
                  CAButton(title: "Sign In", onPressed: signIn),
                  EmptySpace(multiple: 2),
                  Wrap(
                    children: <Widget>[
                      EmptySpace(multiple: 2),
                      Text("Dont have an account?"),
                      EmptySpace(),
                      InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Text("Signup here",
                              style:
                                  TextStyle(color: ColorUtils.primaryColor))),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      showLoadingSnackBar();

      try {
        var user =
            await signInWithEmailAndPassword(email.trim(), password.trim());
        appState.currentUser = user;
        Router.gotoNamed(Routes.SPLASH, context, clearStack: true);
      } catch (err) {
        print(err);

        showInSnackBar(getErrorMessage(err));
      }
    }
  }
}
