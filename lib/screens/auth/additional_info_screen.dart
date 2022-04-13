import 'package:flutter/material.dart';
import 'package:project/utils/theme.dart';
import 'package:intl/intl.dart';

import '../../models/user.dart';

class AdditionalInfoScreen extends StatefulWidget {
  final String email;
  const AdditionalInfoScreen({Key? key, required this.email}) : super(key: key);

  @override
  _AdditionalInfoScreenState createState() => _AdditionalInfoScreenState();
}

class _AdditionalInfoScreenState extends State<AdditionalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _sexController = TextEditingController();
  final _dateFormat = DateFormat('yyyy-MM-dd');
  bool _isLoading = false;

  String? _nameValidator(String? value) {
    if (value!.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthdayController.dispose();
    _sexController.dispose();
    super.dispose();
  }

  late String currentGender = "What is your gender?";
  final genderList = [
    "What is your gender?",
    "Male",
    "Female",
    "Non-binary",
    "Transgender",
    "Intersex",
    "I prefer not to say",
    "N/A",
  ];
  void _changedDropDownItem(value) {
    setState(() {
      this.currentGender = value;
    });
  }

  DateTime _now = DateTime.now();
  late DateTime _date;

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1),
      firstDate: DateTime(1905, 1),
      lastDate: DateTime(2022, 12),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
        _birthdayController.text = _dateFormat.format(_date);
      });
    }
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      if (currentGender == "What is your gender?") {
        setState(() {
          currentGender = "N/A";
        });
      }
      String bd = _birthdayController.text;
      if (bd.isEmpty || bd == '') {
        bd = 'N/A';
      }
      User initUser = User(
          uId: '',
          email: widget.email,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          registerDate: DateTime.now(),
          dateOfBirth: bd,
          gender: currentGender);
      Navigator.pop(context, initUser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Need Additional Info'),
        backgroundColor: AppColors.primary,
      ),
      body: (_isLoading)
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 24, bottom: 24),
                        child: Text(
                          'Please provide additional information',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w800),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _firstNameController,
                          validator: _nameValidator,
                          decoration:
                              const InputDecoration(hintText: 'first name'),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _lastNameController,
                          validator: _nameValidator,
                          decoration:
                              const InputDecoration(hintText: 'last name'),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _birthdayController,
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: 'birthday',
                            suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () {
                                  _selectDate();
                                }),
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          isExpanded: true,
                          value: currentGender,
                          hint: const Text("What is your gender?"),
                          items: List<String>.from(genderList)
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(width: 200, child: Text(value)),
                            );
                          }).toList(),
                          onChanged: _changedDropDownItem,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            _signUp();
                          },
                          child: const Text('Continue'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text('Cancel',
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
