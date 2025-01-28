import 'package:flutter/material.dart';
import 'package:mentalwellness/screens/recomendation_page.dart';

class MainConcernsPage extends StatefulWidget {
  @override
  _MainConcernsPageState createState() => _MainConcernsPageState();
}

class _MainConcernsPageState extends State<MainConcernsPage> {
  List<String> _selectedConcerns = [];

  void _nextPage() {
    if (_selectedConcerns.isEmpty) {
      _showMessage("Please select at least one concern.");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecommendationsPage(),
        ),
      );
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
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
                image: AssetImage("assets/images/bg.png"),
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
                  // Dynamic Label
                  Text(
                    "DEFINE YOUR ${_selectedConcerns.length < 3 ? 3 - _selectedConcerns.length : 0} MAIN CONCERNS",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),

                  // Concern Options
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
                            } else if (_selectedConcerns.length < 3) {
                              _selectedConcerns.add(concern);
                            } else {
                              _showMessage("You can select up to 3 concerns only.");
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isSelected ? Colors.white : Colors.transparent,
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

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Text(
                          "PREVIOUS",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff8C7CE3),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
