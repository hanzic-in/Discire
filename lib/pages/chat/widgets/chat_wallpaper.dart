import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_theme.dart';

class ChatWallpaper extends StatelessWidget {
  final Widget child;

  const ChatWallpaper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);

    return Stack(
      children: [

        // BASE BACKGROUND
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF0B0B12),
                theme.background,
              ],
            ),
          ),
        ),

        // TOP GLOW
        Positioned(
          top: -180,
          right: -120,
          child: Container(
            width: 360,
            height: 360,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withOpacity(0.22),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // SECOND GLOW
        Positioned(
          bottom: -220,
          left: -120,
          child: Container(
            width: 340,
            height: 340,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF4DA2FF).withOpacity(0.16),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),

        // SVG PATTERN
        Positioned.fill(
          child: Opacity(
            opacity: 0.08,
            child: SvgPicture.asset(
              'assets/chat/wallpapers/seamless_pattern_1.svg',
              fit: BoxFit.cover,

              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.9),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),

        // DARK OVERLAY
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.12),
          ),
        ),

        child,
      ],
    );
  }
}
