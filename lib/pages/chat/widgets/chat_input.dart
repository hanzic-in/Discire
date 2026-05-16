import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/theme/app_theme.dart';

class ChatInput extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInput({super.key, required this.controller, required this.onSend});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final FocusNode focusNode = FocusNode();
  bool hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      final typing = widget.controller.text.trim().isNotEmpty;
      if (typing != hasText) setState(() => hasText = typing);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);
    final double buttonSize = 64.0;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
        child: SizedBox(
          height: 150,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              ColorFiltered(
                colorFilter: const ColorFilter.matrix([
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 25, -12, 
                ]),
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 64,
                          decoration: BoxDecoration(
                            color: theme.card,
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOutBack,
                        width: hasText ? 10 : -50,
                      ),
                      Container(
                        width: buttonSize,
                        height: buttonSize,
                        decoration: BoxDecoration(
                          color: theme.card,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      height: 64,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.faceSmile, size: 22, color: theme.textSecondary),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: widget.controller,
                              focusNode: focusNode,
                              style: AppTextStyles.body(context),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Message...',
                                isCollapsed: true,
                              ),
                            ),
                          ),
                          FaIcon(FontAwesomeIcons.paperclip, size: 22, color: theme.textSecondary),
                        ],
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOutBack,
                    width: hasText ? 10 : -50,
                  ),
                  GestureDetector(
                    onTap: hasText ? widget.onSend : null,
                    child: SizedBox(
                      width: buttonSize,
                      height: buttonSize,
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: hasText
                              ? Icon(Icons.send_rounded, key: ValueKey('s'), color: AppColors.primary, size: 28)
                              : FaIcon(FontAwesomeIcons.microphone, key: ValueKey('m'), size: 22, color: theme.textSecondary),
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
