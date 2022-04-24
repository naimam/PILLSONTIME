import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/screens/add_medicine/select_med_color.dart';
import 'package:project/utils/theme.dart';

class SelectMedShapeScreen extends StatefulWidget {
  const SelectMedShapeScreen(
      {required this.rxcui,
      required this.med_name,
      required this.med_form_strength});
  final String rxcui;
  final String med_name;
  final String med_form_strength;
  @override
  State<SelectMedShapeScreen> createState() => _SelectMedShapeScreenState();
}

class _SelectMedShapeScreenState extends State<SelectMedShapeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.med_name + "  " + widget.med_form_strength),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                "Choose the shape of your med",
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
                itemCount: 16,
                itemBuilder: (context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: selectedIndex == index
                            ? Border.all(
                                color: AppColors.secondary,
                                width: 2,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(10),
                        color: selectedIndex == index
                            ? AppColors.textDark.withOpacity(0.25)
                            : Colors.transparent,
                      ),
                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(16.0),
                      child: Row(children: [
                        SvgPicture.asset(
                          "assets/pill-shape/${(index + 1).toString().padLeft(2, '0')}.svg",
                          color: AppColors.textDark,
                          height: 46,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          "Shape ${(index + 1).toString().padLeft(2, '0')}",
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SelectMedColorScreen(
                rxcui: widget.rxcui,
                med_name: widget.med_name,
                med_form_strength: widget.med_form_strength,
                med_shape: selectedIndex + 1);
          }));
        },
        label: const Text('Next'),
      ),
    );
  }
}
