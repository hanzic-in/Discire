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
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔥 HEADER
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 18, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Han",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "2m ago",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.more_horiz),
            ],
          ),

          const SizedBox(height: 12),

          // CONTENT
          Text(
            post.content,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
