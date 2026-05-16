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
    const double barHeight = 54.0;
    
    // Menggunakan isFocused sebagai trigger pembelahan (sesuai screenshot)
    final double leftGap = isFocused ? 62.0 : 0.0; 

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
        child: SizedBox(
          height: barHeight,
          child: Stack(
            children: [
              
              // ==========================================
              // LAYER 1: BACKGROUND YANG MEMBELAH (ANIMATED)
              // ==========================================

              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: barHeight,
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.card.withOpacity(0.94),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              AnimatedPositioned(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeInOutCubic,
                left: leftGap,
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.card.withOpacity(0.94),
                    borderRadius: BorderRadius.circular(27),
                  ),
                ),
              ),

              // ==========================================
              // LAYER 2: INTERFACES & ICONS (FOREGROUND)
              // ==========================================
              Row(
                children: [
                  // Tombol Plus (+) statis di posisinya
                  SizedBox(
                    width: barHeight,
                    height: barHeight,
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        size: 19,
                        color: theme.textPrimary,
                      ),
                    ),
                  ),

                  // Konten area input yang ikut bergeser secara halus
                  Expanded(
                    child: AnimatedPadding(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeInOutCubic,
                      padding: EdgeInsets.only(left: isFocused ? 8 : 0),
                      child: Row(
                        children: [
                          // TEXT FIELD
                          Expanded(
                            child: TextField(
                              controller: widget.controller,
                              focusNode: focusNode,
                              style: AppTextStyles.body(context),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                isCollapsed: true,
                                hintText: 'Balasan untuk ChatGPT...',
                                hintStyle: AppTextStyles.body(context).copyWith(
                                  color: theme.textSecondary.withOpacity(0.6),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          ),

                          // MIC ICON
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: FaIcon(
                              FontAwesomeIcons.microphone,
                              size: 19,
                              color: theme.textSecondary.withOpacity(0.85),
                            ),
                          ),

                          // RIGHT ACTION BUTTON (WAVE / SEND)
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: GestureDetector(
                              onTap: hasText ? widget.onSend : null,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: hasText ? AppColors.primary : Colors.blue[700],
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 150),
                                    child: hasText
                                        ? const Icon(
                                            Icons.arrow_upward_rounded,
                                            key: ValueKey('send'),
                                            color: Colors.white,
                                            size: 22,
                                          )
                                        : const Icon(
                                            Icons.graphic_eq_rounded,
                                            key: ValueKey('wave'),
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                    ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
