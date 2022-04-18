import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/utils/theme.dart';

class MedicinesScreen extends StatefulWidget {
  const MedicinesScreen({Key? key}) : super(key: key);

  @override
  State<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends State<MedicinesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicines'),
        backgroundColor: AppColors.secondary,
      ),
      body: const Center(
        child: Text('Medicines Page'),
      ),
    );
  }
}
