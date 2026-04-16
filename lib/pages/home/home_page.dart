import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/search_bar.dart';
import 'widgets/chips.dart';
import 'widgets/nearby_section.dart';
import '../chat/chat_list_page.dart';

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
    return SafeArea(  
      child: Container(  
        margin: const EdgeInsets.all(16),  
        padding: const EdgeInsets.symmetric(horizontal: 20),  
        height: 70,  
        decoration: BoxDecoration(  
          color: Colors.white,        
          borderRadius: BorderRadius.circular(30),  
          boxShadow: [  
            BoxShadow(  
              color: Colors.black.withOpacity(0.08),  
              blurRadius: 20,  
              offset: const Offset(0, 10),  
            ),  
          ],  
        ),  
        child: Row(  
          mainAxisAlignment: MainAxisAlignment.spaceBetween,  
          children: [  
            IconButton(  
              onPressed: () {  
                setState(() => currentIndex = 0);  
              },  
              icon: Icon(  
                Icons.home,  
                color: currentIndex == 0 ? Colors.black : Colors.grey,  
              ),  
            ),  
            IconButton(  
              onPressed: () {  
                setState(() => currentIndex = 1);  
              },  
              icon: Icon(  
                Icons.search,  
                color: currentIndex == 1 ? Colors.black : Colors.grey,  
              ),  
            ),  
            // tombol tengah  
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  print("Add clicked");
                },
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            ), 
  
            IconButton(  
              onPressed: () {  
                setState(() => currentIndex = 2);  
              },  
              icon: Icon(  
                Icons.chat_bubble_outline,  
                color: currentIndex == 2 ? Colors.black : Colors.grey,  
              ),  
            ),  
            IconButton(  
              onPressed: () {  
                setState(() => currentIndex = 3);  
              },  
              icon: Icon(  
                Icons.person_outline,  
                color: currentIndex == 3 ? Colors.black : Colors.grey,  
              ),  
            ),  
          ],  
        ),  
      ),  
    );  
  }
}
