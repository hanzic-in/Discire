import 'package:flutter/material.dart';
import 'post_model.dart';
import 'text_post.dart';

class PostSection extends StatelessWidget {
  const PostSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Post> posts = [
      Post(
        type: PostType.post,
        content: "Lagi belajar Flutter, pusing tapi seru 😭",
      ),
      Post(
        type: PostType.post,
        content: "Ada yang ngerti state management gak sih?",
      ),
        Post(
          type: PostType.post,
          content: "Ini hasil UI yang lagi gw buat, menurut lu gimana?",
          images: ["https://images.unsplash.com/photo-1555066931-4365d14bab8c"],
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 25, 16, 15),
          child: Text(
            "What's Happening",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),

        ...posts.map((post) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: _buildPost(post),
        )).toList(),
 
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildPost(Post post) {
    switch (post.type) {
      case PostType.post:
        return TextPost(post: post);

      default:
        return const SizedBox();
    }
  }
}
