import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/utils/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.secondary,
      ),
      body: Center(
        child: TextButton(
          child: const Text('sign out'),
          onPressed: () {
            AuthService.signOut();
          },
        ),
      ),
    );
  }
}

