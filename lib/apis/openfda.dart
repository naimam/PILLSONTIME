import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project/apis/dailymed.dart';

class OpenFDA {
  static Future<Map<String, String>> getDrugLabel(String rxcui) async {
    final String set_id = await DailyMed.getSetId(rxcui);
    var url = Uri.https('api.fda.gov', '/drug/label.json', {
      'search': 'set_id:$set_id',
    });
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, String> clean_result = {};
      Map<String, dynamic> result = {};
      Map<String, dynamic> map = json.decode(response.body);
      return await Future.delayed(const Duration(milliseconds: 200), () async {
        if (map['results'].isEmpty) {
          throw Exception('No results found');
        } else {
          var map1 = map['results'][0];
          result["brand_name"] = map1["openfda"]["brand_name"];
          result['img_url'] = [await DailyMed.getImgUrl(set_id)];
          result['boxed_warning'] = map1['boxed_warning'];
          result["Effective Time"] = [map1["effective_time"]];
          result['Indications and Usage'] = map1['indications_and_usage'];
          result['Do Not Use'] = map1['do_not_use'];
          result['Stop Use'] = map1['stop_use'];
          result['Warnings'] = map1["warnings"];
          result['precautions'] = map1['general_precautions'];
          result['Dosage and Administration'] =
              map1["dosage_and_administration"];
          for (var key in result.keys) {
            if (result[key] != null) {
              clean_result[key] = result[key][0];
            }
          }

          return clean_result;
        }
      });
    } else {
      throw Exception('Failed to load data');
    }
  }
}
