import 'package:flutter/material.dart';
import 'post_model.dart';

class TextPost extends StatelessWidget {
  final Post post;

  const TextPost({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 16, color: Colors.white),
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
              const Icon(Icons.more_horiz, size: 20),
            ],
          ),

          const SizedBox(height: 10),

          Text(
            post.content,
            style: const TextStyle(fontSize: 14),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _actionItem(Icons.favorite_border, "12"),
              _actionItem(Icons.chat_bubble_outline, "4"),
              _actionItem(Icons.repeat, "2"),
              _actionItem(Icons.send, ""),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionItem(IconData icon, String count) {
  return Row(
    children: [
      Icon(icon, size: 18, color: Colors.grey),
      if (count.isNotEmpty) ...[
        const SizedBox(width: 4),
        Text(
          count,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    ],
  );
  }
}
