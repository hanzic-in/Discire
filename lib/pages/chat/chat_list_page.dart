import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/main_layout.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_search_bar.dart';
import '../../widgets/filter_chips.dart';
import 'chat_room_page.dart';
import 'widgets/chat_item.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  int currentTab = 0;

  final tabs = const [
    'All',
    'Unread',
    'Groups',
  ];

  final chats = [
    {
      "name": "Aria Chen",
      "message": "That design looks amazing! 😍",
      "time": "09:41",
      "unread": 2,
      "image": "https://i.pravatar.cc/300?img=1",
      "isGroup": false,
    },
    {
      "name": "Ryo Tanaka",
      "message": "Let me know when you're free",
      "time": "Yesterday",
      "unread": 0,
      "image": "https://i.pravatar.cc/300?img=2",
      "isGroup": false,
    },
    {
      "name": "Late Night Coders",
      "message": "Kai: Push ke github sekarang",
      "time": "2m",
      "unread": 12,
      "image": "https://images.unsplash.com/photo-1515879218367-8466d910aaa4?w=300",
      "isGroup": true,
    },
  ];

  List<Map<String, dynamic>> get filteredChats {
    if (currentTab == 1) {
      return chats.where((e) => e['unread'] > 0).toList();
    }

    if (currentTab == 2) {
      return chats.where((e) => e['isGroup'] == true).toList();
    }

    return chats;
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return MainLayout(
      usePadding: false,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.34,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: theme.headerGradient,
                  stops: const [0.0, 0.45, 0.9],
                ),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeader(
                title: 'Messages',
                subtitle: 'Stay connected',
              ),

              const SizedBox(height: AppSpacing.xs),

              AppSearchBar(
                hint: 'Search conversations...',
              ),

              const SizedBox(height: AppSpacing.lg),

              FilterChips(
                items: tabs,
                selectedIndex: currentTab,
                isUnderlined: true,
                onSelected: (index) {
                  setState(() {
                    currentTab = index;
                  });
                },
              ),

              const SizedBox(height: AppSpacing.lg),

              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(
                    bottom: 120,
                  ),
                  itemCount: filteredChats.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (context, index) {
                    final chat = filteredChats[index];

                    return ChatItem(
                      name: chat['name'],
                      message: chat['message'],
                      time: chat['time'],
                      unread: chat['unread'],
                      image: chat['image'],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChatRoomPage(
                              name: chat['name'],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
