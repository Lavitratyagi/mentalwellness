import 'package:flutter/material.dart';

class SafeSpacePage extends StatefulWidget {
  const SafeSpacePage({super.key});

  @override
  _SafeSpacePage createState() => _SafeSpacePage();
}

class _SafeSpacePage extends State<SafeSpacePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            top: 50.0), // Top padding to push content down
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Align items to the top
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text above the image
                Text(
                  "YOUR SAFE SPACE",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 30), // Space between text and image

                // Image in the center with larger size
                Image.asset(
                  'assets/images/chatbot.png', // Replace with your actual image path
                ),
                SizedBox(height: 30), // Space between image and buttons

                // Two buttons below the image
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Action for the first button
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        backgroundColor:
                            Color(0xFFD9D2FF), // Light purple color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "CHAT WITH COMPANION", // Change text as needed
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 15), // Space between the buttons
                    ElevatedButton(
                      onPressed: () {
                        // Action for the second button
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        backgroundColor: Color(0xFF8C7CE3), // Purple color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "TAKE TEST", // Change text as needed
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
