import 'package:flutter/material.dart';
import 'package:project/utils/theme.dart';

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //TODO direct frequency screen
        },
        label: const Text('Next'),
      ),
    );
  }
}
