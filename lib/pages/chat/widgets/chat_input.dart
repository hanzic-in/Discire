import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/theme/app_theme.dart';

class ChatInput extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInput({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> with SingleTickerProviderStateMixin {
  final FocusNode focusNode = FocusNode();
  bool hasText = false;
  bool isFocused = false;

  late AnimationController _animationController;
  late Animation<double> _splitAnimation;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
    focusNode.addListener(_onFocusChanged);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );

    _splitAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubic,
    );
  }

  void _onTextChanged() {
    final typing = widget.controller.text.trim().isNotEmpty;
    if (typing != hasText) {
      setState(() => hasText = typing);
    }
  }

  void _onFocusChanged() {
    if (focusNode.hasFocus != isFocused) {
      setState(() => isFocused = focusNode.hasFocus);
      if (focusNode.hasFocus) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);
    const double barHeight = 64.0; 

    return SafeArea(
      top: false,
      child: AnimatedBuilder(
        animation: _splitAnimation,
        builder: (context, child) {
          final double value = _splitAnimation.value;
          // Mengatur ciut lebar bar saat idle ke fokus
          final double horizontalMargin = (1 - value) * 32.0;
          final double rightGap = value * 76.0;

          return Padding(
            padding: EdgeInsets.fromLTRB(14 + horizontalMargin, 0, 14 + horizontalMargin, 12),
            child: IntrinsicHeight(
              child: Stack(
                children: [
                  
                  // ==========================================
                  // LAYER 1: GOOEY CUSTOM PAINTER (BACKGROUND)
                  // Menggambar efek melar organik yang tajam dan anti-gerigi
                  // ==========================================
                  Positioned.fill(
                    child: CustomPaint(
                      painter: GooeySplitPainter(
                        progress: value,
                        color: theme.card.withOpacity(0.94),
                        rightGap: rightGap,
                        barHeight: barHeight,
                        hasText: hasText,
                        activeColor: AppColors.primary,
                        activeColorLight: AppColors.primaryLight,
                      ),
                    ),
                  ),

                  // Border halus luar pembungkus komposer
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 380),
                    curve: Curves.easeInOutCubic,
                    left: 0,
                    right: rightGap,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(34),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.045),
                        ),
                      ),
                    ),
                  ),

                  // ==========================================
                  // LAYER 2: FOREGROUND CONTENT (INTERFACES)
                  // ==========================================
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: AnimatedPadding(
                          duration: const Duration(milliseconds: 380),
                          curve: Curves.easeInOutCubic,
                          padding: EdgeInsets.only(right: isFocused ? 12 : 0),
                          child: Container(
                            constraints: const BoxConstraints(
                              minHeight: barHeight,
                              maxHeight: 160.0,
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                  child: FaIcon(
                                    FontAwesomeIcons.faceSmile,
                                    size: 23,
                                    color: theme.textSecondary.withOpacity(0.9),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 18),
                                    child: TextField(
                                      controller: widget.controller,
                                      focusNode: focusNode,
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.newline,
                                      minLines: 1,
                                      maxLines: 5,
                                      style: AppTextStyles.body(context),
                                      cursorColor: AppColors.primary,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        hintText: 'Message on Relio...',
                                        hintStyle: AppTextStyles.body(context).copyWith(
                                          color: theme.textSecondary.withOpacity(0.72),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 20, bottom: 20),
                                  child: FaIcon(
                                    FontAwesomeIcons.paperclip,
                                    size: 23,
                                    color: theme.textSecondary.withOpacity(0.88),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // TOMBOL VOICE / SEND
                      SizedBox(
                        width: barHeight,
                        height: barHeight,
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: ScaleTransition(
                                  scale: animation,
                                  child: child,
                                ),
                              );
                            },
                            child: hasText
                                ? const Icon(
                                    Icons.send_rounded,
                                    key: ValueKey('send'),
                                    color: Colors.white,
                                    size: 26,
                                  )
                                : FaIcon(
                                    FontAwesomeIcons.microphone,
                                    key: const ValueKey('mic'),
                                    size: 22,
                                    color: isFocused ? theme.textPrimary : theme.textSecondary.withOpacity(0.88),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// CUSTOM PAINTER UNTUK EFEK JELI LENGKET (ANTI-ALIASED)
// ==========================================
class GooeySplitPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double rightGap;
  final double barHeight;
  final bool hasText;
  final Color activeColor;
  final Color activeColorLight;

  GooeySplitPainter({
    required this.progress,
    required this.color,
    required this.rightGap,
    required this.barHeight,
    required this.hasText,
    required this.activeColor,
    required this.activeColorLight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..isAntiAlias = true; // Kunci biar super halus halus tipis pinggirannya

    final radius = barHeight / 2;
    final mainPillRight = size.width - rightGap;

    // 1. Gambar Main Composer Pill (Sisi Kiri)
    final mainRRect = RRect.fromLTRBR(0, 0, mainPillRight, size.height, Radius.circular(radius));
    canvas.drawRRect(mainRRect, paint);

    // 2. Gambar Jembatan Jeli/Elastis (Hanya muncul pas progress 5% - 75%)
    if (progress > 0.05 && progress < 0.75) {
      final path = Path();
      // Faktor ketebalan jembatan yang makin mengecil saat ditarik jauh
      final gooeyFactor = (1 - (progress / 0.75)).clamp(0.0, 1.0);
      final bridgeHeight = radius * gooeyFactor;

      final startX = mainPillRight - radius;
      final endX = size.width - radius;
      final centerY = size.height / 2;

      path.moveTo(startX, centerY - radius);
      // Kurva atas jembatan jeli
      path.cubicTo(
        startX + (rightGap * 0.3), centerY - bridgeHeight,
        endX - (rightGap * 0.3), centerY - bridgeHeight,
        endX, centerY - radius,
      );
      path.lineTo(endX, centerY + radius);
      // Kurva bawah jembatan jeli
      path.cubicTo(
        endX - (rightGap * 0.3), centerY + bridgeHeight,
        startX + (rightGap * 0.3), centerY + bridgeHeight,
        startX, centerY + radius,
      );
      path.close();
      canvas.drawPath(path, paint);
    }

    // 3. Gambar Bulatan Kanannya
    final buttonPaint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    if (hasText) {
      buttonPaint.shader = LinearGradient(
        colors: [activeColorLight, activeColor],
      ).createShader(Rect.fromLTWH(size.width - barHeight, size.height - barHeight, barHeight, barHeight));
    } else {
      buttonPaint.color = color;
    }

    canvas.drawCircle(
      Offset(size.width - radius, size.height - radius),
      radius,
      buttonPaint,
    );
  }

  @override
  bool overrideWithDevicePixelRatio() => true;

  @override
  bool shouldRepaint(covariant GooeySplitPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.hasText != hasText;
  }
}
