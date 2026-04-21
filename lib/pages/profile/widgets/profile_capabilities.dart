import 'package:flutter/material.dart';

class ProfileCapabilities extends StatelessWidget {
  const ProfileCapabilities({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "ARSENAL",
                    style: TextStyle(
                      fontSize: 11, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.grey,
                      letterSpacing: 1.1
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      _buildSkillTag("Flutter"),
                      _buildSkillTag("Firebase"),
                      _buildSkillTag("UI Design"),
                      _buildSkillTag("Figma"),
                    ],
                  ),
                ],
              ),
            ),

            const VerticalDivider(
              color: Color(0xFFEEEEEE),
              thickness: 1.5,
              width: 30,
            ),

            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "ROLE",
                    style: TextStyle(
                      fontSize: 11, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.grey,
                      letterSpacing: 1.1
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Founder",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 14),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Product Creator",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black87),
      ),
    );
  }
}
