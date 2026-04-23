import 'package:flutter/material.dart';
import 'dart:ui';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final bool isDark;
  final Function(int) onTap;

  const
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
              _navItem(Icons.add, "Add", 2, isDark),
              _navItem(Icons.chat_bubble_rounded, "Chat", 3, isDark),
              _navItem(Icons.person_outline_rounded, "Profile", 4, isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(
      IconData icon, String label, int index, bool isDark) {
    bool isActive = currentIndex == index;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            if (currentIndex == index) return;
            setState(() => currentIndex = index);
          },
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(25),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color:
                              Colors.black.withOpacity(0.08),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ]
                    : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
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
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
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
         ),
       );
     }
