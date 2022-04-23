import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:project/screens/add_alarm/select_meds_screen.dart';
import 'package:project/utils/theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final auth.User firebaseUser = Provider.of<auth.User>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarms'),
        backgroundColor: AppColors.secondary,
      ),
      body: const Center(child: Text("Welcome home!")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SelectMedsScreen(uid: firebaseUser.uid)));
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_alarm),
      ),
    );
  }
}
