import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ChatItem extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final int unread;
  final String image;
  final VoidCallback? onTap;

  const ChatItem({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.unread,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Ink(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: unread > 0
                  ? theme.card
                  : theme.card.withOpacity(0.72),
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(
                color: unread > 0
                    ? theme.divider.withOpacity(0.4)
                    : Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 56,
                      width: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.card,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: AppSpacing.md),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.title(
                                context,
                              ),
                            ),
                          ),

                          const SizedBox(width: AppSpacing.sm),

                          Text(
                            time,
                            style: AppTextStyles.caption(
                              context,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.xs),

                      Text(
                        message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySecondary(
                          context,
                        ),
                      ),
                    ],
                  ),
                ),

                if (unread > 0) ...[
                  const SizedBox(width: AppSpacing.md),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(
                        AppRadius.pill,
                      ),
                    ),
                    child: Text(
                      unread.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
