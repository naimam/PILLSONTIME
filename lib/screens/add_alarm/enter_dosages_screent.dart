import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/models/med_options.dart';
import 'package:project/models/medicine.dart';
import 'package:project/screens/add_alarm/name_instructions_screen.dart';
import 'package:project/utils/theme.dart';

class EnterDosagesScreen extends StatefulWidget {
  EnterDosagesScreen({Key? key, required this.medicines}) : super(key: key);
  final List<Medicine> medicines;
  @override
  State<EnterDosagesScreen> createState() =>
      _EnterDosagesScreenState(numOfMeds: medicines.length);
}

class _EnterDosagesScreenState extends State<EnterDosagesScreen> {
  late List<Medicine> _medicines;
  late List<int> _dosages;
  late List<String> _dosages_unit;
  late List<TextEditingController> _controllers;
  bool _isLoading = false;

  _EnterDosagesScreenState({required int numOfMeds}) {
    _dosages = List<int>.filled(numOfMeds, 0, growable: false);
    _dosages_unit =
        List<String>.filled(numOfMeds, DosageUnit.List[0], growable: false);
    _controllers = List<TextEditingController>.generate(
        numOfMeds, (int index) => TextEditingController(text: '0'));
  }

  @override
  Widget build(BuildContext context) {
    _medicines = widget.medicines;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Dosages"),
        backgroundColor: AppColors.tertiary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                "Enter the dosage for each medicine",
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
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: _medicines.length,
                itemBuilder: (context, int index) {
                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/pill-shape/${(_medicines[index].shape).toString().padLeft(2, '0')}.svg",
                              color: MedColor.List[_medicines[index].color],
                              height: 40,
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _medicines[index].med_name,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _medicines[index].med_form_strength,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "rxcui: " + _medicines[index].rxcui,
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Notes: " + _medicines[index].notes,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _controllers[index],
                                    keyboardType: TextInputType.number,
                                    onChanged: (String value) {
                                      if (_isNumeric(value)) {
                                        setState(() {
                                          _dosages[index] = int.parse(value);
                                        });
                                      } else {
                                        setState(() {
                                          _dosages[index] = 0;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Dosage",
                                      errorText: _dosages[index] == 0
                                          ? "Dosage cannot be 0"
                                          : null,
                                      labelStyle: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: DropdownButton<String>(
                                    value: _dosages_unit[index],
                                    onChanged: (String? value) {
                                      setState(() {
                                        _dosages_unit[index] = value!;
                                      });
                                    },
                                    items: DosageUnit.List.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, int index) {
                  return const Divider(
                    thickness: 1.0,
                    color: Colors.grey,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: !_dosages.contains(0),
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.tertiary,
          onPressed: () {
            setState(() {
              _isLoading = true;
            });
            final List<String> med_ids =
                _medicines.map((med) => med.id).toList();
            List<String> input_dosages =
                List<String>.filled(_dosages.length, '');
            for (int i = 0; i < _dosages.length; i++) {
              input_dosages[i] =
                  _dosages[i].toString() + ' ' + _dosages_unit[i];
            }
            setState(() {
              _isLoading = false;
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NameIntructionsScreen(
                        med_ids: med_ids, dosages: input_dosages)));
          },
          label: const Text('Next'),
        ),
      ),
    );
  }

  bool _isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }
}
