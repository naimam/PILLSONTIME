import 'package:flutter/material.dart';
import 'package:project/screens/add_medicine/select_custom_form.dart';
import 'package:project/screens/add_medicine/select_strength_form.dart';
import 'package:project/utils/theme.dart';
import 'package:project/apis/clinicaltables.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _emptyContent = true;
  List<dynamic> _display_names = [];
  List<dynamic> _strengths_and_forms = [];
  List<dynamic> _rxcuis = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    search();
  }

  search() {
    if (_searchController.text != "") {
      setState(() {
        _emptyContent = false;
      });

      CliniTables.getCliniTables(_searchController.text).then((value) {
        if (value[1].isEmpty) {
          setState(() {
            _display_names = [_searchController.text];
            _strengths_and_forms = [];
            _rxcuis = [];
          });
        } else {
          setState(() {
            _display_names = value[2]['DISPLAY_NAME'];
            _strengths_and_forms = value[2]['STRENGTHS_AND_FORMS'];
            _rxcuis = value[2]['RXCUIS'];
          });
        }
      });
    } else {
      setState(() {
        _emptyContent = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Medicine"),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsetsDirectional.only(top: 16, start: 16, end: 16),
              child: const Text(
                "What medication would you like to add?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            _emptyContent
                ? Container(
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      "Start typing to and choose your med from the list",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                : Container(
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
                      itemCount: _display_names.length,
                      itemBuilder: (context, int index) {
                        return GestureDetector(
                          onTap: () {
                            if (_rxcuis.isEmpty) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SelectCustomFormScreen(
                                  med_name: _searchController.text,
                                );
                              }));
                            } else {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SelectStrengthFormScreen(
                                  med_name: _display_names[index],
                                  forms: _strengths_and_forms[index],
                                  rxcuis: _rxcuis[index],
                                );
                              }));
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              _display_names[index],
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
      floatingActionButton: Visibility(
        visible: !_emptyContent,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return SelectCustomFormScreen(
                med_name: _searchController.text,
              );
            }));
          },
          label: const Text('Custom'),
        ),
      ),
    );
  }
}
