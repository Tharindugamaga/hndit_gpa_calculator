import '../models/subject.dart';

/// Grade to GPA point conversion
Map<String, double> gradeToPoint = {
  'A': 4.0,
  'B+': 3.5,
  'B': 3.0,
  'C+': 2.5,
  'C': 2.0,
  'D+': 1.5,
  'D': 1.0,
  'E': 0.0,
};

/// Function to calculate GPA from list of subjects
double calculateGpa(List<Subject> subjects) {
  double totalPoints = 0;
  int totalCredits = 0;

  for (var subject in subjects) {
    if (subject.grade != null && gradeToPoint.containsKey(subject.grade)) {
      double gradePoint = gradeToPoint[subject.grade]!;
      totalPoints += gradePoint * subject.credit;
      totalCredits += subject.credit;
    }
  }

  if (totalCredits == 0) return 0.0;

  return totalPoints / totalCredits;
}
