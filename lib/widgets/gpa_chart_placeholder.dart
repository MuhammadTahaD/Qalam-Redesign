import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class GpaChartPlaceholder extends StatelessWidget {
  const GpaChartPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [_bar(3.2), _bar(3.5), _bar(3.1), _bar(3.7), _bar(3.6)],
      ),
    );
  }

  Widget _bar(double value) {
    return Container(
      width: 12,
      height: value * 25,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
