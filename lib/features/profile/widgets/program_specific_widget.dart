// File: lib/features/profile/widgets/program_specific_widget.dart
// Purpose: Conditional program-specific academic and research details.

import 'package:flutter/material.dart';

import '../../../utils/app_theme.dart';
import '../models/student_profile.dart';

class ProgramSpecificWidget extends StatelessWidget {
  final StudentProfile profile;

  const ProgramSpecificWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    if (profile.programType == ProgramType.undergraduate) {
      return Card(
        child: ExpansionTile(
          iconColor: AppColors.primary,
          title: const Text(
            'Academic Details',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [
            _row('Major', profile.major ?? '-'),
            _row('Minor', profile.minor ?? '-'),
            _row('Internship Status', profile.internshipStatus ?? '-'),
          ],
        ),
      );
    }

    final research = profile.research;
    if (research == null) return const SizedBox.shrink();

    final title = profile.programType == ProgramType.postgraduate
        ? 'Research & Thesis'
        : 'PhD Research';

    return Card(
      child: ExpansionTile(
        iconColor: AppColors.primary,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          _row(
            profile.programType == ProgramType.postgraduate
                ? 'Thesis Title'
                : 'PhD Topic',
            research.title,
          ),
          _row(
            profile.programType == ProgramType.postgraduate
                ? 'Research Area'
                : 'Research Domain',
            research.researchArea,
          ),
          _row('Supervisor', research.supervisorName),
          if (research.coSupervisor != null)
            _row('Co-Supervisor', research.coSupervisor!),
          if (profile.programType == ProgramType.doctorate)
            _row('Defense Date', research.defenseDate ?? 'TBD'),
          if (profile.programType == ProgramType.doctorate)
            _statusChipRow('Defense Status', research.defenseStatus),
          _statusChipRow('Publications', '${research.publicationsCount}'),
          if (profile.programType == ProgramType.doctorate)
            _statusChipRow(
              'Conference Presentations',
              '${research.conferencePresentations}',
            ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
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
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );

  Widget _statusChipRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}
