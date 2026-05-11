/// File: lib/widgets/pressable_card.dart
/// Purpose: Interactive card with scale animation on tap.

import 'package:flutter/material.dart';

class PressableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const PressableCard({super.key, required this.child, this.onTap});

  @override
  State<PressableCard> createState() => _PressableCardState();
}

class _PressableCardState extends State<PressableCard> {
  double scale = 1;

  void _onTapDown(_) {
    setState(() => scale = 0.97);
  }

  void _onTapUp(_) {
    setState(() => scale = 1);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => setState(() => scale = 1),
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 150),
        child: widget.child,
      ),
    );
  }
}
