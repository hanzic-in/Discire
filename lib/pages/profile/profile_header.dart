import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExNHJueXZueXpueXpueXpueXpueXpueXpueXpueXpueXpueXpueXpueCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/3o7TKMGpxx6tI5mX9S/giphy.gif"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: -50,
              child: CircleAvatar(
                radius: 54,
                backgroundColor: Colors.white,
                child: const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage("https://i.pravatar.cc/300?u=han"),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 60),
        const Text("hanz zyn", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text("Jakarta, Indonesia • he/him", style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }
}
