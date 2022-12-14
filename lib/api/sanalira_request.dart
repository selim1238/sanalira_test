import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:sanalira_test/models/sanalira_model.dart';

class SanaliraRequest {
  Future<SanaliraModel> getSanaliraData() async {
    var client = http.Client();
    var _sanaliraModel;

    try {
      var response =
          await client.get(Uri.parse('https://api.sanalira.com/assignment'));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        _sanaliraModel = SanaliraModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return _sanaliraModel;
    }

    return _sanaliraModel;
  }
}
