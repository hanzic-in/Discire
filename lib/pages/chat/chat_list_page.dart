import 'package:flutter/material.dart';
import 'widgets/chat_item.dart';
import 'chat_room_page.dart';


class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Messages",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        Expanded(
          child: ListView(
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
                      builder: (_) => ChatRoomPage(name: "Aria Chen"),
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
        ),
      ],
    );
  }
}
