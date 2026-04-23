import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/search_bar.dart';
import 'widgets/chips.dart';
import 'widgets/nearby_section.dart';
import '../chat/chat_list_page.dart';
import '../profile/profile_page.dart';
import '../../widgets/main_layout.dart';
import 'widgets/post_section.dart';
import 'dart:ui';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0D0D0D) : const Color(0xFFF0F2F5),
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween(begin: 0.98, end: 1.0).animate(animation),
                  child: child,
                ),
              );
            },
            child: _getPage(),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: _buildNav(isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildNav(bool isDark) {


  Widget _getPage() {
    switch (currentIndex) {
      case 0:
        return Container(
          key: const ValueKey(0),
          child: _homePage(),
        );
      case 1:
        return const Center(key: ValueKey(1), child: Text("SearchPage"));
      case 2:
        return const Center(key: ValueKey(2), child: Text("Add"));
      case 3:
        return const ChatListPage(key: ValueKey(3));
      case 4:
        return Container(
          key: const ValueKey(4),
          child: const ProfilePage(),
        );
      default:
        return Container(
          key: const ValueKey(0),
          child: _homePage(),
        );
    }
  }


  Widget _homePage({Key? key}) {
    return MainLayout(
      key: key,
      usePadding: false, 
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(),
            HomeSearchBar(),
            HomeChips(),
            NearbySection(),
            PostSection(),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _searchPage() {
    return const Center(child: Text("Search Page"));
  }
}
