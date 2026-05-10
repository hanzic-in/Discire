import 'package:flutter/material.dart';
import 'dart:ui';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final bool isDark;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(bottom: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 70,
                decoration: BoxDecoration(
                  color: isDark
                  ? Colors.white.withOpacity(0.08)
                  : const Color(0xFFF6F8FF).withOpacity(0.72),
                  borderRadius: BorderRadius.circular(26),
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
                  children: [
                    _navItem(Icons.home_rounded, "Home", 0, isDark),
                    _navItem(Icons.forum_rounded, "Forum", 1, isDark),
                    _navItem(Icons.edit_rounded, "Add", 2, isDark),
                    _navItem(Icons.chat_rounded, "Chat", 3, isDark),
                    _navItem(Icons.person_outline_rounded, "Profile", 4, isDark),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
      
  
  Widget _navItem(IconData icon, String label, int index, bool isDark) {
    bool isActive = currentIndex == index;

    return Expanded(
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            if (currentIndex == index) return;
            onTap(index);
          },
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                gradient: isActive ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF9395FF)
                    Color(0xFF6F8CFF),
                  ],
                )
                : null,
                color: isActive ? null : Colors.transparent,
                borderRadius: BorderRadius.circular(25),
                boxShadow: isActive ? [
                  BoxShadow(
                    color: const Color(0xFF7C6CFF).withOpacity(0.10),
                    blurRadius: 18,
                    offset: Offset(0, 6),
                  )
                ]
                : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: isActive ? 23 : 22,
                    color: isActive ? Colors.white : (isDark ? Colors.white.withOpacity(0.68) : const Color(0xFF555B68)),
                  ),

                  AnimatedSize(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    child: isActive
                        ? Row(
                            children: [
                              const SizedBox(width: 6),
                              Text(
                                label,
                                style: const TextStyle(
                                  fontSize: 13,
                                  letterSpacing: -0.1,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                     ),
                   ],
                 ),
               ),
             ),
           ),
         );
       }
}
