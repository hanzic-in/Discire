import 'package:flutter/material.dart';
import 'post_model.dart';
import 'dart:async';

class TextPost extends StatelessWidget {
  final Post post;

  const TextPost({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.94),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.black.withOpacity(0.03),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.035),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 42,
                  width: 42,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF8B8DFF),
                        Color(0xFF78B8FF),
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Han",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    Text(
                      "2m ago",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF98A2B3),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.more_horiz_rounded,
                  size: 20,
                  color: Color(0xFF98A2B3),
                ),
              ],
            ),

            const SizedBox(height: 10),

            if (post.images != null && post.images!.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: _buildImage(post.images!.first)
              ),
              const SizedBox(height: 10),
            ],

            if (post.content != null && post.content!.isNotEmpty) ...[
              Text(
                post.content!,
                style: const TextStyle(
                  fontSize: 14.5,
                  height: 1.45,
                  color: Color(0xFF222222),
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.1,),
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
            Icon(
              icon,
              size: 18,
              color: const Color(0xFF7B8190),
            ),
            if (count.isNotEmpty) ...[
              const SizedBox(width: 4),
              Text(
                count,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF7B8190),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String url) {
  return FutureBuilder<ImageInfo>(
    future: _getImageInfo(url),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return Container(
          height: 200,
          color: Colors.grey[200],
        );
      }

      final image = snapshot.data!;
      final ratio = image.image.width / image.image.height;

      double aspectRatio;

      if (ratio > 1) {
        aspectRatio = 4 / 3;
      } else if (ratio < 1) {
        aspectRatio = 3 / 4;
      } else {
        aspectRatio = 1;
      }

      return AspectRatio(
        aspectRatio: aspectRatio,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.network(
            url,
            fit: BoxFit.cover,
          ),
        ),
      );
    },
  );
}

  Future<ImageInfo> _getImageInfo(String url) {
  final completer = Completer<ImageInfo>();
  final image = NetworkImage(url);

  image.resolve(const ImageConfiguration()).addListener(
    ImageStreamListener((info, _) {
      completer.complete(info);
    }),
  );

  return completer.future;
}
}
