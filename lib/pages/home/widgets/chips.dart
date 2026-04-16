import 'package:flutter/material.dart';

class HomeChips extends StatelessWidget {
  const HomeChips({super.key});

  @override
  Widget build(BuildContext context) {
    final items = ["Nearby", "Design", "Coding", "Music"];

    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final isActive = index == 0;

          return Container(
            margin: const EdgeInsets.only(left: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: isActive ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            alignment: Alignment.center,
            child: Text(
              items[index],
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
              ),
            ),
          );
        },
      ),
    );
  }
}