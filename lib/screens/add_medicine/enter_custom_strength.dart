import 'package:flutter/material.dart';
import 'package:project/screens/add_medicine/select_med_shape.dart';
import 'package:project/utils/theme.dart';
import 'package:project/models/med_options.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';

class EnterCustomStrengthScreen extends StatefulWidget {
  const EnterCustomStrengthScreen(
      {required this.med_name, required this.med_form});
  final String med_name;
  final String med_form;
  @override
  State<EnterCustomStrengthScreen> createState() =>
      _EnterCustomStrengthScreenState();
}

class _EnterCustomStrengthScreenState extends State<EnterCustomStrengthScreen> {
  bool _showNext = false;
  final TextEditingController _StrengthController = TextEditingController();
  int strength_unit_id = 0;

  @override
  void initState() {
    super.initState();
    _StrengthController.addListener(_onInputChanged);
  }

  @override
  void dispose() {
    _StrengthController.removeListener(_onInputChanged);
    _StrengthController.dispose();
    super.dispose();
  }

  _onInputChanged() {
    if (_StrengthController.text.replaceAll(' ', '') != '') {
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
        title: Text(widget.med_name + "  " + widget.med_form),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                "What is the strength of your med?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
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
                Container(
                  width: 50,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: _StrengthController,
                    decoration: const InputDecoration(),
                  ),
                ),
                Container(
                  height: 16,
                ),
                ChipsChoice<int>.single(
                  value: strength_unit_id,
                  onChanged: (val) => setState(() => strength_unit_id = val),
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: MedStrength.List,
                    value: (i, v) => i,
                    label: (i, v) => v,
                  ),
                  choiceActiveStyle: const C2ChoiceStyle(
                    color: AppColors.secondary,
                    borderColor: AppColors.secondary,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    showCheckmark: false,
                  ),
                  choiceStyle: const C2ChoiceStyle(
                    color: AppColors.textDark,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: _showNext,
        child: FloatingActionButton.extended(
          onPressed: () {
            String form_strength = _StrengthController.text +
                " " +
                MedStrength.List[strength_unit_id] +
                " " +
                widget.med_form;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SelectMedShapeScreen(
                        rxcui: "",
                        med_name: widget.med_name,
                        med_form_strength: form_strength)));
          },
          label: const Text('Next'),
        ),
      ),
    );
  }
}
