import 'package:flutter/material.dart';
import 'home_page.dart'; // Make sure to import your HomePage here.

class RecommendationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/images/bg.png"), // Use your background image here
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
                crossAxisAlignment: CrossAxisAlignment.center, // Align to the center
                children: [
                  // Text for recommendations
                  Text(
                    "Based on your concerns, we recommend these goals:",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white, // White color to stand out
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),

                  // Container for each recommendation (same size and centered)
                  Column(
                    children: [
                      // First recommendation
                      Container(
                        width: 130, // Fixed width for each box (you can change 300 to any value you prefer)
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Mindfulness",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center, // Center the text inside the box
                        ),
                      ),
                      // Second recommendation
                      Container(
                        width: 130, // Same fixed width for the second box
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Healthy Diet",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center, // Center the text inside the box
                        ),
                      ),
                      // Third recommendation
                      Container(
                        width: 130, // Same fixed width for the third box
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Skincare",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center, // Center the text inside the box
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  // OK Button (moved to the right)
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to the home page when "OK" is pressed
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HomePage(), // Replace with your actual home page
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 15, 
                          horizontal: 30, // Horizontal padding to make it proportional to text size
                        ),
                        backgroundColor: Color(0xff8C7CE3), // Purple color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "OK",
                        style: TextStyle(
                          fontSize: 20, // Font size of the button is now the same as the text
                          color: Colors.white,
                        ),
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
