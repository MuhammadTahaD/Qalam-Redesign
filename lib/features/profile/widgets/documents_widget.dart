// File: lib/features/profile/widgets/documents_widget.dart
// Purpose: Expandable documents and digital student ID card section.

import 'package:flutter/material.dart';

import '../../../utils/app_theme.dart';
import '../models/student_profile.dart';

class DocumentsWidget extends StatelessWidget {
  final StudentProfile profile;

  const DocumentsWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final docs = const [
      'Enrollment Certificate',
      'Official Transcript',
      'Bonafide Letter',
      'Fee Challan',
    ];

    return Card(
      child: ExpansionTile(
        iconColor: AppColors.primary,
        title: const Text(
          'Documents & Student ID',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.fullName,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  profile.studentId,
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  profile.program,
                  style: const TextStyle(color: Colors.white70),
                ),
                Text(
                  profile.department,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(
                    24,
                    (i) => Container(
                      width: 2,
                      height: 20,
                      margin: const EdgeInsets.only(right: 2),
                      color: i % 2 == 0 ? AppColors.white : AppColors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.white),
                    foregroundColor: AppColors.white,
                  ),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Download ID Card coming soon'),
                    ),
                  ),
                  child: const Text('Download ID Card'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ...docs.map(
            (d) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.insert_drive_file_outlined,
                color: AppColors.primary,
              ),
              title: Text(d),
              trailing: IconButton(
                icon: const Icon(Icons.download_rounded),
                onPressed: () => ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Downloading $d...'))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
