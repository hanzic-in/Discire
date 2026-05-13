import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class FilterChips extends StatelessWidget {
  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final bool isUnderlined;

  const FilterChips({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
    this.isUnderlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);

    return SizedBox(
      height: 42,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPadding,
        ),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, __) => SizedBox(width: AppSpacing.sm),
        itemBuilder: (context, index) {
          final isActive = selectedIndex == index;

          return GestureDetector(
            onTap: () => onSelected(index),
            child: isUnderlined
              ? _buildUnderlined(theme, isActive, items[index])
              : _buildPill(theme, isActive, items[index]),
          );
        },
      ),
    );
  }

  Widget _buildUnderlined(BuildContext context, AppThemeExtension theme, bool isActive, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: AppTextStyles.title(context).copyWith(
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
            color: isActive ? theme.textPrimary : theme.textTertiary,
          ),
        ),
        const SizedBox(height: 4),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 2,
          width: isActive ? 24 : 0,
          color: isActive ? theme.textPrimary : Colors.transparent,
        ),
      ],
    );
  }

  Widget _buildPill(BuildContext context, AppThemeExtension theme, bool isActive, String text) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: isActive ? theme.textPrimary : theme.card.withOpacity(0.45),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        text,
        style: AppTextStyles.caption(context).copyWith(
          color: isActive ? theme.background : theme.textSecondary,
        ),
      ),
    );
  }
}
