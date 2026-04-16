import 'package:flutter/material.dart';
import 'widgets/chat_item.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Messages",
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.edit, color: Colors.black),
          )
        ],
      ),
      body: ListView(
        children: [
          ChatItem(
            name: "Aria Chen",
            message: "That design looks amazing! 😍",
            time: "09:41",
            unread: 2,
            image: "https://i.pravatar.cc/300?img=1",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChatRoomPage(name: "Aria Chen"),
                  ),
                  );
            },
            ),
          ChatItem(
            name: "Ryo Tanaka",
            message: "Let me know when you're free",
            time: "Yesterday",
            unread: 0,
            image: "https://i.pravatar.cc/300?img=2",
          ),
          ChatItem(
            name: "Kai Nakamura",
            message: "The 3D render is almost done 🎨",
            time: "Mon",
            unread: 1,
            image: "https://i.pravatar.cc/300?img=3",
          ),
        ],
      ),
    );
  }
}