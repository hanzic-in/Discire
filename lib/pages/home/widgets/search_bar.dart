import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 14),
      decoration: BoxDecoration(
        color: isDark 
          ? const Color(0xFF0F0F15)
          : theme.card,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: isDark
            ? Colors.white.withOpacity(0.08)
            : theme.divider.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search, 
            size: 20, 
            color: isDark 
              ? const Color(0xFF5A6070)
              : theme.textTertiary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            "Search people, interests...",
            style: TextStyle(
              fontSize: 14,
              color: isDark 
                ? const Color(0xFF5A6070)
                : theme.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
