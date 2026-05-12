import 'package:flutter/material.dart'; 
import 'dart:ui';  
import '../core/theme/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
  
class CustomBottomNav extends StatelessWidget {  
  final int currentIndex; 
  final Function(int) onTap;
  
  const CustomBottomNav({  
    super.key,  
    required this.currentIndex,  
    required this.onTap,  
  });
    
  @override  
  Widget build(BuildContext context) {  
    final theme = AppThemeExtension.of(context);  
    final isDark = Theme.of(context).brightness == Brightness.dark;      
    return SafeArea(  
      minimum: const EdgeInsets.only(bottom: 5),  
      child: Padding(  
        padding: const EdgeInsets.symmetric(horizontal: 20),  
        child: ClipRRect(  
          borderRadius: BorderRadius.circular(AppRadius.pill),  
          child: BackdropFilter(  
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),  
            child: Container(  
              padding: const EdgeInsets.symmetric(horizontal: 10),  
              height: 70,  
              decoration: BoxDecoration(  
                color: theme.navBackground,  
                borderRadius: BorderRadius.circular(26),  
                border: Border.all(  
                  color: theme.divider.withOpacity(0.3),  
                ),
  
                boxShadow: [  
                  BoxShadow(  
                    color: theme.shadow.withOpacity(0.1),  
                    blurRadius: 20,  
                    offset: const Offset(0, 10),  
                  ),  
                ],  
              ),  
              child: Row(  
                children: [
                  _navItem(FontAwesomeIcons.house, "Home", 0, theme, isDark),
                  _navItem(FontAwesomeIcons.userGroup, "Group", 1, theme, isDark),
                  _navItem(FontAwesomeIcons.plus, "Add", 2, theme, isDark),
                  _navItem(FontAwesomeIcons.solidComment, "Chat", 3, theme, isDark),
                  _navItem(FontAwesomeIcons.user, "Profile", 4, theme, isDark),
                ],
              ),  
            ),  
          ),  
        ),  
      ),  
    );  
  }
  
  Widget _navItem(FaIconData icon, String label, int index, AppThemeExtension theme, bool isDark) {  
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
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),  
            decoration: BoxDecoration(  
              gradient: isActive ? const LinearGradient(  
                begin: Alignment.topLeft,  
                end: Alignment.bottomRight,  
                colors: [AppColors.primaryLight, Color(0xFF6F8CFF)],  
              ) : null,  
              color: isActive ? null : Colors.transparent,  
              borderRadius: BorderRadius.circular(25),  
              boxShadow: isActive ? [  
                BoxShadow(  
                  color: AppColors.primary.withOpacity(0.10),  
                  blurRadius: 18,  
                  offset: const Offset(0, 6),  
                ),
              ] : [],  
            ),  
            child: Row(  
              mainAxisSize: MainAxisSize.min,  
              children: [  
                FaIcon(  
                  icon,  
                  size: isActive ? 23 : 22,  
                  color: isActive ? Colors.white : theme.navInactive,  
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
