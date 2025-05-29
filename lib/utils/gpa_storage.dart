import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/saved_semester.dart';

class GPAStorage {
  static const String _key = 'gpa_history';

  static Future<List<SavedSemester>> loadSavedSemesters() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data
        .map((e) => SavedSemester.fromJson(json.decode(e)))
        .toList();
  }

  static Future<void> saveSemester(SavedSemester semester) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await loadSavedSemesters();
    history.add(semester);
    final encoded = history.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList(_key, encoded);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
