import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentalwellness/services/api_services.dart';

class TakeTestPage extends StatefulWidget {
  @override
  _TakeTestPageState createState() => _TakeTestPageState();
}

class _TakeTestPageState extends State<TakeTestPage> {
  List<String> _questions = [];
  Map<int, double> _answers = {};
  bool _isLoading = true;
  String _errorMessage = '';
  Map<String, String> _emotionResponses = {}; // Store API responses for each question

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final concerns = prefs.getStringList('selectedConcerns') ?? [];

      if (concerns.isEmpty) {
        setState(() {
          _errorMessage = 'No concerns selected. Please complete previous steps.';
          _isLoading = false;
        });
        return;
      }

      final questions = await ApiService.getQuestions(concerns);
      setState(() {
        _questions = questions;
        _isLoading = false;
        // Initialize answers with 0 values
        _answers = {for (var i = 0; i < _questions.length; i++) i: 0.0};
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load questions. Please try again.';
        _isLoading = false;
      });
    }
  }

  // Function to capture a photo using the front camera
  Future<File?> _captureImage() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front, // Use the front camera
      );

      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        print('No image captured.');
        return null;
      }
    } catch (e) {
      print('Error capturing image: $e');
      return null;
    }
  }

  // Function to handle slider value changes
  void _handleSliderChange(int questionIndex, double value) async {
    setState(() {
      _answers[questionIndex] = value;
    });

    // Automatically capture an image when the slider value changes
    final imageFile = await _captureImage();
    if (imageFile != null) {
      try {
        // Send the image to the backend
        final response = await ApiService.uploadImage(imageFile);
        setState(() {
          _emotionResponses[_questions[questionIndex]] = response.toString();
        });
        print('API Response: $response');
      } catch (e) {
        print('Error sending image to backend: $e');
      }
    }
  }

  void _submitAnswers() {
    // Process answers and tags
    final List<Map<String, dynamic>> formattedAnswers = [];

    for (int i = 0; i < _questions.length; i++) {
      final question = _questions[i];
      final match = RegExp(r'\[(.*?)\]').firstMatch(question);
      final tag = match?.group(1) ?? 'general';
      final questionText = question.replaceAll(RegExp(r'\[.*?\]\s*'), '');

      formattedAnswers.add({
        'tag': tag,
        'question': questionText,
        'score': _answers[i]?.toInt() ?? 0,
        'emotionResponse': _emotionResponses[question] ?? 'Not Available',
      });
    }

    // TODO: Send formattedAnswers to backend
    print('Submitting answers: $formattedAnswers');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportPage(answers: formattedAnswers),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GENTLE CHECK-IN',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Instructions Block
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('INSTRUCTIONS',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                )),
                            SizedBox(height: 10),
                            Text(
                              '1. Using the 0-3 scale below, please indicate how you feel about the particular condition or experience.\n'
                              '2. Please answer according to what really reflects your experience rather than what you think your experience should be.\n'
                              '3. Please treat each item separately from every other item.',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),

                      // Questions List
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _questions.length,
                        itemBuilder: (context, index) {
                          final question = _questions[index];
                          final displayQuestion = question.replaceAll(
                              RegExp(r'\[.*?\]\s*'), '');

                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(displayQuestion,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      )),
                                  SizedBox(height: 10),
                                  Slider.adaptive(
                                    value: _answers[index] ?? 0.0,
                                    min: 0,
                                    max: 3,
                                    divisions: 3,
                                    label: _answers[index]?.toStringAsFixed(0),
                                    onChanged: (value) =>
                                        _handleSliderChange(index, value),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [0, 1, 2, 3]
                                        .map((e) => Text(e.toString()))
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: _submitAnswers,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff8C7CE3),
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: Text(
                            'Generate Report',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}

// Dummy Report Page
class ReportPage extends StatelessWidget {
  final List<Map<String, dynamic>> answers;

  const ReportPage({required this.answers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Report')),
      body: ListView.builder(
        itemCount: answers.length,
        itemBuilder: (context, index) {
          final answer = answers[index];
          return ListTile(
            title: Text(answer['question']),
            subtitle: Text(
                'Tag: ${answer['tag']} - Score: ${answer['score']} - Emotion: ${answer['emotionResponse']}'),
          );
        },
      ),
    );
  }
}
