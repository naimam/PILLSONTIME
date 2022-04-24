import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/models/medicine.dart';
import 'package:project/screens/add_medicine/add_notes_screen.dart';
import 'package:project/utils/theme.dart';
import 'package:project/models/med_options.dart';

class SelectMedColorScreen extends StatefulWidget {
  const SelectMedColorScreen(
      {required this.rxcui,
      required this.med_name,
      required this.med_form_strength,
      required this.med_shape});
  final String rxcui;
  final String med_name;
  final String med_form_strength;
  final int med_shape;
  @override
  State<SelectMedColorScreen> createState() => _SelectMedColorScreenState();
}

class _SelectMedColorScreenState extends State<SelectMedColorScreen> {
  int selectedIndex = 0;
  Color selectedColor = MedColor.List[0];

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
                "Choose a color for your med",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SvgPicture.asset(
              "assets/pill-shape/${(widget.med_shape).toString().padLeft(2, '0')}.svg",
              color: selectedColor,
              height: 100,
            ),
            const SizedBox(height: 16),
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
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  itemCount: MedColor.List.length,
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          selectedColor = MedColor.List[index];
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: selectedIndex == index
                            ? const Icon(
                                Icons.check,
                                color: AppColors.white,
                                size: 40,
                              )
                            : Container(),
                        decoration: BoxDecoration(
                          color: MedColor.List[index],
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: selectedIndex == index
                                  ? AppColors.white
                                  : Colors.transparent,
                              width: 2),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddNotesScreen(
                medicine: Medicine(
              rxcui: widget.rxcui,
              med_name: widget.med_name,
              med_form_strength: widget.med_form_strength,
              shape: widget.med_shape,
              color: selectedIndex,
            ));
          }));
        },
        label: const Text('Next'),
      ),
    );
  }
}
