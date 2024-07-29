import 'dart:math';
import 'package:flutter/material.dart';

class EdgeSwipDetector extends StatelessWidget {
  const EdgeSwipDetector({
    super.key,
    this.child,
    this.onSwipeLeftEdge,
    this.onSwipeRightEdge,
    this.edgeWidth = 40.0,
  });

  final Widget? child;
  final Function? onSwipeRightEdge;
  final Function? onSwipeLeftEdge;
  final double edgeWidth;

  @override
  Widget build(BuildContext context) {
    bool startFromEdge = false;
    return GestureDetector(
      onHorizontalDragStart: (details) => startFromEdge = min(
              details.globalPosition.dx,
              MediaQuery.of(context).size.width - details.globalPosition.dx) <
          edgeWidth,
      onHorizontalDragEnd: (details) {
        if (startFromEdge) {
          details.primaryVelocity! < 0
              ? onSwipeRightEdge?.call()
              : onSwipeLeftEdge?.call();
        }
      },
      child: child,
    );
  }
}
