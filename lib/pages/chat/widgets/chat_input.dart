import 'dart:ui';
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

class _ChatInputState extends State<ChatInput> {
  final FocusNode focusNode = FocusNode();
  bool hasText = false;
  bool isFocused = false;

  static const Duration _animationDuration = Duration(milliseconds: 400);
  static const Curve _animationCurve = Curves.easeInOutCubic;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
    focusNode.addListener(_onFocusChanged);
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
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);
    const double barHeight = 64.0;
    
    // Pergeseran tombol interaksi (Voice / Send) ke kanan
    final double buttonTargetRight = isFocused ? 0.0 : 0.0; 
    final double mainPillRightGap = isFocused ? 76.0 : 0.0;
    final double horizontalMargin = isFocused ? 0.0 : 32.0;

    return SafeArea(
      top: false,
      child: AnimatedPadding(
        duration: _animationDuration,
        curve: _animationCurve,
        padding: EdgeInsets.fromLTRB(14 + horizontalMargin, 0, 14 + horizontalMargin, 12),
        child: IntrinsicHeight(
          child: Stack(
            children: [
              
              // ==========================================
              // LAYER 1: THE METABALL GOOEY EFFECT (BACKGROUND ONLY)
              // Layer khusus efek visual melar lengket seperti cairan/virus pembelahan
              // ==========================================
              ColorFiltered(
                colorFilter: const ColorFilter.matrix([
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 38, -18, // Mengasah pinggiran blur menjadi padat dan tajam kembali
                ]),
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 12, sigmaY: 12), // Melelehkan objek agar lengket
                  child: Stack(
                    children: [
                      // 1a. Background Utama (Main Composer Pill)
                      AnimatedPositioned(
                        duration: _animationDuration,
                        curve: _animationCurve,
                        left: 0,
                        right: mainPillRightGap,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.card.withOpacity(0.96),
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                      ),

                      // 1b. Background Bulatan Kanan (Anakan Sel yang Ketarik Melar)
                      AnimatedPositioned(
                        duration: _animationDuration,
                        curve: _animationCurve,
                        right: buttonTargetRight,
                        bottom: 0,
                        width: barHeight,
                        height: barHeight,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 240),
                          decoration: BoxDecoration(
                            gradient: hasText
                                ? const LinearGradient(
                                    colors: [AppColors.primaryLight, AppColors.primary],
                                  )
                                : null,
                            color: hasText ? null : theme.card.withOpacity(0.96),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Border halus pembungkus luar (Opsional, ditaruh di luar filter biar tajam)
              AnimatedPositioned(
                duration: _animationDuration,
                curve: _animationCurve,
                left: 0,
                right: mainPillRightGap,
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
              // LAYER 2: INTERFACES & ICONS (FOREGROUND)
              // Layer murni interaksi, bersih dari filter jadi anti-error dan responsif
              // ==========================================
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: AnimatedPadding(
                      duration: _animationDuration,
                      curve: _animationCurve,
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
                            // EMOJI ICON
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                              child: FaIcon(
                                FontAwesomeIcons.faceSmile,
                                size: 23,
                                color: theme.textSecondary.withOpacity(0.9),
                              ),
                            ),

                            // TEXT FIELD
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

                            // ATTACHMENT ICON
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

                  // INTERACTION BUTTON (VOICE / SEND)
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
      ),
    );
  }
}
