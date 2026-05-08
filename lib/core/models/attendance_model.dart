class AttendanceModel {
  final String id;
  final String courseName;
  final String semester;
  final double percentage;
  final int absencesAllowed;

  const AttendanceModel({
    required this.id,
    required this.courseName,
    required this.semester,
    required this.percentage,
    required this.absencesAllowed,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    final course = json['courseId'] as Map<String, dynamic>?;
    return AttendanceModel(
      id: (json['_id'] ?? '').toString(),
      courseName: (course?['name'] ?? 'Unknown Course').toString(),
      semester: (course?['semester'] ?? '').toString(),
      percentage: (json['percentage'] as num? ?? 0).toDouble(),
      absencesAllowed: (json['absencesAllowed'] as num? ?? 0).toInt(),
    );
  }
}
