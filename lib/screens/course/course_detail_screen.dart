import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import '../../widgets/section_title.dart';
import '../../widgets/fade_slide.dart';

class CourseDetailScreen extends StatefulWidget {
  final String courseName;

  const CourseDetailScreen({super.key, required this.courseName});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  String selectedSection = "Assignments";

  final Map<String, List<Map<String, dynamic>>> data = {
    "Assignments": [
      {"title": "Assignment 1", "marks": "6 / 10"},
      {"title": "Assignment 2", "marks": "6 / 10"},
      {"title": "Assignment 3", "marks": "0 / 10"},
    ],
    "Quiz": [
      {"title": "Quiz 1", "marks": "6.5 / 10"},
      {"title": "Quiz 2", "marks": "8 / 10"},
      {"title": "Quiz 3", "marks": "0 / 10"},
    ],
    "Project": [
      {"title": "Project 1", "marks": "0 / 10"},
      {"title": "Project 2", "marks": "0 / 10"},
    ],
    "Mid": [
      {"title": "Mid Term", "marks": "16 / 30"},
    ],
    "Final": [
      {"title": "Final Term", "marks": "--"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final items = data[selectedSection]!;

    return Scaffold(
      backgroundColor: AppColors.background,

      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.courseName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            const SizedBox(height: 10),

            const Text(
              "Detailed performance breakdown",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // 🔽 DROPDOWN
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButton<String>(
                value: selectedSection,
                isExpanded: true,
                underline: const SizedBox(),
                items: data.keys.map((section) {
                  return DropdownMenuItem(value: section, child: Text(section));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedSection = value!;
                  });
                },
              ),
            ),

            const SizedBox(height: 20),

            SectionTitle(title: selectedSection),

            const SizedBox(height: 10),

            // 🔹 LIST
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return FadeSlide(
                    delay: index * 80,
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
                          Text(
                            item["title"],
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            item["marks"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
