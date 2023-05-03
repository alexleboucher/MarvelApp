import 'package:flutter/material.dart';

class AnimatedHeart extends StatefulWidget {
  const AnimatedHeart({
    required this.child,
    required this.isAnimating,
    required this.duration,
    required this.onAnimationEnd,
    super.key,
  });

  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback onAnimationEnd;

  @override
  State<AnimatedHeart> createState() => _AnimatedHeartState();
}

class _AnimatedHeartState extends State<AnimatedHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2),
    );
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedHeart oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isAnimating != oldWidget.isAnimating) {
      runAnimation();
    }
  }

  Future<void> runAnimation() async {
    await controller.forward();
    await Future<void>.delayed(const Duration(milliseconds: 50));
    await controller.reverse();
    await Future<void>.delayed(const Duration(milliseconds: 150));
    widget.onAnimationEnd();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
