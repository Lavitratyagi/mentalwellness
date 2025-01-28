import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDailySelected = true;
  int _waterCount = 0;
  String _todayKey = _getTodayKey();

  final List<Map<String, dynamic>> _dailyTasks = [
    {'task': 'Eat 3 meals', 'icon': Icons.restaurant, 'completed': false},
    {
      'task': 'Meditate for 5 min',
      'icon': Icons.self_improvement,
      'completed': false
    },
    {'task': 'Skincare', 'icon': Icons.spa, 'completed': false},
    {'task': 'Read a book', 'icon': Icons.menu_book, 'completed': false},
    {
      'task': 'Exercise for 30 min',
      'icon': Icons.directions_run,
      'completed': false
    },
    {'task': 'Sleep by 11pm', 'icon': Icons.nights_stay, 'completed': false},
  ];

  static String _getTodayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}'; // Format: YYYY-MM-DD
  }

  @override
  void initState() {
    super.initState();
    _loadWaterCount();
  }

  void _loadWaterCount() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString('waterIntake') ?? '{}';
    final waterData = json.decode(savedData) as Map<String, dynamic>;

    setState(() {
      _waterCount = waterData[_todayKey]?.toInt() ?? 0;
    });
  }

  void _updateWaterCount(int count) async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString('waterIntake') ?? '{}';
    final waterData = json.decode(savedData) as Map<String, dynamic>;

    waterData[_todayKey] =
        count.clamp(0, 8); // Ensure value stays between 0 and 8

    setState(() {
      _waterCount = waterData[_todayKey];
    });

    await prefs.setString('waterIntake', json.encode(waterData));
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final avatarHeight = screenHeight * 0.35;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: avatarHeight * 0.5, // Maintain 3:4 aspect ratio
                  height: avatarHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage('assets/images/avatar.png'),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  height: avatarHeight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Eve',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text('Weight: 58 kg',
                          style: TextStyle(color: Colors.grey)),
                      Text('Height: 165 cm',
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            // Buttons Section
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _isDailySelected ? Colors.purple : Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _isDailySelected = true;
                      });
                    },
                    child: Text(
                      'Daily Tasks',
                      style: TextStyle(
                          color:
                              _isDailySelected ? Colors.white : Colors.black),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          !_isDailySelected ? Colors.purple : Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _isDailySelected = false;
                      });
                    },
                    child: Text(
                      'Challenges',
                      style: TextStyle(
                          color:
                              !_isDailySelected ? Colors.white : Colors.black),
                    ),
                  ),
                ),
              ],
            ),

            // Scrollable Content Section
            Expanded(
              child: _isDailySelected
                  ? ListView(
                      children: [
                        // Water Intake Section
                        Card(
                          color: Colors.lightBlue[50],
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Daily Water Intake',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue[800],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Wrap(
                                        spacing: 8,
                                        children: List.generate(8, (index) {
                                          return Container(
                                            width: 22,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: index < _waterCount
                                                  ? Colors.blue[800]
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              border: Border.all(
                                                  color: Colors.blue[100]!),
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add_circle,
                                          color: Colors.blue[800]),
                                      onPressed: () =>
                                          _updateWaterCount(_waterCount + 1),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Daily Tasks Section
                        ..._dailyTasks.map((task) {
                          int index = _dailyTasks.indexOf(task);
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: SizedBox(
                              height: 80, // Adjust the height as needed
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, // Horizontal padding
                                  vertical:
                                      12, // Adjust vertical padding for height
                                ),
                                leading: Icon(
                                  task['icon'],
                                  color: Colors.purple,
                                  size: 30, // Adjust icon size if needed
                                ),
                                title: Text(
                                  task['task'],
                                  style: TextStyle(
                                      fontSize:
                                          16), // Adjust font size if needed
                                ),
                                trailing: Checkbox(
                                  value: task['completed'],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _dailyTasks[index]['completed'] = value!;
                                    });
                                  },
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.padded,
                                  visualDensity: VisualDensity.compact,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    )
                  : Center(
                      child: Text(
                        'No challenges available',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
