import 'package:flutter/material.dart';
import 'post_model.dart';

class TextPost extends StatelessWidget {
  final Post post;

  const TextPost({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(post.content),
    );
  }
}
