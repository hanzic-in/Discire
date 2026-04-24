import 'package:flutter/material.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_stats.dart';
import 'widgets/profile_capabilities.dart';

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

  final TextStyle sectionTitleStyle = const TextStyle(
    fontSize: 12, 
    fontWeight: FontWeight.bold, 
    letterSpacing: 1.2, 
    color: Colors.grey
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined, color: Colors.white)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined, color: Colors.white)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(),
            ProfileStats(),
            ProfileCapabilities(),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("MINAT", style: sectionTitleStyle),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ProfileData.interests.map((interest) => _buildInterestChip(interest)).toList(),
                  ),
                  const SizedBox(height: 25),
                  
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
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0: return _buildWorkGrid();
      case 1: return const Center(child: Padding(padding: EdgeInsets.symmetric(vertical: 40), child: Text("Belum ada postingan baru")));
      case 2: return _buildActivityList();
      default: return const SizedBox();
    }
  }

Widget _buildWorkGrid() {
  return GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: 10,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.75,
    ),
    itemBuilder: (context, index) {
      return _buildWorkItem("https://picsum.photos/200/300?random=$index", 200);
    },
  );
}
  Widget _buildActivityList() {
    return Column(
      children: [
        _activityTile(Icons.chat_bubble_outline, "Membalas komentar Aria Chen", "1 jam yang lalu"),
        _activityTile(Icons.favorite_border, "Menyukai UI Design System", "3 jam yang lalu"),
      ],
    );
  }

  Widget _activityTile(IconData icon, String title, String time) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(backgroundColor: const Color(0xFFF1F3F5), child: Icon(icon, size: 18, color: Colors.black)),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      subtitle: Text(time, style: const TextStyle(fontSize: 12)),
    );
  }

  Widget _buildWorkItem(String url, double height) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(15)),
      child: ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.network(url, height: height, width: double.infinity, fit: BoxFit.cover)),
    );
  }

  Widget _buildInterestChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[200]!), borderRadius: BorderRadius.circular(12)),
      child: Text(label, style: const TextStyle(fontSize: 13)),
    );
  }
}

class ProfileData {
  static const String name = "hanz zyn";
  static const String location = "Jakarta, Indonesia";
  static const List<String> interests = ["UI/UX Design", "React", "Figma", "Ilustrasi", "Fotografi", "Musik"];
}
