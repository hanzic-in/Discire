import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'post_model.dart';

class TextPost extends StatelessWidget {
  final Post post;
  const TextPost({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.card,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: theme.divider.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withOpacity(0.035),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: AppSpacing.sm),
          if (post.images?.isNotEmpty == true) ...[
            _buildImage(post.images!.first),
            const SizedBox(height: AppSpacing.sm),
          ],
          if (post.content != null) _buildContent(context, post.content!),
          const SizedBox(height: AppSpacing.sm),
          _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = AppThemeExtension.of(context);
    
    return Row(
      children: [
        Container(
          height: 42,
          width: 42,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [AppColors.primaryLight, Color(0xFF78B8FF)],
            ),
          ),
          child: const Icon(Icons.person_rounded, color: Colors.white, size: 20),
        ),
        const SizedBox(width: AppSpacing.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Han", style: AppTextStyles.title(context)),
            Text("2m ago", style: AppTextStyles.caption(context)),
          ],
        ),
        const Spacer(),
        Icon(Icons.more_horiz_rounded, size: 20, color: theme.textTertiary),
      ],
    );
  }

  Widget _buildContent(BuildContext context, String content) {
    return Text(content, style: AppTextStyles.body(context));
  }

  Widget _buildImage(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(url, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      children: [
        _actionItem(context, Icons.favorite_border, "12"),
        const SizedBox(width: AppSpacing.lg),
        _actionItem(context, Icons.chat_bubble_outline, "4"),
        const SizedBox(width: AppSpacing.lg),
        _actionItem(context, Icons.repeat, "2"),
        const SizedBox(width: AppSpacing.lg),
        _actionItem(context, Icons.send, ""),
      ],
    );
  }

  Widget _actionItem(BuildContext context, IconData icon, String count) {
    final theme = AppThemeExtension.of(context);
    
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          children: [
            Icon(icon, size: 20, color: theme.textSecondary),
            if (count.isNotEmpty) ...[
              const SizedBox(width: AppSpacing.xs),
              Text(count, style: AppTextStyles.caption(context)),
            ],
          ],
        ),
      ),
    );
  }
}
