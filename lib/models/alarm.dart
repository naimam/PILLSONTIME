import 'package:cloud_firestore/cloud_firestore.dart';

class Alarm {
  Alarm({
    this.id = '',
    required this.name,
    this.instructions = 'N/A',
    required this.med_ids,
    required this.med_names,
    required this.dosage,
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
      med_ids: List<String>.from(data['med_ids']),
      med_names: List<String>.from(data['med_names']),
      dosage: List<String>.from(data['dosage']),
      start_time: data['start_time'].toDate(),
      end_time: data['end_time']?.toDate(),
      freq_num: data['freq_num'],
      freq_unit: data['freq_unit'],
    );
  }

  String id;
  String name;
  String instructions;
  List<String> med_ids;
  List<String> med_names;
  List<String> dosage;
  DateTime start_time;
  DateTime? end_time;
  int freq_num;
  String freq_unit;
}
