import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class NearbySection extends StatelessWidget {
  const NearbySection({super.key});

  final List<Map<String, String>> users = const [
    {
      "name": "Aria Chen",
      "role": "UI Designer",
      "img": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1200&auto=format&fit=crop",
    },
    {
      "name": "Ryo Tanaka",
      "role": "Software Engineer",
      "img": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=1200&auto=format&fit=crop",
    },
    {
      "name": "Maya Putri",
      "role": "Content Creator",
      "img": "https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?q=80&w=1200&auto=format&fit=crop",
    },
    {
      "name": "Han",
      "role": "Fullstack Dev",
      "img": "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=1200&auto=format&fit=crop",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md, 0, AppSpacing.md, AppSpacing.sm,
          ),
          child: Text(
            "Discover",
            style: AppTextStyles.heading(context),
          ),
        ),
        SizedBox(
          height: 252,
          child: ListView.builder(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemCount: users.length,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            itemBuilder: (context, index) => _buildUserCard(context, users[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildUserCard(BuildContext context, Map<String, String> user) {
    final theme = AppThemeExtension.of(context);
    
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: AppSpacing.md),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.divider.withOpacity(0.10),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withOpacity(0.40),
            blurRadius: 24,
            spreadRadius: -4,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              user['img']!,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(color: theme.surface);
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(color: theme.surface);
              },
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.0, 0.32, 0.75],
                  colors: [
                    theme.overlay.withOpacity(0.42),
                    theme.overlay.withOpacity(0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: AppSpacing.md,
              left: AppSpacing.md,
              right: AppSpacing.md,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(user['name']!, style: AppTextStyles.titleInverse),
                  const SizedBox(height: 2),
                  Text(
                    user['role']!,
                    style: AppTextStyles.captionInverse.copyWith(
                      color: Colors.white.withOpacity(0.82),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
