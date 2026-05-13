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
      padding: const EdgeInsets.only(
        top: AppSpacing.xl,
        bottom: AppSpacing.lg,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: theme.card.withOpacity(0.72),
          borderRadius: BorderRadius.circular(
            AppRadius.lg,
          ),
          border: Border.all(
            color: theme.divider.withOpacity(0.18),
          ),
          boxShadow: [
            BoxShadow(
              color: theme.shadow.withOpacity(0.08),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: theme.background.withOpacity(0.55),
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

            Container(
              height: 52,
              width: 52,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryLight,
                    AppColors.primary,
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  name[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
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
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 2),

                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle,
                        ),
                      ),

                      const SizedBox(width: 6),

                      Text(
                        "Active now",
                        style:
                            AppTextStyles.caption(context).copyWith(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () {},
              child: Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: theme.background.withOpacity(0.55),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.more_vert_rounded,
                  color: theme.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
