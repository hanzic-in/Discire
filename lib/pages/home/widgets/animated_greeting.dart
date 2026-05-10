import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedGreeting extends StatefulWidget {
  final String text;
  final TextStyle? style;

  const AnimatedGreeting({
    super.key,
    required this.text,
    this.style,
  });

  @override
  State<AnimatedGreeting> createState() => _AnimatedGreetingState();
}

class _AnimatedGreetingState extends State<AnimatedGreeting>
    with SingleTickerProviderStateMixin {
  String visibleText = "";
  Timer? timer;

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.025, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutQuart,
      ),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutQuart,
      ),
    );

    _controller.forward();

    _startTyping();
  }

  void _startTyping() {
    int index = 0;

    timer = Timer.periodic(
      const Duration(milliseconds: 68),
      (timer) {
        if (index < widget.text.length) {
          setState(() {
            visibleText += widget.text[index];
          });
          index++;
        } else {
          timer.cancel();
        }
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          switchInCurve: Curves.easeOut,
          child: Text(
            visibleText,
            key: ValueKey(visibleText),
            style: widget.style ??
            const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Color(0xFF171717),
              letterSpacing: -0.6,
            ),
          ),
        ),
      ),
    );
  }
}
