import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/models/medicine.dart';
import 'package:project/screens/add_medicine/search_screen.dart';
import 'package:project/screens/home/med_info_screen.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/database.dart';
import 'package:project/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../../models/med_options.dart';

class MedicinesScreen extends StatefulWidget {
  const MedicinesScreen({Key? key}) : super(key: key);

  @override
  State<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends State<MedicinesScreen> {
  late String medRx = '';
  late String medName = '';
  late String medStrength = '';
  late String medShape = '';
  late String medColor = '';
  late String medNotes = '';

  @override
  Widget build(BuildContext context) {
    final auth.User firebaseUser = Provider.of<auth.User>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicines'),
        backgroundColor: AppColors.secondary,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(firebaseUser.uid)
              .collection('medicines')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              physics: NeverScrollableScrollPhysics(),
              children: getMedicines(snapshots, firebaseUser.uid),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  getMedicines(AsyncSnapshot<QuerySnapshot> snapshots, uid) {
    return snapshots.data!.docs.map((DocumentSnapshot doc) {
      Medicine med = Medicine.fromDocument(doc);
      return Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListTile(
            leading: SvgPicture.asset(
              "assets/pill-shape/${(med.shape).toString().padLeft(2, '0')}.svg",
              color: MedColor.List[med.color],
              height: 100,
            ),
            title: Text(med.med_name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text('${med.med_form_strength} \nrxcui: ${med.rxcui}',
                style: const TextStyle(fontSize: 14)),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MedInfo(
                          med: med, med_id: '', med_name: '', uid: uid)));
            },
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                deleteMedDialog(context, med, uid);
              },
            ),
          ),
        ),
      );
    }).toList();
  }

  void deleteMedDialog(BuildContext context, Medicine med, String uid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete medication?'),
          content:
              const Text('Are you sure you want to delete this medication?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                Database.deleteMedicine(uid, med.id);
              },
            ),
          ],
        );
      },
    );
  }
}
