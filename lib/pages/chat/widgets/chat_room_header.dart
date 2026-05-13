import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ChatRoomHeader extends StatelessWidget {
  final String name;

  const ChatRoomHeader({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenPadding,
        AppSpacing.xxxl,
        AppSpacing.screenPadding,
        AppSpacing.lg,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: theme.card.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: theme.textPrimary,
              ),
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.primary,
            child: Text(
              name[0],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(width: AppSpacing.md),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.title(context),
                ),

                const SizedBox(height: 2),

                Text(
                  "Active now",
                  style: AppTextStyles.caption(context).copyWith(
                    color: Colors.greenAccent,
                  ),
                ),
              ],
            ),
          ),

          Icon(
            Icons.more_vert_rounded,
            color: theme.textSecondary,
          ),
        ],
      ),
    );
  }
}
