/// File: lib/widgets/course_tile.dart
/// Purpose: List tile displaying course name and instructor information.

import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class CourseTile extends StatelessWidget {
  final String course;
  final String instructor;

  const CourseTile({super.key, required this.course, required this.instructor});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(course, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(instructor, style: const TextStyle(color: AppColors.grey)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
