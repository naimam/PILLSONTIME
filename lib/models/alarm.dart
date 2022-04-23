import 'package:cloud_firestore/cloud_firestore.dart';

class Alarm {
  Alarm({
    this.id = '',
    required this.name,
    this.instructions = 'N/A',
    required this.med_ids,
    required this.dosage,
    required this.start_time,
    this.end_time = null,
    required this.freq_num,
    required this.freq_unit,
    required this.is_repeating,
  });

  factory Alarm.fromDocument(DocumentSnapshot data) {
    return Alarm(
      id: data.id,
      name: data['name'],
      instructions: data['instructions'],
      med_ids: data['med_ids'],
      dosage: data['dosage'],
      start_time: data['start_time'].toDate(),
      end_time: data['end_time']?.toDate(),
      freq_num: data['freq_num'],
      freq_unit: data['freq_unit'],
      is_repeating: data['is_repeating'],
    );
  }

  String id;
  String name;
  String instructions;
  List<String> med_ids;
  List<String> dosage;
  DateTime start_time;
  DateTime? end_time;
  int freq_num;
  String freq_unit;
  bool is_repeating;
}
