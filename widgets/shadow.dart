import 'dart:ui';

import 'package:flutter/material.dart';

class UniversalShadow extends StatelessWidget {
  final Widget child;
  // a color overlay panel between the child and the shadow
  final Color overlayColor;
  // the scale of the shadow compared to the actual widget
  final double scale;
  // the offset of the shadow compared to the actual widget
  final Offset offset;
  // the blur value o the shadow
  final double blur;

  // if true, the shadow will be clipped to the child widget
  final bool clip;

  const UniversalShadow({
    super.key,
    required this.child,
    this.overlayColor = Colors.black,
    this.scale = 1,
    this.offset = const Offset(0, 0),
    this.blur = 10,
    this.clip = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: UniqueKey(),
      alignment: Alignment.center,
      children: <Widget>[
        ClipRect(
          clipBehavior: clip ? Clip.hardEdge : Clip.none,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: blur,
              sigmaY: blur,
            ),
            child: Transform.translate(
              offset: offset,
              child: Transform.scale(
                scale: scale,
                child: ShaderMask(
                  shaderCallback: (bounds) => RadialGradient(
                    center: Alignment.topLeft,
                    radius: 1.0,
                    colors: <Color>[overlayColor, overlayColor],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds),
                  blendMode: BlendMode.srcIn,
                  child: child,
                ),
              ),
            ),
          ),
        ),
        // the child widget is always on top of the shadow
        child,
      ],
    );
  }
}

// class _Blur extends StatelessWidget {
//   final Widget child;
//   final double blur;
//   const _Blur({required this.child, this.blur = 10});

//   @override
//   Widget build(BuildContext context) {
//     return ImageFiltered(
//       imageFilter: ImageFilter.blur(
//         sigmaX: blur,
//         sigmaY: blur,
//       ),
//       child: child,
//     );
//   }
// }
