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
        color: theme.searchBar,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(
          color: theme.searchBarBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
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
