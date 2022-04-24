import 'package:flutter/material.dart';
import 'package:project/screens/add_medicine/search_screen.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(firebaseUser.uid)
              .collection('medicines')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var userDocument = snapshot.data as dynamic;
            medRx = userDocument!['rxcui'];
            medName = userDocument['med_name'];
            medStrength = userDocument['med_form_strength'];
            medNotes = userDocument['notes'];
            medShape = userDocument['shape'];
            medColor = userDocument['color'];

            return const Center(
              child: CircularProgressIndicator(),
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
}
