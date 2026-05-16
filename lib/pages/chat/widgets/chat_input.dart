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
    const double minBarHeight = 64.0; 
    final double rightGap = isFocused ? 76.0 : 0.0; 

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
        // Menggunakan IntrinsicHeight agar tinggi Stack mengikuti tinggi Row di depannya secara dinamis
        child: IntrinsicHeight(
          child: Stack(
            children: [
              
              // ==========================================
              // LAYER 1: BACKGROUND SYSTEM (DYNAMIC HEIGHT)
              // ==========================================
              
              // 1a. Lingkaran Background Tombol Kanan (Voice / Send)
              Positioned(
                right: 0,
                bottom: 0, // Kunci di bawah agar sejajar saat composer meninggi
                width: minBarHeight,
                height: minBarHeight,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: hasText
                        ? const LinearGradient(
                            colors: [AppColors.primaryLight, AppColors.primary],
                          )
                        : null,
                    color: hasText ? null : theme.card.withOpacity(0.94),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              // 1b. Pill Background Utama (Main Composer)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeInOutCubic,
                left: 0,
                right: rightGap,
                top: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.card.withOpacity(0.94),
                    borderRadius: BorderRadius.circular(34),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.045),
                    ),
                  ),
                ),
              ),

              // ==========================================
              // LAYER 2: INTERFACES & ICONS (FOREGROUND)
              // ==========================================
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: AnimatedPadding(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeInOutCubic,
                      padding: EdgeInsets.only(right: isFocused ? 12 : 0),
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: minBarHeight,
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

                  // TOMBOL INTERAKSI KANAN (VOICE / SEND)
                  SizedBox(
                    width: minBarHeight,
                    height: minBarHeight,
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 180),
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
