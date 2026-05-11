// File: lib/features/profile/widgets/academic_performance_widget.dart
// Purpose: Academic performance section with GPA cards, credits progress, trend and course grades.

import 'package:flutter/material.dart';

import '../../../utils/app_theme.dart';
import '../../../widgets/gpa_card.dart';
import '../../../widgets/gpa_line_chart.dart';
import '../models/student_profile.dart';

class AcademicPerformanceWidget extends StatelessWidget {
  final StudentProfile profile;

  const AcademicPerformanceWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final creditProgress =
        profile.creditHoursCompleted / profile.creditHoursRequired;

    return Card(
      child: ExpansionTile(
        initiallyExpanded: true,
        iconColor: AppColors.primary,
        title: const Text(
          'Academic Performance',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          Row(
            children: [
              Expanded(
                child: GpaCard(
                  title: 'CGPA',
                  value: profile.cgpa,
                  valueColor: _gpaColor(profile.cgpa),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GpaCard(
                  title: 'Semester GPA',
                  value: profile.semesterGpa,
                  valueColor: _gpaColor(profile.semesterGpa),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Credits: ${profile.creditHoursCompleted} / ${profile.creditHoursRequired}',
              ),
              Text('${(creditProgress * 100).toStringAsFixed(0)}%'),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: creditProgress.clamp(0, 1),
            color: AppColors.primary,
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const GpaLineChart(),
          ),
          const SizedBox(height: 14),
          ...profile.currentCourses.map(
            (c) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                c.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                '${c.code} · ${c.creditHours} CH',
                style: const TextStyle(color: AppColors.textSecondary),
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: _gradeColor(c.grade).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  c.grade,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _gradeColor(c.grade),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _gpaColor(double gpa) => gpa >= 3.5
      ? AppColors.success
      : (gpa >= 2.5 ? AppColors.warning : AppColors.danger);

  Color _gradeColor(String g) {
    if (g == '--') return AppColors.grey;
    if (g.startsWith('A')) return AppColors.success;
    if (g.startsWith('B')) return AppColors.info;
    return AppColors.warning;
  }
}
