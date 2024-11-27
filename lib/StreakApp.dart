import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(StreakApp());
}

class StreakApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Streak Tracker',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: StreakTracker(),
    );
  }
}

class StreakTracker extends StatefulWidget {
  @override
  _StreakTrackerState createState() => _StreakTrackerState();
}

class _StreakTrackerState extends State<StreakTracker> {
  int _streakCount = 0;
  DateTime? _lastUpdated;

  @override
  void initState() {
    super.initState();
    _loadStreakData();
  }

  Future<void> _loadStreakData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _streakCount = prefs.getInt('streakCount') ?? 0;
      String? lastUpdatedString = prefs.getString('lastUpdated');
      
      // Add error handling for invalid date format
      if (lastUpdatedString != null && lastUpdatedString.isNotEmpty) {
        try {
          _lastUpdated = DateTime.parse(lastUpdatedString);
        } catch (e) {
          // Handle invalid date format by logging and setting as null
          print("Error parsing date: $e");
          _lastUpdated = null;
        }
      }
    });
  }

  Future<void> _saveStreakData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('streakCount', _streakCount);
    prefs.setString('lastUpdated', _lastUpdated?.toIso8601String() ?? '');
  }

  void _completeTask() {
    DateTime now = DateTime.now();

    // Reset streak if more than 1 day has passed
    if (_lastUpdated != null && now.difference(_lastUpdated!).inDays > 1) {
      _streakCount = 0; // Reset streak if more than 1 day has passed
    }

    setState(() {
      _streakCount++;
      _lastUpdated = now;
    });

    _saveStreakData();
  }

  void _resetStreak() {
    setState(() {
      _streakCount = 0;
      _lastUpdated = null;
    });
    _saveStreakData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.amberAccent,
        title: Text('Streak Tracker'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '🔥 Current Streak:',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                '$_streakCount Days',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _completeTask,
                child: Text('Complete Task'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: _resetStreak,
                child: Text('Reset Streak'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
