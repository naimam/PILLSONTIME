import 'package:flutter/material.dart';
import 'package:project/models/alarm.dart';
import 'package:project/models/med_options.dart';
import 'package:project/screens/home/navbar_screen.dart';
import 'package:project/services/database.dart';
import 'package:project/utils/theme.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:provider/provider.dart';

class FrequencyDurationScreen extends StatefulWidget {
  FrequencyDurationScreen(
      {Key? key,
      required this.med_ids,
      required this.dosages,
      required this.name,
      required this.instructions})
      : super(key: key);
  final List<String> med_ids;
  final List<String> dosages;
  final String name;
  final String instructions;
  @override
  State<FrequencyDurationScreen> createState() => _FrequencyDurationScreenState(
      med_ids: med_ids,
      dosages: dosages,
      name: name,
      instructions: instructions);
}

class _FrequencyDurationScreenState extends State<FrequencyDurationScreen> {
  late final List<String> _med_ids;
  late final List<String> _dosages;
  late final String _name;
  late final String _instructions;
  bool _isLoading = false;
  bool _isSuccess = false;
  bool _is_repeating = false;
  String _freq_unit = AlarmFreqUnit.List[1];
  final _freq_num_controller = TextEditingController();
  int _freq_num = 0;
  late DateTime startDate;
  late TimeOfDay startTime;
  DateTime endDate = DateTime.now();
  TimeOfDay endTime = TimeOfDay.now();
  final _formatter_date = DateFormat.yMMMMd('en_US');
  final _formatter_time = DateFormat.jm();

  @override
  void initState() {
    super.initState();
    startDate = DateTime.now();
    startTime = TimeOfDay.now();
  }

  _FrequencyDurationScreenState(
      {required med_ids,
      required dosages,
      required name,
      required instructions}) {
    _med_ids = med_ids;
    _dosages = dosages;
    _name = name;
    _instructions = instructions;
  }

