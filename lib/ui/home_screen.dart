import 'package:class_app/ui/around_me/around_me.dart';
import 'package:class_app/ui/dashboard/lectures.dart';
import 'package:class_app/ui/dashboard/dashboard.dart';
import 'package:class_app/ui/announcement/announcement.dart';
import 'package:class_app/ui/more/more.dart';
import 'package:class_app/ui/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'calendar/calender_screen.dart';
import 'dashboard/today.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [];

  @override
  Widget build(BuildContext context) {
    if (_widgetOptions.isEmpty) {
      _widgetOptions = [
//    Announcement(),
        CalendarScreen(),
        Dashboard(() {
          setState(() {
            _selectedIndex = 0;
          });
        }),
//    Classes(),
        /*More()*/
//    AroundMe(),
//    Announcement(),
//    AdminScreen()
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
            backgroundColor: Colors.white,
            unselectedFontSize: 12,
            selectedFontSize: 14,
//                selectedItemColor: Colors.white,
//                unselectedItemColor: Colors.white60,
            iconSize: 18,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today), title: Text("Calendar")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard), title: Text("Dashboard"))
            ],
            onTap: (position) {
              setState(() {
                _selectedIndex = position;
              });
            },
            currentIndex: _selectedIndex
            /*)

    //Todo: user curved navigation bar here (curved_navigation_bar: ^0.2.20)

              BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard), title: Text('Dashboard')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.group), title: Text('Announcement')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.near_me), title: Text('Around me')),
//          BottomNavigationBarItem(icon: Icon(Icons.menu), title: Text('More')),
              ],*/
            /*currentIndex: _selectedIndex,
              fixedColor: Colors.deepPurple,
              onTap: _onItemTapped,
              type: BottomNavigationBarType.fixed,*/
            ),
      ),
    );
  }

  /*void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }*/
}
