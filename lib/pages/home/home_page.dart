import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/search_bar.dart';
import 'widgets/chips.dart';
import 'widgets/nearby_section.dart';
import '../chat/chat_list_page.dart';
import '../../widgets/bottom_nav_clipper.dart';

class HomePage extends StatefulWidget {  
  const HomePage({super.key});  
  
  @override  
  State<HomePage> createState() => _HomePageState();  
}  
  class _HomePageState extends State<HomePage> {
    
      int currentIndex = 0;

    
  @override
  Widget build(BuildContext context) {  
    return Scaffold(  
      backgroundColor: const Color(0xFFF5F6FA),  
      bottomNavigationBar: _bottomNav(),

      body: SafeArea(
        child: _getPage(),
      ),
    );  
  }  
  
  
  
  Widget _homePage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          HomeHeader(),
          HomeSearchBar(),
          HomeChips(),
          NearbySection(),
          SizedBox(height: 100),
        ],
      ),
    );
  }
    
    Widget _searchPage() {
      return const Center(child: Text("Search Page"));
    }
    
    Widget _profilePage() {
      return const Center(child: Text("Profile Page"));
    }
    
  Widget _getPage() {
  switch (currentIndex) {
    case 0:
      return _homePage();
    case 1:
      return _searchPage();
    case 2:
    return const ChatListPage();
    case 3:
      return _profilePage();
    default:
      return _homePage();
  }
}
  
  Widget _bottomNav() {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      ClipPath(
        clipper: BottomNavClipper(),
        child: Container(
          height: 80,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => setState(() => currentIndex = 0),
                icon: Icon(Icons.home),
              ),
              IconButton(
                onPressed: () => setState(() => currentIndex = 1),
                icon: Icon(Icons.search),
              ),
              const SizedBox(width: 40),
              IconButton(
                onPressed: () => setState(() => currentIndex = 2),
                icon: Icon(Icons.chat),
              ),
              IconButton(
                onPressed: () => setState(() => currentIndex = 3),
                icon: Icon(Icons.person),
              ),
            ],
          ),
        ),
      ),

      Positioned(
        bottom: 30,
        child: Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.compare_arrows, color: Colors.white),
        ),
      )
    ],
  );
}
}
