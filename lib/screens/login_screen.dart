import 'package:flutter/material.dart';
import 'package:project/screens/register_screen.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/utils/theme.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
          child: Column(
        children: [
          TextButton(
            child: Text('sign in'),
            onPressed: () {
              AuthService.signIn('thuvo@gmail.com', '11111111');
            },
          ),
          TextButton(
              child: Text('sign up'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
              }),
        ],
      )),
    );
  }
}
