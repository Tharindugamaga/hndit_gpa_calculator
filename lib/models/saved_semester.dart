class SavedSemester {
  final String title;
  final double gpa;

  SavedSemester({required this.title, required this.gpa});

  Map<String, dynamic> toJson() => {
        'title': title,
        'gpa': gpa,
      };

  factory SavedSemester.fromJson(Map<String, dynamic> json) {
    return SavedSemester(
      title: json['title'],
      gpa: json['gpa'],
    );
  }
}
