import 'package:flutter/material.dart';

class NearbySection extends StatelessWidget {
  const NearbySection({super.key});

  @override
  Widget build(BuildContext context) {
    
    final List<Map<String, String>> users = [
      {"name": "Aria Chen", "role": "UI Designer", "dist": "1.2 km", "img": "https://i.pravatar.cc/300?u=aria"},
      {"name": "Ryo Tanaka", "role": "Software Engineer", "dist": "2.4 km", "img": "https://i.pravatar.cc/300?u=ryo"},
      {"name": "Maya Putri", "role": "Content Creator", "dist": "3.1 km", "img": "https://i.pravatar.cc/300?u=maya"},
      {"name": "Han", "role": "Fullstack Dev", "dist": "0.5 km", "img": "https://i.pravatar.cc/300?u=han"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
          child: Text(
            "Nearby Souls ✨",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: users.length,
            padding: const EdgeInsets.only(right: 16),
            itemBuilder: (context, index) {
              final user = users[index];

              return Container(
                width: 160,
                margin: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Stack(
                  children: [
                    // Gambar Utama
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        user['img']!,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.person, color: Colors.grey),
                        ),
                      ),
                    ),

                    // Overlay Gradient
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: const [0.1, 0.5],
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),

                    // Online Indicator
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),

                    // User Info (Name, Role, Location)
                    Positioned(
                      bottom: 12,
                      left: 12,
                      right: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            user['name']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            user['role']!,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.white, size: 10),
                              const SizedBox(width: 4),
                              Text(
                                user['dist']!,
                                style: const TextStyle(color: Colors.white, fontSize: 10),
                              ),
                            ],
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
