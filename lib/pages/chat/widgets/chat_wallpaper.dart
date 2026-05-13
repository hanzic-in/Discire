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

        // BASE
        Container(
          color: theme.background,
        ),

        // GLOW
        Positioned(
          top: -120,
          right: -80,
          child: Container(
            width: 260,
            height: 260,
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

        // SVG WALLPAPER
Positioned.fill(
  child: Opacity(
    opacity: 0.38,
    child: SvgPicture.asset(
      'assets/chat/wallpapers/tech_pattern.svg',
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        AppColors.primaryLight.withOpacity(0.75),
        BlendMode.srcIn,
      ),
    ),
  ),
),

        // OVERLAY
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.06),
          ),
        ),

        child,
      ],
    );
  }
}
