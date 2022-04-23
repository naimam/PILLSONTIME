import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:project/models/alarm.dart';
import 'package:project/screens/add_alarm/select_meds_screen.dart';
import 'package:project/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AlarmInfo extends StatelessWidget {
  final Alarm alarm;



  const AlarmInfo({Key? key, required this.alarm}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    DateTime start_time = alarm.start_time;
    DateTime? end_time = alarm.end_time;

    // change date format to be more readable: kk:mm:a dd-mm
    String startTime = "${start_time.hour}:${start_time.minute.toString().padLeft(2, '0')} ${start_time.hour > 12 ? 'PM' : 'AM'} ${start_time.day.toString().padLeft(2, '0')}-${start_time.month.toString().padLeft(2, '0')}-${start_time.year}";
    String endTime = " ";
    if (end_time != null) {
      endTime = "${end_time.hour}:${end_time.minute.toString().padLeft(2, '0')} ${end_time.hour > 12 ? 'PM' : 'AM'} ${end_time.day.toString().padLeft(2, '0')}-${end_time.month.toString().padLeft(2, '0')}-${end_time.year}";
    }




    


      return Scaffold(
      appBar: AppBar(
        title: Text(alarm.name),
        backgroundColor: AppColors.secondary,
      ),
      body:  Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/medicine.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      alarm.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Instructions: " + (alarm.instructions),
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                     const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Medications: ",
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                
                    for ( int i = 0; i < alarm.med_ids.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(alarm.med_ids[i] + ": " + alarm.dosage[i],
                          style: const TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ),
                 
                  if (alarm.freq_num != 0)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Frequency: Every " + alarm.freq_num.toString() + " " + alarm.freq_unit + "\nFrom " + startTime+ " to " + "\n" + endTime ,
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  
                  if (alarm.freq_num == 0) 
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Frequency: Once at " + alarm.start_time.toString(),
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),                    
                ]
              ),
            ),
          ),

          

      
      
    );

  }
}