import 'package:flutter/material.dart';
import 'post_model.dart';

class TextPost extends StatelessWidget {
  final Post post;

  const TextPost({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
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

            if (post.images != null && post.images!.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  post.images!.first,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,              
                ),
              ),
              const SizedBox(height: 10),
            ],

            if (post.content != null && post.content!.isNotEmpty) ...[
              Text(
                post.content!,
                style: const TextStyle(fontSize: 14),
              ),
            ],

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _actionItem(Icons.favorite_border, "12"),
                const SizedBox(width: 20),
                _actionItem(Icons.chat_bubble_outline, "4"),
                const SizedBox(width: 20),
                _actionItem(Icons.repeat, "2"),
                const SizedBox(width: 20),
                _actionItem(Icons.send, ""),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionItem(IconData icon, String count) {
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
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
        ),
      ),
    );
  }
}
