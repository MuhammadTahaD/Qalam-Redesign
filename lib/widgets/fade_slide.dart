/// File: lib/widgets/fade_slide.dart
/// Purpose: Animation widget applying fade and slide transitions with configurable delay.

import 'package:flutter/material.dart';

class FadeSlide extends StatelessWidget {
  final Widget child;
  final int delay;

  const FadeSlide({super.key, required this.child, this.delay = 0});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(begin: 30.0, end: 0.0),
      duration: Duration(milliseconds: 400 + delay),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, value),
          child: Opacity(opacity: 1 - (value / 30), child: child),
        );
      },
      child: child,
    );
  }
}
