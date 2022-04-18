import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine {
  Medicine({
    this.rxcui = 'N/A',
    required this.med_name,
    required this.med_form_strength,
    this.notes = 'N/A',
    required this.shape,
    required this.color,
  });

  factory Medicine.fromDocument(DocumentSnapshot data) {
    return Medicine(
      rxcui: data['rxcui'],
      med_name: data['med_name'],
      med_form_strength: data['med_form_strength'],
      notes: data['notes'],
      shape: data['shape'],
      color: data['color'],
    );
  }

  final String rxcui;
  final String med_name;
  final String med_form_strength;
  final String notes;
  final int shape;
  final int color;
}
