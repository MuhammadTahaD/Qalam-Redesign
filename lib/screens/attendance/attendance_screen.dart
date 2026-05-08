import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/attendance_provider.dart';
import '../../utils/app_theme.dart';
import '../../widgets/attendance_card.dart';
import '../../widgets/fade_slide.dart';
import '../../widgets/section_title.dart';

class AttendanceScreen extends ConsumerWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceAsync = ref.watch(attendanceProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Attendance',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey.shade300,
                  child: const Icon(Icons.person, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Text(
              'Track your course attendance',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 20),
            const SectionTitle(title: 'Your Courses'),
            const SizedBox(height: 10),
            Expanded(
              child: attendanceAsync.when(
                data: (courses) {
                  if (courses.isEmpty)
                    return const Center(
                      child: Text('No attendance data available'),
                    );
                  return RefreshIndicator(
                    onRefresh: () async => ref.invalidate(attendanceProvider),
                    child: ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index];
                        return FadeSlide(
                          delay: index * 100,
                          child: AttendanceCard(
                            courseName: course.courseName,
                            percentage: course.percentage,
                            remainingAbsences: course.absencesAllowed,
                            semester: course.semester,
                          ),
                        );
                      },
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) =>
                    Center(child: Text('Failed to load attendance: $e')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
