/// File: lib/widgets/gpa_card.dart
/// Purpose: Card component displaying GPA title and numeric value.

import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class GpaCard extends StatelessWidget {
  final String title;
  final double value;
  final Color? valueColor;

  const GpaCard({
    super.key,
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),

          const SizedBox(height: 8),

          Text(
            value.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: valueColor ?? AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
