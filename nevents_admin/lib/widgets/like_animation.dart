import 'package:flutter/material.dart';

class likeanimation extends StatefulWidget {
  final Widget child;
  final bool isanimating;
  final Duration duration;
  final VoidCallback? onend;
  final bool smalllike;
  const likeanimation({
    super.key,
    required this.child,
    required this.isanimating,
    this.duration = const Duration(milliseconds: 150),
    this.onend,
    this.smalllike = false,
  });

  @override
  State<likeanimation> createState() => _likeanimationState();
}

class _likeanimationState extends State<likeanimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(microseconds: widget.duration.inMilliseconds ~/ 2),
    );
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  @override
  void didUpdateWidget(covariant likeanimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isanimating != oldWidget.isanimating) {
      startanimation();
    }
  }

  startanimation() async {
    if (widget.isanimating || widget.smalllike) {
      await controller.forward();
      await controller.reverse();
      await Future.delayed(
        const Duration(milliseconds: 600),
      );

      if (widget.onend != null) {
        widget.onend!();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
