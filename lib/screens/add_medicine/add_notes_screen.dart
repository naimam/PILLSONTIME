import 'package:flutter/material.dart';
import 'package:project/models/medicine.dart';
import 'package:project/screens/home/navbar_screen.dart';
import 'package:project/services/database.dart';
import 'package:project/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:provider/provider.dart';

class AddNotesScreen extends StatefulWidget {
  const AddNotesScreen({required this.medicine});
  final Medicine medicine;
  @override
  State<AddNotesScreen> createState() => _AddNotesScreenState();
}

class _AddNotesScreenState extends State<AddNotesScreen> {
  bool _isLoading = false;
  bool _isSuccess = false;
  final TextEditingController _NotesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth.User firebaseUser = Provider.of<auth.User>(context);
    Medicine medicine = widget.medicine;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !_isSuccess,
        title: Text(medicine.med_name + "  " + medicine.med_form_strength),
        backgroundColor: AppColors.primary,
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
                    color: AppColors.quaternary,
                    size: 100,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Success!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.quaternary,
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
                          "Is there any notes you would like to add?",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.tertiary.withOpacity(0.25),
                        ),
                        child: TextField(
                          controller: _NotesController,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter notes here",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor:
            _isLoading || _isSuccess ? Colors.grey : AppColors.primary,
        onPressed: () {
          if (_isLoading || _isSuccess) {
            return;
          }
          medicine.notes = _NotesController.text;
          setState(() {
            _isLoading = true;
          });
          Database.addMedicine(firebaseUser.uid, medicine).then((value) {
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
}