  @override
  Widget build(BuildContext context) {
    final auth.User firebaseUser = Provider.of<auth.User>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frequency and Duration'),
        backgroundColor: AppColors.tertiary,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            color: Colors.white,
            onPressed: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => NavbarScreen(),
                ),
                (route) =>
                    false, //if you want to disable back feature set to false
              );
            },
          ),
        ],
      ),
      body: _isSuccess
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Icon(
                    Icons.check,
                    color: Colors.green,
                    size: 100,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Success!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            )
          : _isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text(
                        'Loading...',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: const Text(
                          "Enter the frequency and duration for this alarm",
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
                            const Text(
                              'Is this a repeating alarm?',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: ListTile(
                                    title: Text("Yes",
                                        style: _is_repeating
                                            ? const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)
                                            : null),
                                    leading: Radio(
                                      value: 1,
                                      groupValue: _is_repeating ? 1 : 0,
                                      onChanged: (int? value) {
                                        setState(() {
                                          _is_repeating = value == 1;
                                        });
                                      },
                                      activeColor: AppColors.secondary,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text("No",
                                        style: _is_repeating
                                            ? null
                                            : const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                    leading: Radio(
                                      value: 0,
                                      groupValue: _is_repeating ? 1 : 0,
                                      onChanged: (int? value) {
                                        setState(() {
                                          _is_repeating = value == 1;
                                        });
                                      },
                                      activeColor: AppColors.secondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                                child: Column(children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.all(16),
                                      child: const Divider(
                                        color: Colors.grey,
                                        thickness: 2,
                                      )),
                                  const Text(
                                    'Please enter the frequency for repeating alarms',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: _freq_num_controller,
                                          keyboardType: TextInputType.number,
                                          onChanged: (String value) {
                                            if (_isNumeric(value)) {
                                              setState(() {
                                                _freq_num = int.parse(value);
                                              });
                                            } else {
                                              setState(() {
                                                _freq_num = 0;
                                              });
                                            }
                                          },
                                          decoration: InputDecoration(
                                            labelText: "Frequency",
                                            errorText: _freq_num == 0
                                                ? "Please enter a number"
                                                : null,
                                            labelStyle: const TextStyle(
                                              fontSize: 16,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: DropdownButton<String>(
                                          value: _freq_unit,
                                          onChanged: (String? value) {
                                            setState(() {
                                              _freq_unit = value!;
                                            });
                                          },
                                          items: AlarmFreqUnit.List.sublist(1)
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                                visible: _is_repeating),
                            Container(
                                padding: EdgeInsets.all(16),
                                child: const Divider(
                                  color: Colors.grey,
                                  thickness: 2,
                                )),
                            const Text(
                                'Please enter the duration for this alarm',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text('Start Date and Time',
                                style: TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.underline,
                                )),
                            ListTile(
                              title: Text(
                                  "Date: ${_formatter_date.format(startDate)}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              trailing: const Icon(Icons.calendar_today),
                              onTap: () async {
                                _pickDate(true);
                              },
                            ),
                            ListTile(
                              title: Text(
                                  "Time: ${_formatter_time.format(startDate)}",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              trailing: const Icon(Icons.access_time),
                              onTap: () async {
                                _pickTime(true);
                              },
                            ),
                            Visibility(
                                visible: _is_repeating,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    const Text('End Date and Time',
                                        style: TextStyle(
                                            fontSize: 16,
                                            decoration:
                                                TextDecoration.underline)),
                                    ListTile(
                                      title: Text(
                                          "Date: ${_formatter_date.format(endDate)}",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      trailing:
                                          const Icon(Icons.calendar_today),
                                      onTap: () async {
                                        _pickDate(false);
                                      },
                                    ),
                                    ListTile(
                                      title: Text(
                                          "Time: ${_formatter_time.format(endDate)}",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      trailing: const Icon(Icons.access_time),
                                      onTap: () async {
                                        _pickTime(false);
                                      },
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor:
            _isLoading || _isSuccess ? Colors.grey : AppColors.tertiary,
        onPressed: () {
          if (_isLoading || _isSuccess) {
            return;
          }

          setState(() {
            _isLoading = true;
          });

          Alarm alarm;

          if (!_is_repeating) {
            alarm = Alarm(
                id: '',
                name: _name,
                instructions: _instructions,
                med_ids: _med_ids,
                dosage: _dosages,
                start_time: startDate,
                end_time: null,
                freq_unit: AlarmFreqUnit.List[0],
                freq_num: 0);
          } else {
            alarm = Alarm(
                id: '',
                name: _name,
                instructions: _instructions,
                med_ids: _med_ids,
                dosage: _dosages,
                start_time: startDate,
                end_time: endDate,
                freq_unit: _freq_unit,
                freq_num: _freq_num);
          }

          Database.addAlarm(firebaseUser.uid, alarm).then((value) {
            setState(() {
              _isLoading = false;
              _isSuccess = true;
            });
          }).catchError((error) {
            setState(() {
              _isLoading = false;
              _isSuccess = false;
            });
          });
        },
        label: const Text('Submit'),
      ),
    );
  }

  bool _isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }

  _pickDate(bool isStartDate) async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().day),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: startDate,
    );

    if (date != null) {
      setState(() {
        if (isStartDate) {
          startDate = date;
        } else {
          endDate = date;
        }
      });
    }
  }

  _pickTime(bool isStartTime) async {
    TimeOfDay? time =
        await showTimePicker(context: context, initialTime: startTime);
    if (time != null) {
      setState(() {
        if (isStartTime) {
          startTime = time;
          startDate = DateTime(startDate.year, startDate.month, startDate.day,
              time.hour, time.minute);
        } else {
          endTime = time;
          endDate = DateTime(
              endDate.year, endDate.month, endDate.day, time.hour, time.minute);
        }
      });
    }
  }
}
