import 'package:class_app/ui/around_me/around_me.dart';
import 'package:class_app/ui/dashboard/classes.dart';
import 'package:class_app/ui/dashboard/dashboard.dart';
import 'package:class_app/ui/announcement/announcement.dart';
import 'package:class_app/ui/more/more.dart';
import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

import 'dashboard/admin/AdminScreen.dart';
import 'dashboard/today.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  final _widgetOptions = [
    Announcement(),
    Today(),
    Dashboard(),
//    Classes(),
    /*More()*/
    AroundMe(),
//    Announcement(),
//    AdminScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child:
          /*Dashboard()*/ _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Icons.list, title: "Today"),
//            TabData(iconData: Icons.notifications, title: "Notification"),
            TabData(iconData: Icons.dashboard, title: "Dashboard"),
//            TabData(iconData: Icons.near_me, title: "Around me"),
//            TabData(iconData: Icons.near_me, title: "Notification"),
//            TabData(iconData: Icons.account_circle, title: "Admin")
          ],
          onTabChangedListener: (position) {
            setState(() {
              _selectedIndex = position;
            });
          },
          initialSelection: 1,
    /*)

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
        );
  }

  /*void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }*/
}
