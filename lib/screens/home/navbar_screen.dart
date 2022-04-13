// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:project/screens/home/calendar_screen.dart';
import 'package:project/screens/home/home_screen.dart';
import 'package:project/screens/home/profile_screen.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/utils/theme.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({ Key? key }) : super(key: key);

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    CalendarScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,              
              // color: kGoodLightGray,
            ),
            label: 'Home',
            activeIcon: Icon(
              Icons.home,
              // color: kGoodPurple,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_today,
              // color: kGoodLightGray,
            ),
            label: 'Calendar',
            activeIcon: Icon(
              Icons.calendar_today,
              // color: kGoodPurple,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              // color: kGoodLightGray,
              size: 36,
            ),
            label: 'Profile',
            activeIcon: Icon(
              Icons.person,
              // color: kGoodPurple,
              size: 36,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }

}