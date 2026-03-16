import 'package:flutter/material.dart';

/// Animated XP counter widget
class AnimatedXpCounter extends StatefulWidget {
  final int value;
  final TextStyle? style;

  const AnimatedXpCounter({
    super.key,
    required this.value,
    this.style,
  });

  @override
  State<AnimatedXpCounter> createState() => _AnimatedXpCounterState();
}

class _AnimatedXpCounterState extends State<AnimatedXpCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  int _displayedValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = IntTween(begin: 0, end: widget.value).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedXpCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animation = IntTween(begin: _displayedValue, end: widget.value).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOut),
      );
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        _displayedValue = _animation.value;
        return Text(
          '$_displayedValue',
          style: widget.style,
        );
      },
    );
  }
}
