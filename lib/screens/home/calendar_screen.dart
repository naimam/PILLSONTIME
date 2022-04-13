import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/utils/theme.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({ Key? key }) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: AppColors.secondary,
      ),
      body: const Center(
        child: Text('Calendar Page'),
          
        
      ),
    );
  }
}