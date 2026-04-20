import 'package:flutter/material.dart';

class PostSection extends StatefulWidget {
  const PostSection({super.key});

  @override
  State<PostSection> createState() => _PostSectionState();
}

class _PostSectionState extends State<PostSection> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- HEADER & TAB SWITCHER ---
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 25, 16, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "What's Happening",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  _tabButton("For You", 0),
                  const SizedBox(width: 10),
                  _tabButton("Collab", 1),
                ],
              ),
            ],
          ),
        ),

        // --- KONTEN DINAMIS ---
        selectedTab == 0 ? _buildForYou() : _buildCollab(),

        const SizedBox(height: 100),
      ],
    );
  }

  // Widget Tombol Tab
  Widget _tabButton(String title, int index) {
    bool isActive = selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isActive ? Colors.black : Colors.grey[300]!),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  // --- HALAMAN FOR YOU ---
  Widget _buildForYou() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15, offset: const Offset(0, 5)),
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
                  height: 200, width: double.infinity, fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200, width: double.infinity, color: Colors.grey[200],
                    child: const Icon(Icons.broken_image, color: Colors.grey, size: 50),
                  ),
                ),
              ),
              Positioned(
                top: 12, left: 12,
                child: _buildTag("Design", Colors.blue),
              ),
            ],
          ),
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200],
              foregroundImage: const NetworkImage("https://i.pravatar.cc/300?u=aria"),
              child: const Icon(Icons.person, color: Colors.grey),
            ),
            title: const Text("Aria Chen", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("2h ago"),
            trailing: const Icon(Icons.more_horiz),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Text("Just shipped our new design system for Q2. Clean, scalable, and pixel-perfect."),
          ),
        ],
      ),
    );
  }

  // --- HALAMAN COLLAB (Cari Partner) ---
  Widget _buildCollab() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7FF),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildTag("Project", Colors.orange),
              const Spacer(),
              const Text("Active", style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 15),
          const Text("Looking for Backend Partner", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 10),
          const Text("Lagi build Nexus App, butuh yang jago Firebase & Cloud Functions. Profit sharing ya!"),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Text("send message / Collab", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: color.withOpacity(0.9), borderRadius: BorderRadius.circular(10)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }
}
