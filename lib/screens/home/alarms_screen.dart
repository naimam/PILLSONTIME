import 'package:flutter/material.dart';
import 'package:project/screens/add_medicine/search_screen.dart';
import 'package:project/screens/add_alarm/select_meds_screen.dart';
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
        title: const Text('Alarms'),
        backgroundColor: AppColors.secondary,
      ),
      body: const Center(child: Text("Welcome home!")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SelectMed()));
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_alarm),
      ),
    );
  }
}
