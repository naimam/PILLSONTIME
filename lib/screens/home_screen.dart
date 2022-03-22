import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/utils/theme.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: AppColors.secondary,
      ),
      body: Center(
        child: TextButton(
          child: Text('sign out'),
          onPressed: () {
            AuthService.signOut();
          },
        ),
      ),
    );
  }
}
