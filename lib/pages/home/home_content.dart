import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/main_layout.dart';
import 'widgets/header.dart';
import 'widgets/search_bar.dart';
import 'widgets/nearby_section.dart';
import 'widgets/post/post_section.dart';

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
      child: CustomScrollView(
        slivers: [
          // SLIVER 1: Header + Search + Gradient (scrollable, hilang ke atas)
          SliverAppBar(
            expandedHeight: 280, // Header + Search + spacing
            floating: false,
            pinned: false, // ← Bukan sticky, ikut scroll!
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
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
                    children: const [
                      HomeHeader(),
                      HomeSearchBar(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // SLIVER 2: Tab Switcher — STICKY!
          SliverPersistentHeader(
            pinned: true, // ← STICKY!
            delegate: _TabSwitcherDelegate(
              child: Container(
                color: theme.background, // Solid background
                child: _buildTabSwitch(),
              ),
            ),
          ),
          
          // SLIVER 3: Nearby + Post (scrollable)
          SliverToBoxAdapter(
            child: Column(
              children: [
                // NEARBY — Di atas gradient yang panjang?
                // Gradient harus lanjut di sini!
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        theme.headerGradient.last, // Warna terakhir gradient
                        theme.background, // Fade ke background
                      ],
                    ),
                  ),
                  child: const NearbySection(),
                ),
                
                // POST — Background solid
                Container(
                  color: theme.background,
                  child: Column(
                    children: [
                      if (currentTab == 0) const PostSection(),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ],
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

class _TabSwitcherDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _TabSwitcherDelegate({required this.child});

  @override
  Widget build(context, shrinkOffset, overlapsContent) => child;
  @override
  double get maxExtent => 50;
  @override
  double get minExtent => 50;
  @override
  bool shouldRebuild(_) => false;
}
