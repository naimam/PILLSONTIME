import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:project/models/alarm.dart';
import 'package:project/screens/add_alarm/select_meds_screen.dart';
import 'package:project/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:project/services/database.dart';

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
            physics: NeverScrollableScrollPhysics(),
            itemCount: docs.length,
            itemBuilder: (BuildContext context, int index) {
              final DocumentSnapshot doc = docs[index];
              Alarm alarm = Alarm.fromDocument(doc);
              String freqTitle = ' ';
              Widget timeWidget = Container();
              DateTime startTime = alarm.start_time;
              DateTime? endTime = alarm.end_time;
              final FormatterTime = DateFormat.jm();
              final FormatterDate = DateFormat.yMMMMd('en_US');

              String startTimeHour = FormatterTime.format(startTime);
              String endTimeHour = ' ';
              if (endTime != null) {
                endTimeHour = FormatterTime.format(endTime);
              }
              String startTimeDate = FormatterDate.format(startTime);
              String endTimeDate = ' ';
              if (endTime != null) {
                endTimeDate = FormatterDate.format(endTime);
              }

              if (alarm.freq_num == 0) {
                freqTitle = ' once at ';
              } else {
                freqTitle = ' every ' +
                    alarm.freq_num.toString() +
                    ' ' +
                    alarm.freq_unit +
                    ' at ';
              }

              if (alarm.freq_num == 0) {
                timeWidget = Column(children: [
                  Text(startTimeHour,
                      style: const TextStyle(
                          fontSize: 23.0, fontWeight: FontWeight.bold)),
                  Text(startTimeDate, style: const TextStyle(fontSize: 16.0)),
                ]);
              } else {
                timeWidget = Row(
                  children: [
                    Column(children: [
                      Text(startTimeHour,
                          style: const TextStyle(
                              fontSize: 23.0, fontWeight: FontWeight.bold)),
                      Text(startTimeDate,
                          style: const TextStyle(fontSize: 16.0)),
                    ]),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Text(
                        'To',
                        style: TextStyle(
                            fontSize: 23.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Column(children: [
                      Text(endTimeHour,
                          style: const TextStyle(
                              fontSize: 23.0, fontWeight: FontWeight.bold)),
                      Text(endTimeDate, style: const TextStyle(fontSize: 16.0))
                    ]),
                  ],
                );
              }

              return Card(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text(alarm.name + ': ' + freqTitle),
                        subtitle: Padding(
                            padding: const EdgeInsets.only(top: 14),
                            child: timeWidget),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            deleteAlarmDialog(context, alarm, firebaseUser.uid);
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AlarmInfo(alarm: alarm)));
                        },
                      )));
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

// delete alarm function with confirmation dialog
  void deleteAlarmDialog(BuildContext context, Alarm alarm, String uid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete alarm?'),
          content: const Text('Are you sure you want to delete this alarm?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                Database.deleteAlarm(uid, alarm.id);
              },
            ),
          ],
        );
      },
    );
  }
}
