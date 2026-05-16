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
    const double inputHeight = 54.0; // Tinggi pill ala ChatGPT

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            
            // ==========================================
            // TOMBOL PLUS (+) YANG MEMISAHKAN DIRI
            // ==========================================
            GestureDetector(
              onTap: () {}, // Aksi tombol plus
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeInOutCubic,
                height: inputHeight,
                width: inputHeight,
                decoration: BoxDecoration(
                  // Pas fokus, dia memisahkan diri & dapet background bulat sendiri
                  color: isFocused ? theme.card.withOpacity(0.94) : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.plus,
                    size: 20,
                    color: theme.textPrimary,
                  ),
                ),
              ),
            ),

            // Jeda dinamis pas dia memisah
            AnimatedContainer(
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeInOutCubic,
              width: isFocused ? 8 : 0,
            ),

            // ==========================================
            // MAIN INPUT COMPOSER
            // ==========================================
            // ==========================================
// MAIN INPUT COMPOSER
// ==========================================
Expanded(
  child: AnimatedContainer(
    duration: const Duration(milliseconds: 260),
    curve: Curves.easeInOutCubic,
    // Perbaikan: Bungkus minHeight & maxHeight di dalam BoxConstraints
    constraints: BoxConstraints(
      minHeight: inputHeight,
      maxHeight: 150,
    ),
    padding: EdgeInsets.only(
      // Pas IDLE (tidak fokus), padding kiri 0 agar tombol plus menempel masuk
      left: isFocused ? 16 : 0, 
      right: 6,
    ),
    decoration: BoxDecoration(
      color: theme.card.withOpacity(0.94),
      borderRadius: BorderRadius.circular(28),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        
        // TEXT FIELD
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
              hintText: 'Balasan untuk ChatGPT...',
              hintStyle: AppTextStyles.body(context).copyWith(
                color: theme.textSecondary.withOpacity(0.6),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),

        // ICON MIC KECIL DI DALAM
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FaIcon(
            FontAwesomeIcons.microphone,
            size: 20,
            color: theme.textSecondary.withOpacity(0.8),
          ),
        ),

        // TOMBOL AKSI KANAN (AUDIO WAVE / SEND)
        GestureDetector(
          onTap: hasText ? widget.onSend : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 42,
            width: 42,
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
                        size: 24,
                      )
                    : const Icon(
                        Icons.graphic_eq_rounded,
                        key: ValueKey('wave'),
                        color: Colors.white,
                        size: 20,
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
      ),
    );
  }
}
