import 'package:flutter/material.dart';
import '../models/saved_semester.dart';
import '../utils/gpa_storage.dart';

class SavedSemestersScreen extends StatefulWidget {
  const SavedSemestersScreen({super.key});

  @override
  State<SavedSemestersScreen> createState() => _SavedSemestersScreenState();
}

class _SavedSemestersScreenState extends State<SavedSemestersScreen> {
  List<SavedSemester> history = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final data = await GPAStorage.loadSavedSemesters();
    setState(() {
      history = data;
    });
  }

  void _clearHistory() async {
    await GPAStorage.clearAll();
    setState(() {
      history = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved GPA History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _clearHistory,
          ),
        ],
      ),
      body: history.isEmpty
          ? const Center(child: Text("No GPA history yet."))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final semester = history[index];
                return ListTile(
                  title: Text(semester.title),
                  trailing: Text(
                    semester.gpa.toStringAsFixed(2),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
    );
  }
}
