import 'dart:math';

import 'package:flutter/material.dart';

/// A bottom up expandable sheet
class MyExpandableSheet extends StatefulWidget {
  const MyExpandableSheet({
    super.key,
    required this.builder,
    this.minHeight = 200,
    this.maxHeight = 500,
    this.startingSize = 200,
  });
  final Widget Function(double height) builder;
  final double minHeight;
  final double maxHeight;
  final double startingSize;
  @override
  State<MyExpandableSheet> createState() => _MyExpandableSheetState();
}

class _MyExpandableSheetState extends State<MyExpandableSheet> {
  double bannerHeight = 200;
  Duration animationDuration = Duration.zero;
  @override
  void initState() {
    super.initState();
    setState(() {
      bannerHeight = min(widget.startingSize, widget.maxHeight);
    });
  }

  void hide() => setState(() {
        animationDuration = const Duration(milliseconds: 250);
        bannerHeight = widget.minHeight;
        Future.delayed(const Duration(milliseconds: 100),
            () => animationDuration = Duration.zero);
      });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      height: bannerHeight,
      curve: Curves.easeInOutCubic,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Stack(
        children: [
          /// The builder that builds the childrens
          widget.builder(bannerHeight),
          GestureDetector(
            /// This part creates the snap effect
            onTap: () {
              animationDuration = const Duration(milliseconds: 250);
              setState(() {
                if (bannerHeight == widget.maxHeight * 0.7) {
                  bannerHeight = widget.minHeight;
                } else {
                  bannerHeight = widget.maxHeight * 0.7;
                }
              });
              Future.delayed(const Duration(milliseconds: 100),
                  () => animationDuration = Duration.zero);
            },
            onVerticalDragEnd: (details) {
              animationDuration = const Duration(milliseconds: 100);
              setState(() {
                if (bannerHeight > widget.maxHeight * 0.9) {
                  bannerHeight = widget.maxHeight;
                } else if (bannerHeight > widget.maxHeight * 0.25) {
                  bannerHeight = widget.maxHeight * 0.7;
                } else {
                  bannerHeight = widget.minHeight;
                }
              });
              Future.delayed(const Duration(milliseconds: 100),
                  () => animationDuration = Duration.zero);
            },

            /// This part controls the update on dragging
            onVerticalDragUpdate: (DragUpdateDetails details) {
              setState(() {
                double positionY = details.globalPosition.dy;
                double maxHeight = MediaQuery.of(context).size.height - 100;

                /// Limits at widget.minHeight height minimum
                if (positionY > maxHeight - widget.minHeight) {
                  bannerHeight = widget.minHeight;
                } else if (positionY <= maxHeight) {
                  bannerHeight = min(maxHeight - positionY, widget.maxHeight);
                }
              });
            },
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              child: const Icon(
                Icons.drag_handle,
                // color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
