import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ChatInput extends StatelessWidget {
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

    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenPadding,
        AppSpacing.md,
        AppSpacing.screenPadding,
        AppSpacing.xl,
      ),
      decoration: BoxDecoration(
        color: theme.background.withOpacity(0.94),
        border: Border(
          top: BorderSide(
            color: theme.divider.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
              ),
              height: 56,
              decoration: BoxDecoration(
                color: theme.searchBar,
                borderRadius: BorderRadius.circular(
                  AppRadius.pill,
                ),
                border: Border.all(
                  color: theme.searchBarBorder,
                ),
              ),
              child: TextField(
                controller: controller,
                textAlignVertical: TextAlignVertical.center,
                style: AppTextStyles.body(context),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  filled: false,
                  contentPadding: EdgeInsets.zero,
                  hintText: "Type a message...",
                  hintStyle: AppTextStyles.bodySecondary(context),
                )
              ),
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          GestureDetector(
            onTap: onSend,
            child: Container(
              height: 56,
              width: 56,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryLight,
                    AppColors.primary,
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.send_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
