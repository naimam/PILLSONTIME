import 'package:flutter/material.dart';
import 'package:project/screens/add_medicine/enter_custom_strength.dart';
import 'package:project/utils/theme.dart';
import 'package:project/models/med_options.dart';

class SelectCustomFormScreen extends StatefulWidget {
  const SelectCustomFormScreen({required this.med_name});
  final String med_name;
  @override
  State<SelectCustomFormScreen> createState() => _SelectCustomFormScreenState();
}

class _SelectCustomFormScreenState extends State<SelectCustomFormScreen> {
  bool _otherInput = false;
  bool _showNext = false;
  final TextEditingController _otherController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _otherController.addListener(_onInputChanged);
  }

  @override
  void dispose() {
    _otherController.removeListener(_onInputChanged);
    _otherController.dispose();
    super.dispose();
  }

  _onInputChanged() {
    if (_otherController.text.replaceAll(' ', '') != '') {
      setState(() {
        _showNext = true;
      });
    } else {
      setState(() {
        _showNext = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.med_name),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                "What is the form of your med?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Visibility(
              visible: _otherInput,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.tertiary.withOpacity(0.25),
                ),
                child: Column(children: [
                  TextField(
                    controller: _otherController,
                    decoration: const InputDecoration(
                      hintText: 'Enter form of your med',
                    ),
                  ),
                  Container(
                    height: 16,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _otherInput = false;
                      });
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("Choose from list"),
                  )
                ]),
              ),
            ),
            Visibility(
              visible: !_otherInput,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.tertiary.withOpacity(0.25),
                ),
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: MedForm.List.length,
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (MedForm.List[index] == 'Other') {
                          setState(() {
                            _otherInput = true;
                          });
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return EnterCustomStrengthScreen(
                                med_name: widget.med_name,
                                med_form: MedForm.List[index]);
                          }));
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          MedForm.List[index],
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: (_otherInput && _showNext),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EnterCustomStrengthScreen(
                  med_name: widget.med_name, med_form: _otherController.text);
            }));
          },
          label: const Text('Next'),
        ),
      ),
    );
  }
}
