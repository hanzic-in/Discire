import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart'; 

class MainLayout extends StatelessWidget {
  final Widget child;
  final bool usePadding;

  const MainLayout({
    super.key, 
    required this.child, 
    this.usePadding = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: theme.background,
      body: SafeArea(
        top: false,
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
