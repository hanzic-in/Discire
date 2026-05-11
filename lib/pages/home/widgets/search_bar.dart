import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 14),
      decoration: BoxDecoration(
        color: theme.card,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: theme.divider.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: theme.textTertiary, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Text(
            "Search people, interests...",
            style: AppTextStyles.caption(context),
          ),
        ],
      ),
    );
  }
}
