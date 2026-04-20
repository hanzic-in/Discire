import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final bool usePadding;
  final Color backgroundColor;

  const MainLayout({
    super.key, 
    required this.child, 
    this.usePadding = true,
    this.backgroundColor = const Color(0xFFF5F6FA),
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: usePadding ? screenWidth * 0.045 : 0,
          ),
          child: child,
        ),
      ),
    );
  }
}
