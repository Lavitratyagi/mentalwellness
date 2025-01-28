import 'package:flutter/material.dart';

class TakeTestPage extends StatelessWidget {
  const TakeTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8C7CE3), // Purple color for the AppBar
        title: Text(
          "TEST",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text "TEST" at the top
            Text(
              "TEST",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 30),

            // First Tile
            InkWell(
              onTap: () {
                // Handle tile click for Test 1
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    // Circular Logo Image
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          'assets/images/logo1.png'), // Replace with your logo image
                    ),
                    SizedBox(width: 16),
                    // Text next to the logo
                    Text(
                      "Test 1",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Second Tile
            InkWell(
              onTap: () {
                // Handle tile click for Test 2
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 30),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    // Circular Logo Image
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          'assets/images/logo2.png'), // Replace with your logo image
                    ),
                    SizedBox(width: 16),
                    // Text next to the logo
                    Text(
                      "Test 2",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Download Report Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Handle download report functionality
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  side: BorderSide(color: Colors.black),
                ),
                icon: Icon(Icons.download, size: 20), // Icon for download
                label: Text(
                  "DOWNLOAD REPORT",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
