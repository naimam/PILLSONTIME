import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/models/med_options.dart';
import 'package:project/models/medicine.dart';
import 'package:project/screens/add_alarm/enter_dosages_screent.dart';
import 'package:project/services/database.dart';
import 'package:project/utils/theme.dart';

class SelectMedsScreen extends StatefulWidget {
  const SelectMedsScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<SelectMedsScreen> createState() => _SelectMedsScreenState();

  final String uid;
}

class _SelectMedsScreenState extends State<SelectMedsScreen> {
  List<Medicine> _selected_meds = [];
  List<Medicine> _medicines = [];
  bool _emptyList = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    getMedicines();
  }

  void getMedicines() async {
    _medicines = await Database.getMedicines(widget.uid).then((value) {
      if (value.isEmpty) {
        setState(() {
          _emptyList = true;
        });
      } else {
        setState(() {
          _emptyList = false;
        });
      }
      setState(() {
        _isLoading = false;
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Alarm"),
        backgroundColor: AppColors.tertiary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                "Select the medications you would like to add to your alarm",
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
                                  _medicines[index].med_name +
                                      " - " +
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
                            Expanded(
                                child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: Icon(
                                  _medicines[index].selected
                                      ? Icons.check_box_outlined
                                      : Icons.check_box_outline_blank,
                                  color: _medicines[index].selected
                                      ? AppColors.textDark
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  if (_medicines[index].selected) {
                                    setState(() {
                                      _medicines[index].selected = false;
                                      _selected_meds.remove(_medicines[index]);
                                    });
                                  } else {
                                    setState(() {
                                      _medicines[index].selected = true;
                                      _selected_meds.add(_medicines[index]);
                                    });
                                  }
                                },
                              ),
                            )),
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
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: _selected_meds.isNotEmpty,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EnterDosagesScreen(medicines: _selected_meds);
            }));
          },
          label: const Text('Next'),
        ),
      ),
    );
  }
}
