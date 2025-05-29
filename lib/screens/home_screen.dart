import 'package:flutter/material.dart';
import 'semester_screen.dart';
import 'saved_semesters_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HNDIT GPA Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton(context, 'Calculate GPA', const SemesterScreen()),
            const SizedBox(height: 20),
            buildButton(context, 'Saved Semesters', const SavedSemestersScreen()),
            const SizedBox(height: 20),
            buildButton(context, 'Settings', const SettingsScreen()),
          ],
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String title, Widget screen) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
          textStyle: const TextStyle(fontSize: 18),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => screen),
          );
        },
        child: Text(title),
      ),
    );
  }
}
