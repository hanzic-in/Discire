import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // 1. BANNER GIF
            Container(
              height: 180,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFE0E0E0),
                image: DecorationImage(
                  image: NetworkImage("https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExNHJueXZueXpueXpueXpueXpueXpueXpueXpueXpueXpueXpueXpueCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3o7TKMGpxx6tI5mX9S/giphy.gif"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // 2. Photo Profile
            Positioned(
              bottom: -45,
              left: 25,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: CircleAvatar(
                  radius: 45,
                  backgroundColor: const Color(0xFFF1F3F5),
                  backgroundImage: const NetworkImage("https://i.pravatar.cc/300?u=han"),
                  onBackgroundImageError: (_, __) {},
                  child: const Icon(Icons.person, size: 40, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      
        const SizedBox(height: 55), 
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // NAMA LENGKAP
              const Text(
                "Hanzic",
                style: TextStyle(
                  fontSize: 26, 
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              // USERNAME & PRONOUNS
              Text(
                "@hanzz_dev • he/him",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              // LOCATION
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text("Jakarta, Indonesia", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                ],
              ),

              const SizedBox(height: 12),

              // --- FOLLOWER & FOLLOWING SECTION ---
              Row(
                children: [
                  _buildMiniStat("1.2k", "Pengikut"),
                  const SizedBox(width: 20),
                  _buildMiniStat("850", "Mengikuti"),
                ],
              ),
            ],
          ),
        const SizedBox(height: 10),

                      // --- BIO SECTION ---
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             const Text(
              "Building Discire & Nexus. Focus on modular systems and mobile-first experience. Let's vibing with music and code! If this bio is too long, it will be cut off so the profile stays clean and professional for everyone to see. ⚡",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
               style: TextStyle(
                 fontSize: 14,
                 height: 1.5,
                 color: Color(0xFF2D3436),
               ),
             ),
            GestureDetector(
               onTap: () {
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 4),
                child: Text(
                  "selengkapnya",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent)
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

    Widget _buildMiniStat(String count, String label) {
    return Row(
      children: [
        Text(count, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }
}
