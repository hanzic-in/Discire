import 'package:flutter/material.dart';

class PostSection extends StatelessWidget {
  const PostSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 25, 16, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "What's Happening",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("See all", style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ),

        // Card Postingan
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1586717791821-3f44a563dc4c?q=80&w=500",
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.grey[200],
                          child: const Icon(Icons.broken_image, color: Colors.grey, size: 50),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Design",
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),

              // User Info
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  foregroundImage: const NetworkImage("https://i.pravatar.cc/300?u=aria"),
                  onForegroundImageError: (exception, stackTrace) {},
                  child: const Icon(Icons.person, color: Colors.grey),
                ),
                title: const Text("Aria Chen", style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text("2h ago"),
                trailing: const Icon(Icons.more_horiz),
              ),

              // Teks Post
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "New Design System",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Just shipped our new design system for Q2. Clean, scalable, and pixel-perfect.",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}
