import 'package:flutter/material.dart';
import 'package:mentalwellness/screens/recomendation_page.dart';

class MainConcernsPage extends StatefulWidget {
  @override
  _MainConcernsPageState createState() => _MainConcernsPageState();
}

class _MainConcernsPageState extends State<MainConcernsPage> {
  // List to hold the selected concerns
  List<String> _selectedConcerns = [];

  // Function to handle next page navigation
  void _nextPage() {
    if (_selectedConcerns.isEmpty) {
      // Show a message if no concerns are selected
      _showMessage("Please select at least one concern.");
    } else {
      // Navigate to the next page (replace with your actual next page)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RecommendationsPage(), // Replace with your actual next page
        ),
      );
    }
  }

  // Function to show a message
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"), // Use your background image here
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Foreground content
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Text for Main Concerns
                  Text(
                    "DEFINE YOUR 3 MAIN CONCERNS",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white, // White color to stand out
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),

                  // Concerns Checkboxes (using GestureDetector for custom style)
                  Wrap(
                    spacing: 8,
                    runSpacing: 15,
                    alignment: WrapAlignment.center,
                    children: [
                      "Skipping Meals",
                      "Smoking",
                      "Bad Skin",
                      "Poor Physical Health",
                      "Poor Mental State",
                      "Screen Time",
                      "Losing Hair",
                      "Other"
                    ].map((concern) {
                      final isSelected = _selectedConcerns.contains(concern);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedConcerns.remove(concern);
                            } else {
                              _selectedConcerns.add(concern);
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Text(
                            concern.toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.black : Colors.white,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 40),

                  // Next Step Button
                  ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff8C7CE3),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      "NEXT STEP",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
