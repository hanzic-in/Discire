import 'package:flutter/material.dart';
import '../../widgets/main_layout.dart';
import 'widgets/header.dart';
import 'widgets/search_bar.dart';
import 'widgets/nearby_section.dart';
import 'widgets/post/post_section.dart';
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                bottom: 8,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFB7AEFF),
                    Color(0xFFB4DFFF),
                    Color(0xFFF7F8FC),
                  ],
                  stops: [
                    0.0,
                    0.38,
                    0.68,
                  ],
                ),
              ),
              child: Column(
                children: [
                  const HomeHeader(),
                  const HomeSearchBar(),
                  const SizedBox(height: 18),
                  
                  _buildTabSwitch(),
                  const SizedBox(height: 20),
                  const NearbySection(),
                ],
              ),
            ),

            if (currentTab == 0) ...[
              
              const SizedBox(height: 0),
              const PostSection(),
            ],
            const SizedBox(height: 16),

            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSwitch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: () => setState(() => currentTab = index),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
              letterSpacing: -0.2,
              color: isActive ? const Color(0xFF1B1B1F) : const Color(0xFF8A90A2),
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
