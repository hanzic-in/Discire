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

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final typing = widget.controller.text.trim().isNotEmpty;
    if (typing != hasText) {
      setState(() {
        hasText = typing;
      });
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

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
        child: ColorFiltered(
          colorFilter: const ColorFilter.matrix([
            1, 0, 0, 0, 0,
            0, 1, 0, 0, 0,
            0, 0, 1, 0, 0,
            0, 0, 0, 18, -7,
          ]),
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: 64,
                      maxHeight: 150,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: theme.card.withOpacity(0.94),
                      borderRadius: BorderRadius.circular(34),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.faceSmile,
                          size: 23,
                          color: theme.textSecondary,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: TextField(
                            controller: widget.controller,
                            focusNode: focusNode,
                            minLines: 1,
                            maxLines: 5,
                            cursorColor: AppColors.primary,
                            style: AppTextStyles.body(context),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              isCollapsed: true,
                              hintText: 'Message on Relio...',
                              hintStyle: AppTextStyles.body(context).copyWith(
                                color: theme.textSecondary.withOpacity(0.72),
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 21),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        FaIcon(
                          FontAwesomeIcons.paperclip,
                          size: 23,
                          color: theme.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),

                AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOutCubic,
                  width: hasText ? 12 : -64,
                ),

                GestureDetector(
                  onTap: hasText ? widget.onSend : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOutCubic,
                    height: 64,
                    width: 64,
                    decoration: BoxDecoration(
                      color: theme.card.withOpacity(0.94),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: hasText
                            ? Icon(
                                Icons.send_rounded,
                                key: const ValueKey('send'),
                                color: AppColors.primary,
                                size: 26,
                              )
                            : FaIcon(
                                FontAwesomeIcons.microphone,
                                key: const ValueKey('mic'),
                                size: 23,
                                color: theme.textSecondary,
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
