import 'package:flutter/material.dart';
import '../models/subject.dart';
import '../utils/grade_utils.dart';
import '../widgets/subject_tile.dart';
import '../models/saved_semester.dart';
import '../utils/gpa_storage.dart';

class SemesterScreen extends StatefulWidget {
  const SemesterScreen({super.key});

  @override
  State<SemesterScreen> createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen> {
  String selectedSemester = '1st Year - 1st Semester';

  final Map<String, List<Subject>> semesterSubjects = {
    '1st Year - 1st Semester': [
      Subject(name: 'Visual Application Programming', credit: 4),
      Subject(name: 'Web Design', credit: 4),
      Subject(name: 'Computer and Network Systems', credit: 3),
      Subject(name: 'Information Management Systems', credit: 4),
      Subject(name: 'ICT Project (Individual)', credit: 3),
      Subject(name: 'Communication Skills', credit: 2),
    ],
    '1st Year - 2nd Semester': [
      Subject(name: 'Fundamental Programming', credit: 4),
      Subject(name: 'Software Design', credit: 3),
      Subject(name: 'System Analysis and Design', credit: 3),
      Subject(name: 'Data Communication & Computer Networks', credit: 3),
      Subject(name: 'UI Design Principles', credit: 3),
      Subject(name: 'ICT Project (Group)', credit: 2),
      Subject(name: 'Technical Writing', credit: 2),
    ],
    '2nd Year - 1st Semester': [
      Subject(name: 'Object-Oriented Programming', credit: 4),
      Subject(name: 'Web Programming', credit: 4),
      Subject(name: 'Data Structures & Algorithms', credit: 2),
      Subject(name: 'DBMS', credit: 3),
      Subject(name: 'Operating Systems', credit: 2),
      Subject(name: 'Info & Computer Security', credit: 2),
      Subject(name: 'Statistics for IT', credit: 3),
    ],
    '2nd Year - 2nd Semester': [
      Subject(name: 'Software Engineering', credit: 2),
      Subject(name: 'Software Quality Assurance', credit: 3),
      Subject(name: 'IT Project Management', credit: 3),
      Subject(name: 'Professional World', credit: 3),
      Subject(name: 'Programming Individual Project', credit: 2),
      Subject(name: 'Elective Subject 1', credit: 4),
      Subject(name: 'Elective Subject 2', credit: 4),
    ],
  };

  List<Subject> currentSubjects = [];
  double? calculatedGpa;

  @override
  void initState() {
    super.initState();
    currentSubjects = semesterSubjects[selectedSemester]!;
  }

  Future<void> calculateGPA() async {
    double gpa = calculateGpa(currentSubjects);

    setState(() {
      calculatedGpa = gpa;
    });

    // Save GPA history
    final semester = SavedSemester(
      title: selectedSemester,
      gpa: gpa,
    );
    await GPAStorage.saveSemester(semester);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('GPA saved for $selectedSemester'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Semester & Calculate GPA'),
      ),
      body: Column(
        children: [
          // Dropdown to select semester
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DropdownButton<String>(
              value: selectedSemester,
              isExpanded: true,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedSemester = value;
                    currentSubjects = semesterSubjects[value]!;
                    calculatedGpa = null;
                  });
                }
              },
              items: semesterSubjects.keys.map((sem) {
                return DropdownMenuItem(
                  value: sem,
                  child: Text(sem),
                );
              }).toList(),
            ),
          ),

          // List of subjects
          Expanded(
            child: ListView.builder(
              itemCount: currentSubjects.length,
              itemBuilder: (context, index) {
                return SubjectTile(
                  subject: currentSubjects[index],
                  onGradeChanged: (grade) {
                    setState(() {
                      currentSubjects[index].grade = grade;
                    });
                  },
                );
              },
            ),
          ),

          // GPA result
          if (calculatedGpa != null)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'GPA: ${calculatedGpa!.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

          // Button
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.calculate),
              label: const Text('Calculate GPA'),
              onPressed: calculateGPA,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
