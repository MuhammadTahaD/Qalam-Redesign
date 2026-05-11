// File: lib/features/profile/screens/profile_screen.dart
// Purpose: Cohesive sliver-based student profile screen with modular sections.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/providers/auth_provider.dart';
import '../providers/profile_provider.dart';
import '../widgets/academic_performance_widget.dart';
import '../widgets/attendance_summary_widget.dart';
import '../widgets/documents_widget.dart';
import '../widgets/financial_summary_widget.dart';
import '../widgets/personal_info_widget.dart';
import '../widgets/profile_header_widget.dart';
import '../widgets/program_specific_widget.dart';
import '../widgets/quick_actions_widget.dart';
import '../widgets/settings_logout_widget.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(studentProfileProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            title: const Text('Profile'),
            actions: [
              IconButton(
                onPressed: () => ref.read(authProvider.notifier).logout(),
                icon: const Icon(Icons.logout),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: ProfileHeaderWidget(profile: profile),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                AcademicPerformanceWidget(profile: profile),
                AttendanceSummaryWidget(profile: profile),
                PersonalInfoWidget(profile: profile),
                ProgramSpecificWidget(profile: profile),
                FinancialSummaryWidget(profile: profile),
                DocumentsWidget(profile: profile),
                QuickActionsWidget(parentContext: context),
                const SettingsAndLogoutWidget(),
                const SizedBox(height: 12),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
