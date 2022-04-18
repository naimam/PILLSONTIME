import 'dart:convert';

import 'package:http/http.dart' as http;

class CliniTables {
  static Future<List<dynamic>> getCliniTables(String term) async {
    var url = Uri.https(
        'clinicaltables.nlm.nih.gov', '/api/rxterms/v3/search', {
      'terms': term,
      'maxList': '30',
      'ef': 'DISPLAY_NAME,STRENGTHS_AND_FORMS,RXCUIS'
    });
    var headers = {
      'terms': term,
      'maxList': '30',
      'ef': 'DISPLAY_NAME,STRENGTHS_AND_FORMS,RXCUIS'
    };
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
