// File: lib/features/profile/widgets/financial_summary_widget.dart
// Purpose: Student financial overview with fee status, dues, scholarship, and history action.

import 'package:flutter/material.dart';

import '../../../utils/app_theme.dart';
import '../../../widgets/pressable_card.dart';
import '../models/student_profile.dart';

class FinancialSummaryWidget extends StatelessWidget {
  final StudentProfile profile;

  const FinancialSummaryWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Financial Summary',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 10),
            _chip(_feeLabel(profile.feeStatus), _feeColor(profile.feeStatus)),
            const SizedBox(height: 10),
            Text(
              'Outstanding Dues',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            Text(
              'PKR ${profile.outstandingDues.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: profile.outstandingDues > 0
                    ? AppColors.danger
                    : AppColors.success,
              ),
            ),
            if (profile.scholarshipName != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      profile.scholarshipName!,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${profile.scholarshipDiscount?.toStringAsFixed(0) ?? 0}%',
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 12),
            PressableCard(
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Payment history feature coming soon'),
                ),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'View Payment History',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String text, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  String _feeLabel(FeeStatus s) => switch (s) {
    FeeStatus.paid => 'Paid',
    FeeStatus.pending => 'Pending',
    FeeStatus.partial => 'Partial',
  };
  Color _feeColor(FeeStatus s) => switch (s) {
    FeeStatus.paid => AppColors.success,
    FeeStatus.pending => AppColors.danger,
    FeeStatus.partial => AppColors.warning,
  };
}
