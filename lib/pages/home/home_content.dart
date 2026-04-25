import 'package:flutter/material.dart';
import '../../widgets/main_layout.dart';
import 'widgets/header.dart';
import 'widgets/search_bar.dart';
import 'widgets/nearby_section.dart';
import 'widgets/post_section.dart';
import 'widgets/voice_section.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      usePadding: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeader(),
            const HomeSearchBar(),
            const SizedBox(height: 12),

            _buildTabSwitch(),
            const SizedBox(height: 16),

            if (currentTab == 0) ...[
              const NearbySection(),
              const SizedBox(height: 16),
              const PostSection(),
            ] else ...[
              const VoiceSection(),
            ],

            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSwitch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _tabItem("For You", 0),
          const SizedBox(width: 20),
          _tabItem("Voice", 1),
        ],
      ),
    );
  }

  Widget _tabItem(String title, int index) {
    final isActive = currentTab == index;

    return GestureDetector(
      onTap: () => setState(() => currentTab = index),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              final isDark = Theme.of(context).brightness == Brightness.dark;
              color: isActive
                ? (isDark ? Colors.white : Colors.black)
                : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 2,
            width: isActive ? 24 : 0,
            color: isDark ? Colors.white : Colors.black,
          ),
        ],
      ),
    );
  }
}
