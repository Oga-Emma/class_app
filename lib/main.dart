import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/state/preference_state_provider.dart';
import 'package:class_app/ui/dashboard/dashboard.dart';
import 'package:class_app/ui/home_screen.dart';
import 'package:class_app/ui/router/routes.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        title: 'Class App',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.red,
            primaryColor: ColorUtils.primaryColor,
            accentColor: ColorUtils.accentColor),
        routes: Routes.getRoutes,
//      home: HomeScreen(),
//      MyHomePage(title: 'Flutter Demo Home Page'),
      ),
      providers: [
        ChangeNotifierProvider<AppStateProvider>(
          create: (context) => AppStateProvider(),
        ),
        ChangeNotifierProvider<PreferenceStateProvider>(
          create: (context) => PreferenceStateProvider(),
        ),
      ],
    );
  }
}
