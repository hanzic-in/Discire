import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'animated_greeting.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md, 60, AppSpacing.md, AppSpacing.lg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    size: 14,
                    color: theme.textSecondary,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    "Jakarta, Indonesia",
                    style: AppTextStyles.caption(context).copyWith(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: AnimatedGreeting(
                  text: "Hi, Han",
                  style: AppTextStyles.display(context),
                ),
              ),
            ],
          ),
          _buildNotificationButton(theme),
        ],
      ),
    );
  }

  Widget _buildNotificationButton(AppThemeExtension theme) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: theme.card.withOpacity(0.75),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            blurRadius: 30,
            spreadRadius: 1,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Icon(
        Icons.notifications_none_rounded,
        color: theme.textPrimary,
        size: 24,
      ),
    );
  }
}
