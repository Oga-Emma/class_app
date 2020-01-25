import 'package:class_app/state/app_state_provider.dart';
import 'package:class_app/ui/dashboard/courses.dart';
import 'package:class_app/ui/dashboard/dashboard.dart';
import 'package:class_app/ui/info_screen/info_screen.dart';
import 'package:class_app/ui/profile/profile_screen.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';
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
      color: ColorUtils.primaryColor, width: selectedSize, height: selectedSize);

  var dashboard = SvgPicture.asset("assets/svg/nav_ic_dashboard.svg",
      color: unselectedColor, width: size, height: size);
  var dashboard_selected = SvgPicture.asset(
      "assets/svg/nav_ic_dashboard.svg",
      width: selectedSize,
      color: ColorUtils.primaryColor, height: selectedSize);

  var info = SvgPicture.asset("assets/svg/nav_ic_info.svg",
      color: unselectedColor, width: size, height: size);
  var info_selected = SvgPicture.asset("assets/svg/nav_ic_info.svg",
      color: ColorUtils.primaryColor, width: selectedSize, height: selectedSize);

  var courses = SvgPicture.asset("assets/svg/nav_ic_course.svg",
      color: unselectedColor, width: size, height: size);
  var courses_selected = SvgPicture.asset("assets/svg/nav_ic_course.svg",
     color: ColorUtils.primaryColor,  width: selectedSize, height: selectedSize);

  var user = SvgPicture.asset("assets/svg/nav_ic_profile.svg",
      color: unselectedColor, width: size, height: size);
  var user_selected = SvgPicture.asset("assets/svg/nav_ic_profile.svg",
      color: ColorUtils.primaryColor, width: selectedSize, height: selectedSize);

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
        CoursesScreen(),
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
              BottomNavigationBarItem(
                  icon: courses,
                  activeIcon: courses_selected,
                  title: Text("Courses")),
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
