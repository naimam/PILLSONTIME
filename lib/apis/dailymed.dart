import 'dart:convert';

import 'package:http/http.dart' as http;

class DailyMed {
  static Future<String> getSetId(String rxcui) async {
    var url =
        Uri.https('dailymed.nlm.nih.gov', '/dailymed/services/v2/spls.json', {
      'rxcui': rxcui,
    });
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);

      if (map['data'].isEmpty) {
        throw Exception('No results found');
      }
      String res = map['data'][0]['setid'];

      if (res == null) {
        throw Exception('No results found');
      } else {
        return res;
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<String> getImgUrl(String setid) async {
    var url = Uri.https(
        'dailymed.nlm.nih.gov', '/dailymed/services/v2/spls/$setid/media.json');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> media = map['data']['media'];
      if (media.isEmpty) {
        throw Exception('No results found');
      }
      String url = media[0]['url'];
      return url;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
