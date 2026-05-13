import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/main_layout.dart';
import '../../widgets/app_search_bar.dart';
import '../../widgets/app_header.dart';
import 'widgets/chat_item.dart';
import 'chat_room_page.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

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

              const SizedBox(height: AppSpacing.xl),

              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    0,
                    0,
                    0,
                    120,
                  ),
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
                            builder: (_) => const ChatRoomPage(
                              name: "Aria Chen",
                            ),
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
          ),
        ],
      ),
    );
  }
}
