import 'package:class_app/ui/around_me/around_me.dart';
import 'package:class_app/ui/dashboard/lectures.dart';
import 'package:class_app/ui/dashboard/dashboard.dart';
import 'package:class_app/ui/announcement/announcement.dart';
import 'package:class_app/ui/more/more.dart';
import 'package:class_app/ui/profile/profile_screen.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'calendar/calender_screen.dart';
import 'dashboard/today.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [];

  static var unselectedColor = Colors.grey[600];
  static var size = 20.0;
  static var selectedSize = 22.0;

  var calendar = SvgPicture.asset("assets/svg/ic_calendar.svg",
      color: unselectedColor, width: size, height: size);
  var calendar_selected = SvgPicture.asset("assets/svg/ic_calendar.svg",
      color: ColorUtils.primaryColor, width: selectedSize, height: size);

  var dashboard = SvgPicture.asset("assets/svg/ic_dashboard.svg",
      color: unselectedColor, width: size, height: size);
  var dashboard_selected = SvgPicture.asset("assets/svg/ic_dashboard.svg",
      color: ColorUtils.primaryColor, width: selectedSize, height: size);

  var hangout = SvgPicture.asset("assets/svg/ic_hangout.svg",
      color: unselectedColor, width: size, height: size);
  var hangout_selected = SvgPicture.asset("assets/svg/ic_hangout.svg",
      color: ColorUtils.primaryColor, width: selectedSize, height: size);
  var user = SvgPicture.asset("assets/svg/ic_user.svg",
      color: unselectedColor, width: size, height: size);
  var user_selected = SvgPicture.asset("assets/svg/ic_user.svg",
      color: ColorUtils.primaryColor, width: selectedSize, height: size);

  @override
  Widget build(BuildContext context) {
    if (_widgetOptions.isEmpty) {
      _widgetOptions = [
        CalendarScreen(),
        Dashboard(() {
          setState(() {
            _selectedIndex = 0;
          });
        }),
        HangoutScreen(),
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
            unselectedFontSize: 12,
            selectedFontSize: 13,
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
                  icon: hangout,
                  activeIcon: hangout_selected,
                  title: Text("Hangout")),
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
