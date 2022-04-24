import 'package:flutter/material.dart';
import 'package:project/apis/openfda.dart';
import 'package:project/utils/theme.dart';

class MedLabelScreen extends StatefulWidget {
  const MedLabelScreen({Key? key, required this.rxcui}) : super(key: key);

  final String rxcui;

  @override
  State<MedLabelScreen> createState() => _MedLabelScreenState(rxcui: rxcui);
}

class _MedLabelScreenState extends State<MedLabelScreen> {
  final String rxcui;
  bool _emptyLabel = false;
  bool _emptyList = false;
  bool _isLoading = false;

  _MedLabelScreenState({required this.rxcui});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('RXCUI: $rxcui'),
          backgroundColor: AppColors.secondary,
        ),
        body: FutureBuilder(
          future: OpenFDA.getDrugLabel(rxcui),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, String>> snapshot) {
            List<Widget> children = [];
            if (snapshot.hasData) {
              Map<String, String>? data = snapshot.data;
              if (data == null) {
                children = <Widget>[
                  Center(
                    child: Column(children: const [
                      Icon(
                        Icons.error,
                        color: AppColors.iconDark,
                        size: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('No data found'),
                      )
                    ]),
                  ),
                ];
              } else {
                for (String key in data.keys) {
                  if (key == "brand_name") {
                    children.add(Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          '${data[key]}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                    ));
                  } else if (key == 'img_url') {
                    children.add(Center(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Image.network(
                          data[key] ??
                              'https://cdn-icons-png.flaticon.com/512/843/843203.png',
                          width: 200,
                        ),
                      ),
                    ));
                  } else if (key == 'Effective Time') {
                    int hr = (int.parse('${data[key]}') / 3600000).toInt();
                    children.add(Padding(
                      padding: EdgeInsets.all(20),
                      child: ListTile(
                        title: Text(
                          '$key',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        subtitle: Text(
                          '$hr hours',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                    ));
                  } else if (key == 'boxed_warning') {
                    children.add(
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.all(7),
                            child: Text(
                              '${data[key]}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.black,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    );
                  } else {
                    children.add(Padding(
                      padding: EdgeInsets.all(20),
                      child: ListTile(
                        title: Text(
                          '$key',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                        subtitle: Text(
                          '${data[key]}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                    ));
                  }
                }
              }
            } else if (snapshot.hasError) {
              children = <Widget>[
                Center(
                  child: Column(children: [
                    const SizedBox(
                      height: 200,
                    ),
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(' ${snapshot.error}'),
                    )
                  ]),
                )
              ];
            } else {
              children = <Widget>[
                Center(
                  child: Column(
                    children: const [
                      SizedBox(
                        height: 200,
                      ),
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting result...'),
                      )
                    ],
                  ),
                ),
              ];
            }
            return SingleChildScrollView(
              child: Column(
                children: children,
              ),
            );
          },
        ));
  }
}
