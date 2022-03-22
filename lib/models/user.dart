import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  User(
      {required this.uId,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.registerDate,
      this.dateOfBirth = 'N/A',
      this.gender = 'N/A'});

  factory User.fromDocument(DocumentSnapshot data) {
    return User(
      uId: data['uId'],
      email: data['email'],
      firstName: data["firstName"],
      lastName: data["lastName"],
      registerDate: data["resgisterDate"].toDate(),
      dateOfBirth: data['dateOfBirth'],
      gender: data['gender'],
    );
  }

  final String uId;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime registerDate;
  final String dateOfBirth;
  final String gender;
}
