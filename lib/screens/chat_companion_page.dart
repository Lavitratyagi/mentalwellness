import 'package:flutter/material.dart';

class ChatWithCompanionPage extends StatefulWidget {
  const ChatWithCompanionPage({super.key});

  @override
  _ChatWithCompanionPageState createState() => _ChatWithCompanionPageState();
}

class _ChatWithCompanionPageState extends State<ChatWithCompanionPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8C7CE3), // Purple color for the AppBar
        title: Text(
          "AI - COMPANION",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Chat messages container
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(10.0),
                    children: [
                      // Bot message
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFD1DDF5), // Light purple for bot's message
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            "Salam molecule,",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      // User message
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white, // White background for user's message
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: Colors.grey.withOpacity(0.3)),
                          ),
                          child: Text(
                            "Molecule salam, chatbot bhai!!",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Message input box fixed at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Message input field
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Type a message...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  // Send message icon
                  IconButton(
                    icon: Icon(Icons.send, color: Color(0xFF8C7CE3)),
                    onPressed: () {
                      // Add send message functionality later
                      if (_controller.text.isNotEmpty) {
                        print("Send Message: ${_controller.text}");
                        _controller.clear(); // Clear the text field after sending
                      }
                    },
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
