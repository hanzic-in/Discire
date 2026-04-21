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
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0D0D0D) : const Color(0xFFF0F2F5),
      body: Stack(
        children: [
          _dummyPage(),
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 70,
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_rounded, "Home", 0, isDark),
              _navItem(Icons.search_rounded, "Search", 1, isDark),
              _navItem(Icons.notifications_none_rounded, "Notif", 2, isDark),
              _navItem(Icons.person_outline_rounded, "Profile", 3, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(
      IconData icon, String label, int index, bool isDark) {
    bool isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? (isDark ? Colors.white : Colors.white)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: isActive
                  ? Colors.black
                  : (isDark
                      ? Colors.white.withOpacity(0.6)
                      : Colors.black.withOpacity(0.5)),
            ),
            if (isActive) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  // --- WIDGET TOMBOL ADD (TENGAH) ---
  Widget _buildAddButton() {
    return GestureDetector(
      onTap: () => setState(() => currentIndex = 2),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 24),
      ),
    );
  }


  Widget _getPage() {
    switch (currentIndex) {
      case 0:
        return _homePage();
      case 1: 
        return _searchPage();
      case 2:  
        return const Center(child: Text("Add Page"));
      case 3:
        return const ChatListPage();
      case 4:
        return const ProfilePage();
      default:
        return _homePage();
    }
  }

  Widget _homePage() {
    return MainLayout(
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
            SizedBox(height: 120),
          ],
        ),
      ),
    );
  }

  Widget _searchPage() {
    return const Center(child: Text("Search Page"));
  }
}
