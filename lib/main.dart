import 'package:bot_toast/bot_toast.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/state/preference_state_provider.dart';
import 'package:class_app/ui/dashboard/dashboard.dart';
import 'package:class_app/ui/home_screen.dart';
import 'package:class_app/ui/router/routes.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() {

  configureLocalNotification();
  runApp(MyApp());}

Future<void> configureLocalNotification() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();
  // NOTE: if you want to find out if the app was launched via notification then you could use the following call and then do something like
  // change the default route of the app
  // var notificationAppLaunchDetails =
  //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
//  var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  var initializationSettingsIOS = IOSInitializationSettings(
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {
        print(body);
        debugPrint('notification payload: ' + payload);
//        didReceiveLocalNotificationSubject.add(ReceivedNotification(
//            id: id, title: title, body: body, payload: payload));
      });
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
//        selectNotificationSubject.add(payload);

      });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    return BotToastInit(
        child: MultiProvider(
      child: MaterialApp(
        navigatorObservers: [BotToastNavigatorObserver()],
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
    ));
  }
}
