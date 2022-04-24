import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/models/med_options.dart';
import 'package:project/models/medicine.dart';
import 'package:project/screens/home/med_label_screen.dart';
import 'package:project/services/database.dart';
import 'package:project/utils/theme.dart';

class MedInfo extends StatefulWidget {
  final dynamic med;
  final String med_id;
  final String uid;
  final String med_name;

  const MedInfo(
      {Key? key,
      required this.med,
      required this.med_id,
      required this.med_name,
      required this.uid})
      : super(key: key);

  @override
  State<MedInfo> createState() =>
      _MedInfoState(med: med, med_id: med_id, med_name: med_name, uid: uid);
}

class _MedInfoState extends State<MedInfo> {
  dynamic med = null;
  String med_id = '';
  String med_name = '';
  final String uid;

  _MedInfoState(
      {required this.med,
      required this.med_id,
      required this.med_name,
      required this.uid});

  @override
  void initState() {
    super.initState();
    if (med != null) {
      med_name = med.med_name;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(med_name),
        backgroundColor: AppColors.secondary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: med == null
              ? FutureBuilder<Medicine>(
                  future: Database.getMedicine(uid, med_id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      med = snapshot.data;
                      return builMedContent(med);
                    } else if (snapshot.hasError) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.error,
                                size: 100, color: AppColors.primary),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.error.toString().contains(
                                        'DocumentSnapshotPlatform which does not exist')
                                    ? 'Look like the medicine has been deleted'
                                    : '${snapshot.error}',
                                style: TextStyle(fontSize: 24),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ]);
                    } else {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(),
                            )
                          ]);
                    }
                  })
              : builMedContent(med),
        ),
      ),
    );
  }

  Widget builMedContent(Medicine med) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 20),
            child: SvgPicture.asset(
              "assets/pill-shape/${(med.shape).toString().padLeft(2, '0')}.svg",
              color: MedColor.List[med.color],
              height: 120,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              med.med_name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              med.med_form_strength,
              style: const TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 20.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text(
                "Rxcui:",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Wrap(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: med.rxcui == ''
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: const Text(
                            'Not Available',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: AppColors.black,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.black.withOpacity(.3),
                            border: Border.all(
                              color: AppColors.iconDark,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MedLabelScreen(rxcui: med.rxcui)));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Text(
                              med.rxcui,
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: AppColors.black,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(.5),
                              border: Border.all(
                                color: AppColors.iconDark,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                )
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text(
                "Notes:",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    med.notes == '' ? 'No notes' : med.notes,
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                  )),
            ),
          ),
        ]);
  }
}
