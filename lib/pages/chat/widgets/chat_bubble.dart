import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String time;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);

    return Align(
      alignment:
          isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: AppSpacing.md,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        constraints: const BoxConstraints(
          maxWidth: 290,
        ),
        decoration: BoxDecoration(
          gradient: isMe
              ? const LinearGradient(
                  colors: [
                    AppColors.primaryLight,
                    AppColors.primary,
                  ],
                )
              : null,
          color: isMe ? null : theme.card,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppRadius.md),
            topRight: const Radius.circular(AppRadius.md),
            bottomLeft: Radius.circular(
              isMe ? AppRadius.md : 6,
            ),
            bottomRight: Radius.circular(
              isMe ? 6 : AppRadius.md,
            ),
          ),
          border: Border.all(
            color: theme.divider.withOpacity(0.15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: AppTextStyles.body(context).copyWith(
                color: isMe
                    ? Colors.white
                    : theme.textPrimary,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              time,
              style: AppTextStyles.caption(context).copyWith(
                fontSize: 11,
                color: isMe
                    ? Colors.white70
                    : theme.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
