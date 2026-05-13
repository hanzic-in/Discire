import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);

    return Align(
      alignment:
          isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: AppSpacing.xs,
        ),
        constraints: const BoxConstraints(
          maxWidth: 280,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: isMe
              ? AppColors.primary
              : theme.card,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(
              AppRadius.lg,
            ),
            topRight: const Radius.circular(
              AppRadius.lg,
            ),
            bottomLeft: Radius.circular(
              isMe ? AppRadius.lg : AppSpacing.sm,
            ),
            bottomRight: Radius.circular(
              isMe ? AppSpacing.sm : AppRadius.lg,
            ),
          ),
          border: isMe
              ? null
              : Border.all(
                  color: theme.divider.withOpacity(0.45),
                ),
        ),
        child: Text(
          message,
          style: AppTextStyles.body(context).copyWith(
            color: isMe
                ? Colors.white
                : theme.textPrimary,
          ),
        ),
      ),
    );
  }
}
