import 'package:background_fetch/background_fetch.dart';
import 'package:class_app/main.dart';
import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/dashboard/courses.dart';
import 'package:class_app/ui/dashboard/dashboard.dart';
import 'package:class_app/ui/info_screen/info_screen.dart';
import 'package:class_app/ui/notification/notification_screen.dart';
import 'package:class_app/ui/profile/profile_screen.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'calendar/calender_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [];

//  static var unselectedColor = ColorUtils.primaryColor.withOpacity(0.7);
  static var unselectedColor = Colors.grey[600];
  static var size = 20.0;
  static var selectedSize = 20.0;

  var calendar = SvgPicture.asset("assets/svg/nav_ic_calendar.svg",
      color: unselectedColor, width: size, height: size);
  var calendar_selected = SvgPicture.asset("assets/svg/nav_ic_calendar.svg",
      color: ColorUtils.primaryColor,
      width: selectedSize,
      height: selectedSize);

  var dashboard = SvgPicture.asset("assets/svg/nav_ic_dashboard.svg",
      color: unselectedColor, width: size, height: size);
  var dashboard_selected = SvgPicture.asset("assets/svg/nav_ic_dashboard.svg",
      width: selectedSize,
      color: ColorUtils.primaryColor,
      height: selectedSize);

  var info = SvgPicture.asset("assets/svg/nav_ic_info.svg",
      color: unselectedColor, width: size, height: size);
  var info_selected = SvgPicture.asset("assets/svg/nav_ic_info.svg",
      color: ColorUtils.primaryColor,
      width: selectedSize,
      height: selectedSize);

  var notification = SvgPicture.asset("assets/svg/nav_ic_notification.svg",
      color: unselectedColor, width: size, height: size);
  var notification_selected = SvgPicture.asset(
      "assets/svg/nav_ic_notification.svg",
      color: ColorUtils.primaryColor,
      width: selectedSize,
      height: selectedSize);

  var user = SvgPicture.asset("assets/svg/nav_ic_profile.svg",
      color: unselectedColor, width: size, height: size);
  var user_selected = SvgPicture.asset("assets/svg/nav_ic_profile.svg",
      color: ColorUtils.primaryColor,
      width: selectedSize,
      height: selectedSize);

  bool _enabled = true;
  int _status = 0;
  List<DateTime> _events = [];

  @override
  void initState() {
    super.initState();
//    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Configure BackgroundFetch.
    BackgroundFetch.configure(BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        enableHeadless: false,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: BackgroundFetchConfig.NETWORK_TYPE_NONE
    ), () async {
      // This is the fetch-event callback.
      print('[BackgroundFetch] Event received');
      setState(() {
        _events.insert(0, new DateTime.now());
      });
      // IMPORTANT:  You must signal completion of your fetch task or the OS can punish your app
      // for taking too long in the background.
      BackgroundFetch.finish();
    }).then((int status) {
      print('[BackgroundFetch] configure success: $status');
      setState(() {
        _status = status;
      });
    }).catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
      setState(() {
        _status = e;
      });
    });

    // Optionally query the current BackgroundFetch status.
    int status = await BackgroundFetch.status;
    setState(() {
      _status = status;
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }


  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
//    await Navigator.push(
//      context,
//      new MaterialPageRoute(builder: (context) => new SecondScreen(payload)),
//    );
  }

  configureNotification() async {

//    var initializationSettingsAndroid =
//    new AndroidInitializationSettings('app_icon');
//    var initializationSettingsIOS = IOSInitializationSettings(
//        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//    var initializationSettings = InitializationSettings(
//        initializationSettingsAndroid, initializationSettingsIOS);
//    flutterLocalNotificationsPlugin.initialize(initializationSettings,
//        onSelectNotification: onSelectNotification);
//
//    String groupKey = 'com.android.example.WORK_EMAIL';
//    String groupChannelId = 'grouped channel id';
//    String groupChannelName = 'grouped channel name';
//    String groupChannelDescription = 'grouped channel description';
//// example based on https://developer.android.com/training/notify-user/group.html
//    AndroidNotificationDetails firstNotificationAndroidSpecifics =
//    new AndroidNotificationDetails(
//        groupChannelId, groupChannelName, groupChannelDescription,
//        importance: Importance.Max,
//        priority: Priority.High,
//        groupKey: groupKey);
//    NotificationDetails firstNotificationPlatformSpecifics =
//    new NotificationDetails(firstNotificationAndroidSpecifics, null);
//    await flutterLocalNotificationsPlugin.show(1, 'Alex Faarborg',
//        'You will not believe...', firstNotificationPlatformSpecifics);
//    AndroidNotificationDetails secondNotificationAndroidSpecifics =
//    new AndroidNotificationDetails(
//        groupChannelId, groupChannelName, groupChannelDescription,
//        importance: Importance.Max,
//        priority: Priority.High,
//        groupKey: groupKey);
//    NotificationDetails secondNotificationPlatformSpecifics =
//    new NotificationDetails(secondNotificationAndroidSpecifics, null);
//    await flutterLocalNotificationsPlugin.show(
//        2,
//        'Jeff Chang',
//        'Please join us to celebrate the...',
//        secondNotificationPlatformSpecifics);
//
//// create the summary notification required for older devices that pre-date Android 7.0 (API level 24)
//    List<String> lines = new List<String>();
//    lines.add('Alex Faarborg  Check this out');
//    lines.add('Jeff Chang    Launch Party');
//    InboxStyleInformation inboxStyleInformation = new InboxStyleInformation(
//        lines,
//        contentTitle: '2 new messages',
//        summaryText: 'janedoe@example.com');
//    AndroidNotificationDetails androidPlatformChannelSpecifics =
//    new AndroidNotificationDetails(
//        groupChannelId, groupChannelName, groupChannelDescription,
//        style: NotificationStyleAndroid.Inbox,
//        styleInformation: inboxStyleInformation,
//        groupKey: groupKey,
//        setAsGroupSummary: true);
//    NotificationDetails platformChannelSpecifics =
//    new NotificationDetails(androidPlatformChannelSpecifics, null);
//    await flutterLocalNotificationsPlugin.show(
//        3, 'Attention', 'Two new messages', platformChannelSpecifics);
  }

  AppStateProvider appState;
  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppStateProvider>(context);
    if (_widgetOptions.isEmpty) {
      _widgetOptions = [
        CalendarScreen(appState),
        Dashboard(() {
          setState(() {
            _selectedIndex = 0;
          });
        }),
        InfoScreen(),
//        NotificationScreen(),
        ProfileScreen()
      ];
    }

    return Scaffold(
      body: Center(
        child:
            /*Dashboard()*/ _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(16.0), topLeft: Radius.circular(16.0)),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            unselectedFontSize: 11,
            selectedFontSize: 11,
            selectedItemColor: ColorUtils.primaryColor,
            unselectedItemColor: unselectedColor,
            items: [
              BottomNavigationBarItem(
                  icon: calendar,
                  activeIcon: calendar_selected,
                  title: Text("Calendar")),
              BottomNavigationBarItem(
                  icon: dashboard,
                  activeIcon: dashboard_selected,
                  title: Text("Dashboard")),
              BottomNavigationBarItem(
                  icon: info, activeIcon: info_selected, title: Text("Info")),
//              BottomNavigationBarItem(
//                  icon: notification,
//                  activeIcon: notification_selected,
//                  title: Text("Notification")),
              BottomNavigationBarItem(
                  icon: user, activeIcon: user_selected, title: Text("Profile"))
            ],
            onTap: (position) {
              setState(() {
                _selectedIndex = position;
              });
            },
            currentIndex: _selectedIndex),
      ),
    );
  }
}
