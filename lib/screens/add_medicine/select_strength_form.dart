import 'package:flutter/material.dart';
import 'package:project/screens/add_medicine/select_med_shape.dart';
import 'package:project/utils/theme.dart';

class SelectStrengthFormScreen extends StatefulWidget {
  const SelectStrengthFormScreen(
      {required this.med_name, required this.forms, required this.rxcuis});
  final String med_name;
  final List<dynamic> forms;
  final List<dynamic> rxcuis;
  @override
  State<SelectStrengthFormScreen> createState() =>
      _SelectStrengthFormScreenState();
}

class _SelectStrengthFormScreenState extends State<SelectStrengthFormScreen> {
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
                "What is the strenght and form of the med?",
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
                color: AppColors.tertiary.withOpacity(0.25),
              ),
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.forms.length,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectMedShapeScreen(
                                  rxcui: widget.rxcuis[index],
                                  med_name: widget.med_name,
                                  med_form_strength: widget.forms[index],
                                )),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.forms[index],
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
          ],
        ),
      ),
    );
  }
}
