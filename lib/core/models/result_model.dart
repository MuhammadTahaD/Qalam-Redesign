/// File: lib/core/models/result_model.dart
/// Purpose: Data model for academic results and GPA.

class ResultModel {
  final String id;
  final String courseName;
  final String grade;
  final double gpa;

  const ResultModel({
    required this.id,
    required this.courseName,
    required this.grade,
    required this.gpa,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    final course = json['courseId'] as Map<String, dynamic>?;
    return ResultModel(
      id: (json['_id'] ?? '').toString(),
      courseName: (course?['name'] ?? 'Unknown Course').toString(),
      grade: (json['grade'] ?? '').toString(),
      gpa: (json['gpa'] as num? ?? 0).toDouble(),
    );
  }
}
