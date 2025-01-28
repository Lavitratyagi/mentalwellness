import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = "http://192.168.50.212:8000";

  // Fetch concerns
  static Future<List<String>> fetchConcerns() async {
    final response = await http.get(Uri.parse("$_baseUrl/concerns"));
    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch concerns");
    }
  }

  // Fetch goals based on selected concerns
  static Future<List<String>> fetchGoals(List<String> concerns) async {
    final concernsParam = concerns.join("+");
    final response =
        await http.get(Uri.parse("$_baseUrl/goals/$concernsParam"));
    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch goals");
    }
  }

  static Future<List<String>> getQuestions(List<String> concerns) async {
    final String concernParams = concerns.join('+');
    final response = await http.get(
      Uri.parse('$_baseUrl/questions/$concernParams'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<String>();
    } else {
      throw Exception('Failed to load questions');
    }
  }
}
