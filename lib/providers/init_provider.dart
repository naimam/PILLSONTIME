import 'package:flutter/material.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project/utils/theme.dart';

class InitProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: FirebaseAuth.instance.authStateChanges(),
      child: MaterialApp(
        theme: AppTheme().light,
        themeMode: ThemeMode.light,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: Driver(),
      ),
      initialData: null,
    );
  }
}

class Driver extends StatefulWidget {
  @override
  DriverState createState() => DriverState();
}

class DriverState extends State<Driver> {
  @override
  Widget build(BuildContext context) {
    final User? firebaseUser = Provider.of<User?>(context);
    return (firebaseUser != null) ? HomeScreen() : LoginScreen();
  }
}