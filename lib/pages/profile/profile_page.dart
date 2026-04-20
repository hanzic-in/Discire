import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined, color: Colors.black)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined, color: Colors.black)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER SECTION ---
            Row(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.grey[200],
                  foregroundImage: const NetworkImage("https://i.pravatar.cc/300?u=han"),
                  onForegroundImageError: (_, __) {},
                  child: const Icon(Icons.person, size: 40),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(ProfileData.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 8),
                          Text("he/him", style: TextStyle(color: Colors.grey[500], fontSize: 14)), // PRONOUNS
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(ProfileData.location, style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // FOLLOWERS SECTION
                      Row(
                        children: [
                          _buildFollowStats("1.2k", "Pengikut"),
                          const SizedBox(width: 15),
                          _buildFollowStats("850", "Mengikuti"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // --- STATS SECTION ---
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStat("12", "Kolaborasi"),
                  _buildStat("84", "Impact"),
                  _buildStat("87%", "Trust Score"),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // --- interest ---
            const Text(
              "MINAT", 
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.grey)
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ProfileData.interests.map((interest) => _buildInterestChip(interest)).toList(),
            ),

            const SizedBox(height: 25),
            
            // --- TABBAR SECTION ---
            TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              indicatorWeight: 3,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              tabs: const [
                Tab(text: "Karya"),
                Tab(text: "Post"),
                Tab(text: "Aktivitas"),
              ],
            ),

            const SizedBox(height: 20),

            // --- TAB CONTENT ---
            AnimatedBuilder(
              animation: _tabController,
              builder: (context, child) {
                return _buildTabContent(_tabController.index);
              },
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  // TAB MOVE LOGIC
  Widget _buildTabContent(int index) {
    switch (index) {
      case 0:
        return _buildWorkGrid();
      case 1:
        return const Center(child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Text("Belum ada postingan baru", style: TextStyle(color: Colors.grey)),
        ));
      case 2:
        return _buildActivityList();
      default:
        return const SizedBox();
    }
  }

  // WORK WIDGETS
  Widget _buildWorkGrid() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              _buildWorkItem("https://picsum.photos/200/300", 200),
              _buildWorkItem("https://picsum.photos/200/150", 120),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              _buildWorkItem("https://picsum.photos/201/150", 120),
              _buildWorkItem("https://picsum.photos/201/300", 200),
            ],
          ),
        ),
      ],
    );
  }

  // ACTIVITY WIDGETS
  Widget _buildActivityList() {
    return Column(
      children: [
        _activityTile(Icons.chat_bubble_outline, "Membalas komentar Aria Chen", "1 jam yang lalu"),
        _activityTile(Icons.favorite_border, "Menyukai UI Design System", "3 jam yang lalu"),
      ],
    );
  }

  // --- HELPER WIDGETS ---
  Widget _activityTile(IconData icon, String title, String time) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFF1F3F5),
        child: Icon(icon, size: 18, color: Colors.black),
      ),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      subtitle: Text(time, style: const TextStyle(fontSize: 12)),
    );
  }

  Widget _buildWorkItem(String url, double height) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(url, height: height, width: double.infinity, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildFollowStats(String count, String label) {
    return Row(
      children: [
        Text(count, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
      ],
    );
  }

    Widget _buildInterestChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label, style: const TextStyle(fontSize: 13)),
    );
    }
  

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

class ProfileData {
  static const String name = "hanz zyn";
  static const String location = "Jakarta, Indonesia";
  static const List<String> interests = ["UI/UX Design", "React", "Figma", "Ilustrasi", "Fotografi", "Musik"];
}
