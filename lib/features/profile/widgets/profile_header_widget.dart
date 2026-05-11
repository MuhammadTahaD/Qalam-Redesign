// File: lib/features/profile/widgets/profile_header_widget.dart
// Purpose: Collapsible profile header content for profile sliver app bar.

import 'package:flutter/material.dart';

import '../../../utils/app_theme.dart';
import '../models/student_profile.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final StudentProfile profile;

  const ProfileHeaderWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final initials = profile.fullName
        .split(' ')
        .where((e) => e.isNotEmpty)
        .take(2)
        .map((e) => e[0])
        .join()
        .toUpperCase();

    return Container(
      decoration: const BoxDecoration(gradient: AppColors.gradientPrimary),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 44,
                    backgroundColor: AppColors.white,
                    child: _buildAvatarContent(initials),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: InkWell(
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Profile photo update coming soon'),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 16,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                profile.fullName,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                profile.studentId,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _chip(
                    _programLabel(profile.programType),
                    _programColor(profile.programType),
                  ),
                  _chip(
                    _enrollmentLabel(profile.enrollmentStatus),
                    _enrollmentColor(profile.enrollmentStatus),
                  ),
                  _chip(
                    _standingLabel(profile.academicStanding),
                    _standingColor(profile.academicStanding),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                '${profile.department} · NUST-BC Quetta',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarContent(String initials) {
    if (profile.profileImagePath == null) {
      return Text(
        initials,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      );
    }
    if (profile.profileImagePath!.startsWith('http')) {
      return ClipOval(
        child: Image.network(
          profile.profileImagePath!,
          width: 88,
          height: 88,
          fit: BoxFit.cover,
        ),
      );
    }
    return ClipOval(
      child: Image.asset(
        profile.profileImagePath!,
        width: 88,
        height: 88,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _chip(String text, Color bg) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  String _programLabel(ProgramType v) => switch (v) {
    ProgramType.undergraduate => 'UG',
    ProgramType.postgraduate => 'PG',
    ProgramType.doctorate => 'PhD',
  };
  String _enrollmentLabel(EnrollmentStatus v) => switch (v) {
    EnrollmentStatus.active => 'Active',
    EnrollmentStatus.onLeave => 'On Leave',
    EnrollmentStatus.graduated => 'Graduated',
    EnrollmentStatus.suspended => 'Suspended',
  };
  String _standingLabel(AcademicStanding v) => switch (v) {
    AcademicStanding.deanslist => "Dean's List",
    AcademicStanding.goodStanding => 'Good Standing',
    AcademicStanding.probation => 'Probation',
    AcademicStanding.warning => 'Warning',
  };

  Color _programColor(ProgramType v) => switch (v) {
    ProgramType.undergraduate => AppColors.info,
    ProgramType.postgraduate => AppColors.purple,
    ProgramType.doctorate => AppColors.danger,
  };
  Color _enrollmentColor(EnrollmentStatus v) => switch (v) {
    EnrollmentStatus.active => AppColors.success,
    EnrollmentStatus.onLeave => AppColors.warning,
    EnrollmentStatus.graduated => AppColors.grey,
    EnrollmentStatus.suspended => AppColors.danger,
  };
  Color _standingColor(AcademicStanding v) => switch (v) {
    AcademicStanding.deanslist => AppColors.warning,
    AcademicStanding.probation => AppColors.danger,
    _ => AppColors.grey,
  };
}
