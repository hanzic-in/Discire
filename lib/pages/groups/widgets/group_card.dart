import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class GroupCard extends StatelessWidget {
  final Map<String, dynamic> group;
  final VoidCallback? onTap;

  const GroupCard({
    super.key,
    required this.group,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.card,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: theme.divider.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: theme.shadow.withOpacity(0.1),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // IMAGE
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        group['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    // CATEGORY BADGE
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: theme.overlay.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                        ),
                        child: Text(
                          group['category'],
                          style: AppTextStyles.captionInverse,
                        ),
                      ),
                    ),
                    // IMAGE OVERLAY
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              theme.overlay.withOpacity(0.15),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // INFO
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.title(context),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${group['members']} • ${group['online']}',
                      style: AppTextStyles.caption(context),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: theme.surface,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.graphic_eq_rounded,
                            size: 16,
                            color: theme.textSecondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            group['voice'],
                            style: AppTextStyles.caption(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
