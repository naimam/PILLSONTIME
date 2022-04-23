import 'package:flutter/material.dart';
import 'package:project/utils/theme.dart';

import 'frequency_duration_screen.dart';

class NameIntructionsScreen extends StatefulWidget {
  NameIntructionsScreen(
      {Key? key, required this.med_ids, required this.dosages})
      : super(key: key);
  final List<String> med_ids;
  final List<String> dosages;
  @override
  State<NameIntructionsScreen> createState() =>
      _NameIntructionsScreenState(med_ids: med_ids, dosages: dosages);
}

class _NameIntructionsScreenState extends State<NameIntructionsScreen> {
  late final List<String> _med_ids;
  late final List<String> _dosages;
  final _nameController = TextEditingController();
  final _instructionsController = TextEditingController();
  bool _showNext = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_onNameChanged);
  }

  @override
  void dispose() {
    _nameController.removeListener(_onNameChanged);
    _nameController.dispose();
    super.dispose();
  }

  _NameIntructionsScreenState({required med_ids, required dosages}) {
    _med_ids = med_ids;
    _dosages = dosages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Name and Instructions"),
        backgroundColor: AppColors.tertiary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                "Enter the name and instructions for this alarm",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primary.withOpacity(0.25),
              ),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 200,
                    child: TextField(
                      minLines: null,
                      maxLines: null,
                      expands: true,
                      controller: _instructionsController,
                      decoration: InputDecoration(
                        labelText: "Instructions",
                        labelStyle: const TextStyle(
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.tertiary,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return FrequencyDurationScreen(
                med_ids: _med_ids,
                dosages: _dosages,
                name: _nameController.text,
                instructions: _instructionsController.text,
              );
            }));
          },
          label: const Text('Next'),
        ),
        visible: _nameController.text.replaceAll(' ', '') != '',
      ),
    );
  }

  void _onNameChanged() {
    if (_nameController.text.replaceAll(' ', '') != '') {
      setState(() {
        _showNext = true;
      });
    } else {
      setState(() {
        _showNext = false;
      });
    }
  }
}
