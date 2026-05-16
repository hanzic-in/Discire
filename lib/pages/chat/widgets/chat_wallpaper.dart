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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF141419),
                theme.background,
              ],
            ),
          ),
        ),

        // SVG PATTERN
        Positioned.fill(
          child: Opacity(
            opacity: 0.08,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
              ),
              itemCount: 8,
              itemBuilder: (context, index) {
                return SvgPicture.asset(
                  'assets/chat/wallpapers/relio_pattern.svg',
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryLight.withOpacity(0.9),
                    BlendMode.srcIn,
                  ),
                );
              },
            ),
          ),
        ),

        // DARK OVERLAY
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.10),
          ),
        ),

        child,
      ],
    );
  }
}
