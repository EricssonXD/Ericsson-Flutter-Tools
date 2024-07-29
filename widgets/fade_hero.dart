import 'package:flutter/material.dart';

class FadeHero extends StatelessWidget {
  final String tag;
  final Widget child;

  const FadeHero({super.key, required this.tag, required this.child});

  @override
  Widget build(BuildContext context) {
    return Hero(
      createRectTween: (begin, end) {
        return MaterialRectArcTween(begin: begin, end: end);
      },
      tag: tag,
      flightShuttleBuilder: (flightContext, animation, flightDirection,
          fromHeroContext, toHeroContext) {
        return Stack(children: [
          Positioned.fill(child: fromHeroContext.widget),
          Positioned.fill(child: toHeroContext.widget),
        ]);
      },
      child: FadeTransition(
        opacity: ModalRoute.of(context)?.animation ??
            const AlwaysStoppedAnimation(1),
        child: FadeTransition(
          opacity: ReverseAnimation(
              ModalRoute.of(context)?.secondaryAnimation ??
                  const AlwaysStoppedAnimation(1)),
          child: SizedBox(
            width: double.infinity,
            child: child,
          ),
        ),
      ),
    );
  }
}
