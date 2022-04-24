import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:project/models/alarm.dart';
import 'package:project/models/medicine.dart';
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

  static Future<String?> addMedicine(String uid, Medicine medicine) async {
    try {
      await _db.collection('users').doc(uid).collection('medicines').add({
        'rxcui': medicine.rxcui,
        'med_name': medicine.med_name,
        'med_form_strength': medicine.med_form_strength,
        'notes': medicine.notes,
        'shape': medicine.shape,
        'color': medicine.color,
      }).then((result) {
        return 'success';
      });
    } catch (e) {
      return 'error';
    }
  }

  static Future<List<Medicine>> getMedicines(String uid) async {
    final QuerySnapshot snapshot = await _db
        .collection('users')
        .doc(uid)
        .collection('medicines')
        .get()
        .then((value) {
      return value;
    });

    return snapshot.docs.map((doc) => Medicine.fromDocument(doc)).toList();
  }

  static Future<String?> deleteMedicine(String uid, String id) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('medicines')
          .doc(id)
          .delete();
      return 'success';
    } catch (e) {
      return 'error';
    }
  }

  static Future<String?> updateMedicine(
      String uid, String id, Medicine medicine) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('medicines')
          .doc(id)
          .update({
        'rxcui': medicine.rxcui,
        'med_name': medicine.med_name,
        'med_form_strength': medicine.med_form_strength,
        'notes': medicine.notes,
        'shape': medicine.shape,
        'color': medicine.color,
      });
      return 'success';
    } catch (e) {
      return 'error';
    }
  }

  static Future<String?> addAlarm(String uid, Alarm alarm) async {
    try {
      await _db.collection('users').doc(uid).collection('alarms').add({
        'name': alarm.name,
        'instructions': alarm.instructions,
        'med_ids': alarm.med_ids,
        'med_names': alarm.med_names,
        'dosage': alarm.dosage,
        'start_time': alarm.start_time,
        'end_time': alarm.end_time,
        'freq_num': alarm.freq_num,
        'freq_unit': alarm.freq_unit,
      }).then((result) {
        return 'success';
      });
    } catch (e) {
      return 'error';
    }
  }

  static Future<List<Alarm>> getAlarms(String uid) async {
    final QuerySnapshot snapshot =
        await _db.collection('users').doc(uid).collection('alarms').get();
    return snapshot.docs.map((doc) => Alarm.fromDocument(doc)).toList();
  }

  static Future<String?> deleteAlarm(String uid, String id) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('alarms')
          .doc(id)
          .delete();
      return 'success';
    } catch (e) {
      return 'error';
    }
  }

  static Future<String?> updateAlarm(String uid, String id, Alarm alarm) async {
    try {
      await _db
          .collection('users')
          .doc(uid)
          .collection('alarms')
          .doc(id)
          .update({
        'name': alarm.name,
        'instructions': alarm.instructions,
        'med_ids': alarm.med_ids,
        'med_names': alarm.med_names,
        'dosage': alarm.dosage,
        'start_time': alarm.start_time,
        'end_time': alarm.end_time,
        'freq_num': alarm.freq_num,
        'freq_unit': alarm.freq_unit,
      });
      return 'success';
    } catch (e) {
      return 'error';
    }
  }

  // get user medicine info from id
  static Future<Medicine> getMedicine(String uid, String id) async {
    final DocumentSnapshot snapshot = await _db
        .collection('users')
        .doc(uid)
        .collection('medicines')
        .doc(id)
        .get()
        .then((value) {
      return value;
    });
    return Medicine.fromDocument(snapshot);
  }
}
