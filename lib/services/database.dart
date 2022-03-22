import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:project/models/user.dart';

class Database {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<User?> getUser(String uId) async {
    final DocumentSnapshot snapshot =
        await _db.collection('users').doc(uId).get();
    return User.fromDocument(snapshot);
  }

  static Future<void> addNewUser(User user, String uId) async {
    await _db.collection('users').doc(uId).set({
      'uId': uId,
      'email': user.email,
      'firstName': user.firstName,
      'lastName': user.lastName,
      'registerDate': user.registerDate,
      'dateOfBirth': user.dateOfBirth,
      'gender': user.gender,
    });
  }

  static Future<void> updateUserInfo(User user) async {
    await _db.collection('users').doc(user.uId).update({
      'firstName': user.firstName,
      'lastName': user.lastName,
      'dateOfBirth': user.dateOfBirth,
      'gender': user.gender
    });
  }
}
