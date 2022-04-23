import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:project/models/alarm.dart';
import 'package:project/screens/add_alarm/select_meds_screen.dart';
import 'package:project/utils/theme.dart';
import 'package:provider/provider.dart';

class AlarmInfo extends StatefulWidget {
  const AlarmInfo({ Key? key }) : super(key: key);

  @override
  State<AlarmInfo> createState() => _AlarmInfoState();
}

class _AlarmInfoState extends State<AlarmInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm Info'),
        backgroundColor: AppColors.secondary,
      ),
      body: Text ('Alarm Info'),
      
      
    );

    
      
  
  }
}