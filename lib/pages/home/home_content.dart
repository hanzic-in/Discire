import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
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
    final theme = AppThemeExtension.of(context);
    
    return MainLayout(
      usePadding: false,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: theme.headerGradient,
                stops: const [0.0, 0.38, 0.68],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
          ),
          
          Expanded(
            child: Container(
              color: theme.background, // Background solid nutup gradient
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (currentTab == 0) const PostSection(),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabSwitch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, 6),
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
    final theme = AppThemeExtension.of(context);
    
    return GestureDetector(
      onTap: () => setState(() => currentTab = index),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.title(context).copyWith(
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w600,
              color: isActive ? theme.textPrimary : theme.textTertiary,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 2,
            width: isActive ? 24 : 0,
            color: isActive ? theme.textPrimary : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
