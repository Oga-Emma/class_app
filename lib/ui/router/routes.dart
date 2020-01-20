import 'package:class_app/ui/auth/login_screen.dart';
import 'package:class_app/ui/auth/signup_screen.dart';
import 'package:class_app/ui/home_screen.dart';
import 'package:class_app/ui/profile/profile_setup_page.dart';
import 'package:class_app/ui/settings/initial_settings_screen.dart';
import 'package:class_app/ui/splash/fetch_data.dart';
import 'package:class_app/ui/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';

class Routes {
  static const String SPLASH = "/";
  static const String HOME = "/home";
  static const String SCHOOL_SELECT = "/school-select";
  static const String LOGIN = "/login";
  static const String SIGNUP = "/signup";
  static const String AUTH = "/auth";
  static const String PORTFOLIO = "/portfolio";
  static const String FETCH_DATA = "/fetch_data";
  static const String MY_PUBLICATION_SCREEN = "/my_publication_screen";
  static const String VIEW_MY_PUBLICATION = "/view_my_publication";
  static const String VIEW_PROFILE = "/view_my_profile";
  static const String EDIT_PROFILE = "/edit_profile";
  static const String MY_STORE = "/my_store";
  static const String NOTIFICATION = "/notification";

  static const String MY_REAL_ESTATE = "/my_real_estates";
  static const String SETTINGS = "/settings";

  static Map<String, Widget Function(BuildContext context)> get getRoutes => {
        SPLASH: (BuildContext context) => SplashScreen(),
        HOME: (BuildContext context) => HomeScreen(),
        LOGIN: (BuildContext context) => LoginScreen(),
        SIGNUP: (BuildContext context) => SignupScreen(),
        SCHOOL_SELECT: (BuildContext context) => InitialSettingsScreen(),
        FETCH_DATA: (BuildContext context) => FetchDataScreen(),
        EDIT_PROFILE: (BuildContext context) => ProfileSetupPage(),
      };
}
