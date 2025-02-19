import 'package:http/http.dart' as http;
import 'dart:convert';

const String baseUrl = "https://api.jurham.id/api";

class DataServices {
  static Future<List<dynamic>> fetchFeeList() async {
    final response = await http.get(Uri.parse('$baseUrl/feeTransaction'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception("Failed to load posts");
    }
  }

  static Future<List<dynamic>> araArbRules() async {
    final response = await http.get(Uri.parse('$baseUrl/ara-arb-rules'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception("Failed to load posts");
    }
  }
}
