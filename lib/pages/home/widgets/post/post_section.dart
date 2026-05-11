import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'post_model.dart';
import 'text_post.dart';

class PostSection extends StatelessWidget {
  const PostSection({super.key});

  @override
  Widget build(BuildContext context) {
    final posts = [
      Post(type: PostType.post, content: "Lagi belajar Flutter, pusing tapi seru 😭"),
      Post(type: PostType.post, content: "Ada yang ngerti state management gak sih?"),
      Post(
        type: PostType.post,
        content: "Ini hasil UI yang lagi gw buat, menurut lu gimana?",
        images: ["https://images.unsplash.com/photo-1555066931-4365d14bab8c"],
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md, AppSpacing.lg, AppSpacing.md, AppSpacing.md,
          ),
          child: Text(
            "Latest",
            style: AppTextStyles.heading(context),
          ),
        ),
        ...posts.map((post) => Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: TextPost(post: post),
        )),
        const SizedBox(height: 100),
      ],
    );
  }
}
