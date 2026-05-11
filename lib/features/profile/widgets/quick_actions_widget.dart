// File: lib/features/profile/widgets/quick_actions_widget.dart
// Purpose: Horizontal quick action shortcuts with navigation and placeholder actions.

import 'package:flutter/material.dart';

import '../../../screens/attendance/attendance_screen.dart';
import '../../../screens/results/results_screen.dart';
import '../../../utils/app_theme.dart';

class QuickActionsWidget extends StatelessWidget {
  final BuildContext parentContext;

  const QuickActionsWidget({super.key, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    final actions = <(String, IconData, VoidCallback)>[
      ('Edit Profile', Icons.edit, () => _snack('Edit Profile')),
      ('Change Password', Icons.lock_outline, () => _snack('Change Password')),
      ('Transcript', Icons.description_outlined, () => _snack('Transcript')),
      ('Fee Voucher', Icons.receipt_long_outlined, () => _snack('Fee Voucher')),
      ('Request Letter', Icons.mail_outline, () => _snack('Request Letter')),
      ('Timetable', Icons.calendar_today_outlined, () => _snack('Timetable')),
      (
        'Results',
        Icons.bar_chart_outlined,
        () => Navigator.push(
          parentContext,
          MaterialPageRoute(builder: (_) => const ResultsScreen()),
        ),
      ),
      (
        'Attendance',
        Icons.check_circle_outline,
        () => Navigator.push(
          parentContext,
          MaterialPageRoute(builder: (_) => const AttendanceScreen()),
        ),
      ),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: actions.map((a) => _tile(a.$1, a.$2, a.$3)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tile(String label, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 72,
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.accent,
                child: Icon(icon, color: AppColors.primary),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _snack(String name) {
    ScaffoldMessenger.of(
      parentContext,
    ).showSnackBar(SnackBar(content: Text('$name feature coming soon')));
  }
}
