class CourseModel {
  final String id;
  final String name;
  final String instructor;
  final String semester;

  const CourseModel({
    required this.id,
    required this.name,
    required this.instructor,
    required this.semester,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: (json['_id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      instructor: (json['instructor'] ?? '').toString(),
      semester: (json['semester'] ?? '').toString(),
    );
  }
}
