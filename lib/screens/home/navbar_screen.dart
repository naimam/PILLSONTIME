// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:project/screens/home/medicines_screen.dart';
import 'package:project/screens/home/home_screen.dart';
import 'package:project/screens/home/profile_screen.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/utils/theme.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({Key? key}) : super(key: key);

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MedicinesScreen(),
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
              size: 36,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.medication_rounded,
              // color: kGoodLightGray,
            ),
            label: 'Medicines',
            activeIcon: Icon(
              Icons.medication_rounded,
              // color: kGoodPurple,
              size: 36,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              // color: kGoodLightGray,
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
