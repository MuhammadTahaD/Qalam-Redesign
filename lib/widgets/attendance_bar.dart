import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class AttendanceBar extends StatelessWidget {
  final String subject;
  final double percentage;

  const AttendanceBar({
    super.key,
    required this.subject,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final isLow = percentage < 75;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$subject - ${percentage.toStringAsFixed(0)}%",
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: percentage / 100,
          backgroundColor: Colors.grey.shade300,
          valueColor: AlwaysStoppedAnimation(
            isLow ? AppColors.danger : AppColors.primary,
          ),
        ),
      ],
    );
  }
}
