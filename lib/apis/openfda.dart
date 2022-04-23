import 'dart:convert';

import 'package:http/http.dart' as http;

// Future<void> main() async {
//   String set_id = 'f22635fe-821d-4cde-aa12-419f8b53db81';
//   OpenFDA.getDrugLabel(set_id).then((value) {
//     print(value['effective_time']);
//   });
// }

class OpenFDA {
  static Future<Map<String, dynamic>> getDrugLabel(String set_id) async {
    var url = Uri.https('api.fda.gov', '/drug/label.json', {
      'search': 'set_id:$set_id',
    });
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> result = {};
      Map<String, dynamic> map = json.decode(response.body);
      if (map['results'].isEmpty) {
        throw Exception('No results found');
      } else {
        result['indications_and_usage'] =
            map['results'][0]['indications_and_usage'];
        result['boxed_warning'] = map['results'][0]['boxed_warning'];
        result['do_not_use'] = map['results'][0]['do_not_use'];
        result['stop_use'] = map['results'][0]['stop_use'];
        result['warnings'] = map['results'][0]["warnings"][0];
        result['precautions'] = map['results'][0]['general_precautions'];
        result['dosage_and_administration'] =
            map['results'][0]["dosage_and_administration"][0];
        result["effective_time"] =
            map['results'][0]["effective_time"]; //milliseconds
        return result;
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}
