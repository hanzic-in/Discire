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

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF0D0D0D) : const Color(0xFFF5F6FA),
      body: Stack(
        children: [
          _getPage(),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: _buildGlassNav(isDarkMode),
          ),
        ],
      ),
    );
  }

  // --- FUNGSI BUAT BIKIN NAVBAR KACA ---
  Widget _buildGlassNav(bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // Efek Blur Kaca
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: isDark 
                ? Colors.black.withOpacity(0.5) 
                : Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.white.withOpacity(0.2),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_rounded, 0),
              _navItem(Icons.search_rounded, 1),
              _buildAddButton(),
              _navItem(Icons.chat_bubble_rounded, 3),
              _navItem(Icons.person_rounded, 4),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET ICON NAVIGASI ---
  Widget _navItem(IconData icon, int index) {
    bool isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => currentIndex = index),
      child: Icon(
        icon,
        color: isActive ? Colors.blueAccent : Colors.grey.withOpacity(0.8),
        size: 28,
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
