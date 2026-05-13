import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../painters/chat_background_painter.dart';

class ChatBackground extends StatelessWidget {
  final Widget child;

  const ChatBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        // BASE
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF191922),
                AppThemeExtension.of(context).background,
              ],
            ),
          ),
        ),

        // GLOW
        Positioned(
          top: -140,
          right: -80,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withOpacity(0.18),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // PATTERN
        Positioned.fill(
          child: CustomPaint(
            painter: ChatBackgroundPainter(
              color: AppColors.primaryLight,
            ),
          ),
        ),

        // OVERLAY
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.18),
          ),
        ),

        child,
      ],
    );
  }
}
