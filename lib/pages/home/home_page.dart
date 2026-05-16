import 'package:flutter/material.dart';
import 'home_content.dart';
import '../chat/chat_list_page.dart';
import '../profile/profile_page.dart';
import '../groups/groups_page.dart';
import '../../widgets/custom_bottom_nav.dart';
import '../../core/theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);
    
    return Scaffold(
      backgroundColor: theme.background,
      
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: AnimatedSwitcher(
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

      bottomNavigationBar: CustomBottomNav(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
      ),
    );
  }

  Widget _getPage() {
    switch (currentIndex) {
      case 0: return const HomeContent(key: ValueKey(0));
      case 1: return const GroupsPage(key: ValueKey(1));
      case 2: return const Center(key: ValueKey(2), child: Text("Add"));
      case 3: return const ChatListPage(key: ValueKey(3));
      case 4: return const ProfilePage(key: ValueKey(4));
      default: return const HomeContent(key: ValueKey(0));
    }
  }
}
