import 'package:flutter/material.dart';

class VoiceSection extends StatelessWidget {
  const VoiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Live Now 🔥",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 110,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _roomCard(context, "Make Friends", 3, isDark),
              _roomCard(context, "Ngobrol Santai", 5, isDark),
              _roomCard(context, "Cari Relasi", 2, isDark),
            ],
          ),
        ),
      ],
    );
  }

  Widget _roomCard(BuildContext context, String title, int count, bool isDark) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(left: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("🎤 $title",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text("$count orang",
              style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const Spacer(),
          const Text(
            "Join",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
