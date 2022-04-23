import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:project/models/alarm.dart';
import 'package:project/screens/add_alarm/select_meds_screen.dart';
import 'package:project/utils/theme.dart';
import 'package:provider/provider.dart';

import 'alarm_info_screen.dart';

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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .collection('alarms')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<DocumentSnapshot> docs = snapshot.data.docs;

          if (docs.isEmpty) {
            return const Center(
              child: Text('No alarms'),
            );
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (BuildContext context, int index) {
              final DocumentSnapshot doc = docs[index];
              Alarm alarm = Alarm.fromDocument(doc);
              String freqSubtitle = ' ';
              DateTime start_time = alarm.start_time;
              DateTime? end_time = alarm.end_time;

              // change date format to be more readable: kk:mm:a dd-mm
              String startTime = "${start_time.hour}:${start_time.minute.toString().padLeft(2, '0')} ${start_time.hour > 12 ? 'PM' : 'AM'} ${start_time.day.toString().padLeft(2, '0')}-${start_time.month.toString().padLeft(2, '0')}-${start_time.year}";
              String endTime = " ";
              if (end_time != null) {
                endTime = "${end_time.hour}:${end_time.minute.toString().padLeft(2, '0')} ${end_time.hour > 12 ? 'PM' : 'AM'} ${end_time.day.toString().padLeft(2, '0')}-${end_time.month.toString().padLeft(2, '0')}-${end_time.year}";
              }

              if (alarm.freq_num == 0) {
                freqSubtitle = 'Once at ' + startTime;
              } else {
                freqSubtitle = 'Every ' + alarm.freq_num.toString() + ' ' + alarm.freq_unit + 'at ' + startTime + ' to ' + endTime;
              }
             

              return Card(
                  child: ListTile(
                title: Text(alarm.name),
                subtitle: Text(alarm.instructions + "\n" + freqSubtitle),
                
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {},
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  AlarmInfo(alarm: alarm)));
                  
                },
                
              ));
            },
          );
        },
      ),
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
