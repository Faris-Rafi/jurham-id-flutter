import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:jurham/utils/helper.dart';

const String baseUrl = "https://api.jurham.id/api";

class DataServices {
  static Future<List<dynamic>> fetchFeeList() async {
    final response = await http.get(Uri.parse('$baseUrl/feeTransaction'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData;
    } else {
      return [];
    }
  }

  static Future<List<dynamic>> araArbRules() async {
    final response = await http.get(Uri.parse('$baseUrl/ara-arb-rules'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData;
    } else {
      return [];
    }
  }

  static Future<List<dynamic>> loginUser(data) async {
    final response = await http.post(Uri.parse('$baseUrl/login'), body: data);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = [json.decode(response.body)];
      return jsonData;
    } else {
      return [
        {"error": "Email atau Password invalid."}
      ];
    }
  }

  static Future<List<dynamic>> checkUserData(token) async {
    final response = await http.get(Uri.parse('$baseUrl/user'),
        headers: {"Authorization": "Bearer $token"});

    if (response.statusCode == 200) {
      List<dynamic> jsonData = [json.decode(response.body)];
      return jsonData;
    } else {
      deleteToken();
      return [];
    }
  }
}
