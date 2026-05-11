/// File: lib/widgets/gpa_line_chart.dart
/// Purpose: Animated line chart component displaying GPA progression.

import 'package:flutter/material.dart';
import '../utils/app_theme.dart';

class GpaLineChart extends StatefulWidget {
  const GpaLineChart({super.key});

  @override
  State<GpaLineChart> createState() => _GpaLineChartState();
}

class _GpaLineChartState extends State<GpaLineChart>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  final List<double> data = [3.2, 3.5, 3.1, 3.7, 3.6];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(double.infinity, 140),
          painter: _LineChartPainter(data, animation.value),
        );
      },
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> data;
  final double progress;

  _LineChartPainter(this.data, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.fill;

    final path = Path();

    double stepX = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      double x = i * stepX;
      double y = size.height - (data[i] / 4.0 * size.height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // Animate drawing
    final metric = path.computeMetrics().first;
    final extractPath = metric.extractPath(0, metric.length * progress);

    canvas.drawPath(extractPath, paint);

    // Draw dots
    for (int i = 0; i < data.length; i++) {
      double x = i * stepX;
      double y = size.height - (data[i] / 4.0 * size.height);

      canvas.drawCircle(Offset(x, y), 4 * progress, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
