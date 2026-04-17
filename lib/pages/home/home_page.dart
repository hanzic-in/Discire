import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/search_bar.dart';
import 'widgets/chips.dart';
import 'widgets/nearby_section.dart';
import '../chat/chat_list_page.dart';
import '../../widgets/bottom_nav_clipper.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        height: 65,
        backgroundColor: const Color(0xFFF5F6FA),
        color: Colors.white,
        buttonBackgroundColor: Colors.black,
        animationDuration: const Duration(milliseconds: 300),
        items: const [
          Icon(Icons.home),
          Icon(Icons.search),
          Icon(Icons.add, color: Colors.white),
          Icon(Icons.chat_bubble_outline),
          Icon(Icons.person_outline),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
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
          return const Center(child: Text("Add Page"));
        case 3:
          return const ChatListPage();
        case 4:
          return _profilePage();
        default:
          return _homePage();
      }
    }

}
