import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/screens/add_medicine/search_screen.dart';
import 'package:project/services/auth_service.dart';
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
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: getMedicines(snapshot),
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

  getMedicines(snapshot) {
    return snapshot.data.docs
        .map<Widget>((doc) => ListTile(
            leading: SvgPicture.asset(
              "assets/pill-shape/0${doc['shape']}.svg",
              color: MedColor.List[doc['color']],
              height: 100,
            ),
            title: Text(doc['med_name']),
            subtitle: Text('''
${doc['rxcui']}
${doc['med_form_strength']}''')))
        .toList();
  }
}
