/// File: lib/widgets/grade_tile.dart
/// Purpose: Tile showing course name and grade with navigation to course details.

import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../screens/course/course_detail_screen.dart';

class GradeTile extends StatelessWidget {
  final String course;
  final String grade;

  const GradeTile({super.key, required this.course, required this.grade});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => CourseDetailScreen(courseName: course),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(course, style: const TextStyle(fontWeight: FontWeight.w500)),
            Text(
              grade,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
