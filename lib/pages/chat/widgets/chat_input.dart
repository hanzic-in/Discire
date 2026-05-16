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
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);
    const double minBarHeight = 64.0; 
    
    final double rightGap = isFocused ? 76.0 : 0.0; 
    final double horizontalMargin = isFocused ? 0.0 : 32.0;

    return SafeArea(
      top: false,
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.fromLTRB(14 + horizontalMargin, 0, 14 + horizontalMargin, 12),
        child: IntrinsicHeight(
          child: Stack(
            children: [
              
              // ==========================================
              // LAYER 1: BACKGROUND SYSTEM (DYNAMIC HEIGHT & WIDTH)
              // ==========================================
              
              Positioned(
                right: 0,
                bottom: 0,
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
