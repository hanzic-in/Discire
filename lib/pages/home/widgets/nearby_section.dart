import 'package:flutter/material.dart';

class NearbySection extends StatelessWidget {
  const NearbySection({super.key});

  @override
  Widget build(BuildContext context) {
    
final List<Map<String, String>> users = [
  {
    "name": "Aria Chen",
    "role": "UI Designer",
    "img":
        "https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1200&auto=format&fit=crop",
  },
  {
    "name": "Ryo Tanaka",
    "role": "Software Engineer",
    "img":
        "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=1200&auto=format&fit=crop",
  },
  {
    "name": "Maya Putri",
    "role": "Content Creator",
    "img":
        "https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?q=80&w=1200&auto=format&fit=crop",
  },
  {
    "name": "Han",
    "role": "Fullstack Dev",
    "img":
        "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=1200&auto=format&fit=crop",
  },
];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 10),
          child: Text(
            "Nearby Souls ✨",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        SizedBox(
          height: 252,
          child: ListView.builder(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemCount: users.length,
            padding: const EdgeInsets.only(right: 16),
            itemBuilder: (context, index) {
              final user = users[index];

              return Container(
                width: 160,
                margin: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    ClipRRect(
  borderRadius: BorderRadius.circular(22),
  child: Image.network(
    user['img']!,
    fit: BoxFit.cover,
    height: double.infinity,
    width: double.infinity,

    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;

      return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8F8F8),
              Color(0xFFEDEDED),
            ],
          ),
        ),
      );
    },

    errorBuilder: (context, error, stackTrace) {
      return Image.network(
        "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=1200&auto=format&fit=crop",
        fit: BoxFit.cover,
      );
    },
  ),
),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: const [0.15, 0.8],
                          colors: [
                            Colors.black.withOpacity(0.32),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 14,
                      left: 14,
                      right: 14,
                      child: Column(      
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            user['name']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 2),

                          Text(
                            user['role']!,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.82),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),                         
                          ),
                        ],
                      ),
                    ),
                  ],
                  ),
              );
            },
          ),
        )
      ],
    );
  }
}
