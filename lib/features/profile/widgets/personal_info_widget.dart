// File: lib/features/profile/widgets/personal_info_widget.dart
// Purpose: Expandable personal info section using reusable info rows.

import 'package:flutter/material.dart';

import '../../../utils/app_theme.dart';
import '../models/student_profile.dart';

class PersonalInfoWidget extends StatelessWidget {
  final StudentProfile profile;

  const PersonalInfoWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        iconColor: AppColors.primary,
        title: const Text(
          'Personal Information',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          _InfoRow(label: 'Date of Birth', value: profile.dateOfBirth),
          _InfoRow(label: 'Gender', value: profile.gender),
          _InfoRow(label: 'Blood Group', value: profile.bloodGroup),
          _InfoRow(label: 'CNIC', value: profile.cnic),
          _InfoRow(
            label: 'University Email',
            value: profile.universityEmail,
            icon: Icons.email_outlined,
          ),
          _InfoRow(label: 'Personal Email', value: profile.personalEmail),
          _InfoRow(label: 'Phone', value: profile.phone),
          _InfoRow(label: 'Emergency Contact', value: profile.emergencyContact),
          _InfoRow(label: 'Address', value: profile.address, maxLines: 2),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final int maxLines;

  const _InfoRow({
    required this.label,
    required this.value,
    this.icon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: AppColors.primary),
            const SizedBox(width: 8),
          ],
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
