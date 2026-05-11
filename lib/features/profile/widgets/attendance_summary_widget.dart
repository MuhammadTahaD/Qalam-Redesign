// File: lib/features/profile/widgets/attendance_summary_widget.dart
// Purpose: Attendance section with overall meter, warning banner and per-course attendance cards.

import 'package:flutter/material.dart';

import '../../../utils/app_theme.dart';
import '../../../widgets/attendance_card.dart';
import '../models/student_profile.dart';

class AttendanceSummaryWidget extends StatelessWidget {
  final StudentProfile profile;

  const AttendanceSummaryWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final overall = profile.attendance.isEmpty
        ? 0.0
        : profile.attendance.map((e) => e.percentage).reduce((a, b) => a + b) /
              profile.attendance.length;
    final low = profile.attendance.any((e) => e.percentage < 75);

    return Card(
      child: ExpansionTile(
        iconColor: AppColors.primary,
        title: const Text(
          'Attendance',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    value: overall / 100,
                    strokeWidth: 8,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  '${overall.toStringAsFixed(0)}%',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          if (low)
            Container(
              margin: const EdgeInsets.only(top: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.danger.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                '? Some subjects below minimum attendance threshold',
                style: TextStyle(
                  color: AppColors.danger,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          const SizedBox(height: 8),
          ...profile.attendance.map((a) {
            final limit = (a.total * 0.25).floor();
            final remaining = (limit - (a.total - a.attended)).clamp(0, 999);
            return AttendanceCard(
              courseName: '${a.courseCode} - ${a.courseName}',
              percentage: a.percentage,
              remainingAbsences: remaining,
              semester: 'Sem ${profile.currentSemester}',
            );
          }),
        ],
      ),
    );
  }
}
