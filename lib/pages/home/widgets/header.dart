import 'package:flutter/material.dart';
import 'animated_greeting.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 60, 16, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Jakarta, Indonesia",
                style: TextStyle(
                  color: Color(0xFF667085),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),

              const SizedBox(height: 6),
              AnimatedGreeting(
                text: "Hi, Han",
                style: const TextStyle(
                  color: Color(0xFF1E1E1E),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),

          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.75),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF6C63FF).withOpacity(0.05),
                  blurRadius: 30,
                  spreadRadius: 1,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.notifications_none_rounded,
              color: Color(0xFF444444),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
