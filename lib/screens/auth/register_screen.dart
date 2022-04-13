import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/utils/theme.dart';
import 'package:intl/intl.dart';

import '../../models/user.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _sexController = TextEditingController();
  final _dateFormat = DateFormat('yyyy-MM-dd');
  final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  bool _isLoading = false;
  bool _isObscure = true;
  bool _isObscure2 = true;

  String? _nameValidator(String? value) {
    if (value!.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'Email is required';
    } else if (!_emailRegex.hasMatch(value)) {
      return 'Email is invalid';
    }
    return null;
  }

  String? _passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Confirm password is required';
    } else if (value != _passwordController.text) {
      return 'Confirm password must be the same as password';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
          email: _emailController.text,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          registerDate: DateTime.now(),
          dateOfBirth: bd,
          gender: currentGender);
      String res = await AuthService.signUpWithEmailPassword(
          initUser, _passwordController.text);
      if (res == 'Sign up successful') {
        Navigator.of(context).pop();
      } else {
        setState(() {
          _isLoading = false;
        });
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(res),
          duration: Duration(seconds: 3),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                          'Register',
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
                          controller: _emailController,
                          validator: _emailValidator,
                          decoration: const InputDecoration(hintText: 'email'),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          obscureText: _isObscure,
                          controller: _passwordController,
                          validator: _passwordValidator,
                          decoration: InputDecoration(
                            hintText: 'password',
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure2
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          obscureText: _isObscure2,
                          controller: _confirmPasswordController,
                          validator: _confirmPasswordValidator,
                          decoration: InputDecoration(
                            hintText: 'confirm password',
                            suffixIcon: IconButton(
                                icon: Icon(_isObscure2
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isObscure2 = !_isObscure2;
                                  });
                                }),
                          ),
                          keyboardType: TextInputType.visiblePassword,
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
                          onPressed: _signUp,
                          child: const Text('Sign up'),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Divider(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Already have an account?',
                              style: Theme.of(context).textTheme.subtitle2),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Sign in'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
