import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart'; // For MIME type detection
import 'package:http_parser/http_parser.dart'; // Add this import

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

  static Future<Map<String, dynamic>> uploadImage(File imageFile) async {
    final uri = Uri.parse('http://192.168.50.212:8080/emotion');
    final request = http.MultipartRequest('POST', uri);

    try {
      final mimeType = lookupMimeType(imageFile.path) ?? 'application/octet-stream';
      request.files.add(
        await http.MultipartFile.fromPath(
          'file',
          imageFile.path,
          contentType: MediaType.parse(mimeType),
        ),
      );

      final response = await request.send();
      final responseString = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return jsonDecode(responseString);
      } else {
        throw Exception('Server error (${response.statusCode}): $responseString');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }

  static Future<void> submitAnswers(List<Map<String, dynamic>> answers) async {
    print('Submitting answers: $answers');
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/answers'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(answers),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to submit answers: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to submit answers: $e');
    }
  }
}
