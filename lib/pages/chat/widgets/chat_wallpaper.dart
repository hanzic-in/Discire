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

    Container(
      color: Colors.black,
    ),

    Positioned.fill(
  child: Opacity(
    opacity: 0.10,
    child: Transform.scale(
      scale: 0.42,
      child: SvgPicture.asset(
        'assets/chat/wallpapers/seamless_pattern_1.svg',
        fit: BoxFit.contain,
        alignment: Alignment.topLeft,
      ),
    ),
  ),
),

    child,
  ],
);
    
  }
}
