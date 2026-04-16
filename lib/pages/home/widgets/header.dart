import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Jakarta, Indonesia",
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
              SizedBox(height: 4),
              Text("Hai, Explorer 👋",
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.notifications_none),
          )
        ],
      ),
    );
  }
}