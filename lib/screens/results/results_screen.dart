// File: lib/screens/results/results_screen.dart
// Purpose: Results overview with GPA cards, trend chart, and course grades.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/results_provider.dart';
import '../../utils/app_theme.dart';
import '../../widgets/fade_slide.dart';
import '../../widgets/gpa_card.dart';
import '../../widgets/gpa_line_chart.dart';
import '../../widgets/grade_tile.dart';
import '../../widgets/section_title.dart';

class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({super.key});

  Color _gpaColor(double gpa) {
    if (gpa >= 3.5) return AppColors.success;
    if (gpa >= 2.5) return AppColors.warning;
    return AppColors.danger;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resultsAsync = ref.watch(resultsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Results',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Spring 2026 · Semester 4',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 20),
            resultsAsync.when(
              data: (items) {
                final cgpa = items.isEmpty
                    ? 0.0
                    : items.map((e) => e.gpa).reduce((a, b) => a + b) /
                          items.length;
                final sgpa = items.isEmpty
                    ? 0.0
                    : items.take(3).map((e) => e.gpa).reduce((a, b) => a + b) /
                          items.take(3).length;
                return Row(
                  children: [
                    Expanded(
                      child: GpaCard(
                        title: 'CGPA',
                        value: cgpa,
                        valueColor: _gpaColor(cgpa),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GpaCard(
                        title: 'Semester GPA',
                        value: sgpa,
                        valueColor: _gpaColor(sgpa),
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('Failed to load GPA: $e'),
            ),
            const SizedBox(height: 20),
            const SectionTitle(title: 'Performance Trend'),
            const SizedBox(height: 10),
            FadeSlide(
              delay: 100,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const GpaLineChart(),
              ),
            ),
            const SizedBox(height: 20),
            const SectionTitle(title: 'Course Grades'),
            const SizedBox(height: 10),
            Expanded(
              child: resultsAsync.when(
                data: (items) {
                  if (items.isEmpty) {
                    return const Center(child: Text('No results available'));
                  }
                  return ListView(
                    children: items
                        .map(
                          (item) => GradeTile(
                            course: item.courseName,
                            grade: item.grade,
                          ),
                        )
                        .toList(),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) =>
                    Center(child: Text('Failed to load results: $e')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
