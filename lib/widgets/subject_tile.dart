import 'package:flutter/material.dart';
import '../models/subject.dart';

class SubjectTile extends StatelessWidget {
  final Subject subject;
  final Function(String?) onGradeChanged;

  const SubjectTile({
    super.key,
    required this.subject,
    required this.onGradeChanged,
  });

  static const List<String> gradeOptions = [
    'A', 'B+', 'B', 'C+', 'C', 'D+', 'D', 'E'
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        title: Text(subject.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Credits: ${subject.credit}'),
        trailing: DropdownButton<String>(
          value: subject.grade,
          hint: const Text('Grade'),
          items: gradeOptions.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onGradeChanged,
        ),
      ),
    );
  }
}
