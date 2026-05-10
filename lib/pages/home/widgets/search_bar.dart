import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 55,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
  color: Colors.white.withOpacity(0.90),
  borderRadius: BorderRadius.circular(30),
  border: Border.all(
    color: Colors.white.withOpacity(0.35),
    width: 1,
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.045),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ],
),
        child: const Row(
          children: [
            style: TextStyle(
  color: Color(0xFF8A90A2),
  fontWeight: FontWeight.w500,
),
            SizedBox(width: 10),
            Text(
              "Search people, interests...",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
