import 'package:cloud_firestore/cloud_firestore.dart';

class Medicine {
  Medicine({
    this.id = '',
    this.rxcui = 'N/A',
    required this.med_name,
    required this.med_form_strength,
    this.notes = 'N/A',
    required this.shape,
    required this.color,
    this.selected = false,
  });

  factory Medicine.fromDocument(DocumentSnapshot data) {
    return Medicine(
      id: data.id,
      rxcui: data['rxcui'] == "" ? 'N/A' : data['rxcui'],
      med_name: data['med_name'],
      med_form_strength: data['med_form_strength'],
      notes: data['notes'],
      shape: data['shape'],
      color: data['color'],
    );
  }

  @override
  String toString() {
    return 'Medicine{rxcui: $rxcui, med_name: $med_name, med_form_strength: $med_form_strength, notes: $notes, shape: $shape, color: $color}';
  }

  String id;
  String rxcui;
  String med_name;
  String med_form_strength;
  String notes;
  int shape;
  int color;
  bool selected;
}
