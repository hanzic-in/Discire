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
    const double buttonSize = 64.0;
    const double composerHeight = 64.0;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
        child: SizedBox(
          height: composerHeight, 
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              
              ColorFiltered(
                colorFilter: const ColorFilter.matrix([
                  1, 0, 0, 0, 0,
                  0, 1, 0, 0, 0,
                  0, 0, 1, 0, 0,
                  0, 0, 0, 30, -15, 
                ]),
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 0),
                        height: composerHeight,
                        decoration: BoxDecoration(
                          color: theme.card,
                          borderRadius: BorderRadius.circular(32),
                        ),
                      ),
                      
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutQuart,
                        right: hasText ? -74 : 0,
                        child: Container(
                          width: buttonSize,
                          height: buttonSize,
                          decoration: BoxDecoration(
                            color: theme.card,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: composerHeight,
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
                    curve: Curves.easeOutQuart,
                    width: hasText ? 10 : 0,
                  ),

                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutQuart,
                    width: hasText ? buttonSize : 0,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: hasText ? 1 : 0,
                      child: GestureDetector(
                        onTap: widget.onSend,
                        child: Container(
                          width: buttonSize,
                          height: buttonSize,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          child: Center(
                            child: Icon(Icons.send_rounded, color: AppColors.primary, size: 28),
                          ),
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
