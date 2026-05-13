import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class AppSearchBar extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onChanged;
  final double height;

  const AppSearchBar({
    super.key,
    required this.hint,
    this.onChanged,
    this.height = 52,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: theme.searchBar.withOpacity(0.72),
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(color: theme.searchBarBorder),
        ),
        child: Row(
          children: [
            Icon(Icons.search_rounded, color: theme.textSecondary),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: TextField(
                onChanged: onChanged,
                style: TextStyle(color: theme.textPrimary),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(color: theme.textTertiary),
                  border: InputBorder.none,
                  filled: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
