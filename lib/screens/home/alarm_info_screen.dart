import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:project/models/alarm.dart';
import 'package:project/models/medicine.dart';
import 'package:project/screens/add_alarm/select_meds_screen.dart';
import 'package:project/screens/home/med_info_screen.dart';
import 'package:project/services/database.dart';
import 'package:project/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AlarmInfo extends StatelessWidget {
  final Alarm alarm;

  const AlarmInfo({Key? key, required this.alarm}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final auth.User firebaseUser = Provider.of<auth.User>(context);
    final String uid = firebaseUser.uid;

    DateTime start_time = alarm.start_time;
    DateTime? end_time = alarm.end_time;
    final DateFormat dateFormatter = DateFormat('kk:mm a - dd MMMM yyyy');

    String startTime = dateFormatter.format(start_time);
    String endTime = " ";
    if (end_time != null) {
      endTime = dateFormatter.format(end_time);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(alarm.name),
        backgroundColor: AppColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundImage: AssetImage('assets/clockicon.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    alarm.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: const Text(
                      "Instructions:",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          alarm.instructions == ''
                              ? 'No instructions'
                              : alarm.instructions,
                          style: const TextStyle(
                            fontSize: 15.0,
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: const Text(
                      "Medications: ",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0; i < alarm.med_names.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MedInfo(
                                                  med: null,
                                                  med_id: alarm.med_ids[i],
                                                  med_name: alarm.med_names[i],
                                                  uid: uid)));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 4.0),
                                      child: Text(
                                        alarm.med_names[i],
                                        style: const TextStyle(
                                          fontSize: 15.0,
                                          color: AppColors.black,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: (i % 3 == 0
                                                ? AppColors.primary
                                                : i % 2 == 0
                                                    ? AppColors.secondary
                                                    : AppColors.tertiary)
                                            .withOpacity(.5),
                                        border: Border.all(
                                          color: AppColors.iconDark,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    ' - ${alarm.dosage[i]}',
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ]),
                  ),
                ),
                if (alarm.freq_num != 0)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                        title: const Text(
                          "Frequency: ",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "Every " +
                                alarm.freq_num.toString() +
                                " " +
                                alarm.freq_unit +
                                "\nFrom: " +
                                startTime +
                                "\nTo: " +
                                endTime,
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        )),
                  ),
                if (alarm.freq_num == 0)
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: const Text(
                          "Frequency: ",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Once at " + startTime + "\n" + endTime,
                              style: const TextStyle(
                                fontSize: 18.0,
                              ),
                            )),
                      )),
              ]),
        ),
      ),
    );
  }
}
