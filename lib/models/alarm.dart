import 'package:cloud_firestore/cloud_firestore.dart';

class Alarm {
  Alarm({
    required this.id,
    required this.name,
    this.instructions = 'N/A',
    required this.dosage,
    required this.medicine_ids,
    required this.start_time,
    this.end_time = null,
    required this.freq_num,
    required this.freq_unit,
  });

  factory Alarm.fromDocument(DocumentSnapshot data) {
    return Alarm(
      id: data.id,
      name: data['name'],
      instructions: data['instructions'],
      dosage: data['dosage'],
      medicine_ids: data['medicine_ids'],
      start_time: data['start_time'].toDate(),
      end_time: data['end_time']?.toDate(),
      freq_num: data['freq_num'],
      freq_unit: data['freq_unit'],
    );
  }

  final String id;
  final String name;
  final String instructions;
  final List<String> dosage;
  final List<String> medicine_ids;
  final DateTime start_time;
  final DateTime? end_time;
  final int freq_num;
  final String freq_unit;
}
