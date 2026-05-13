import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/main_layout.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_search_bar.dart';
import '../../widgets/filter_chips.dart';
import 'chat_room_page.dart';

class ChatListPage extends StatefulWidget {
  const ChatListPage({super.key});

  @override
  State<ChatListPage> createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  int currentTab = 0;

  final List<String> tabs = const [
    'All',
    'Unread',
    'Groups',
  ];

  final List<Map<String, dynamic>> chats = [
    {
      "name": "Aria Chen",
      "message": "That design looks amazing! 😍",
      "time": "09:41",
      "unread": 2,
      "image": "https://i.pravatar.cc/300?img=1",
      "type": "Unread",
    },
    {
      "name": "Ryo Tanaka",
      "message": "Let me know when you're free",
      "time": "Yesterday",
      "unread": 0,
      "image": "https://i.pravatar.cc/300?img=2",
      "type": "All",
    },
    {
      "name": "Late Night Coders",
      "message": "Kevin: Push yang baru udah live",
      "time": "08:12",
      "unread": 12,
      "image": "https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=600&q=80",
      "type": "Groups",
      "isGroup": true,
    },
    {
      "name": "Kai Nakamura",
      "message": "The 3D render is almost done 🎨",
      "time": "Mon",
      "unread": 1,
      "image": "https://i.pravatar.cc/300?img=3",
      "type": "Unread",
    },
  ];

  List<Map<String, dynamic>> get filteredChats {
    if (currentTab == 0) return chats;

    if (currentTab == 1) {
      return chats.where((e) => e['unread'] > 0).toList();
    }

    return chats.where((e) => e['isGroup'] == true).toList();
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
                onSelected: (index) {
                  setState(() => currentTab = index);
                },
                isUnderlined: true,
              ),

              const SizedBox(height: AppSpacing.lg),

              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.screenPadding,
                    0,
                    AppSpacing.screenPadding,
                    120,
                  ),
                  itemCount: filteredChats.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final chat = filteredChats[index];

                    return _ChatTile(
                      name: chat['name'],
                      message: chat['message'],
                      time: chat['time'],
                      unread: chat['unread'],
                      image: chat['image'],
                      isGroup: chat['isGroup'] == true,
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

class _ChatTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final int unread;
  final String image;
  final bool isGroup;
  final VoidCallback onTap;

  const _ChatTile({
    required this.name,
    required this.message,
    required this.time,
    required this.unread,
    required this.image,
    required this.isGroup,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: theme.card.withOpacity(0.82),
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: theme.divider.withOpacity(0.4),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.shadow.withOpacity(0.04),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      image,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    ),
                  ),

                  if (isGroup)
                    Positioned(
                      right: -1,
                      bottom: -1,
                      child: Container(
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.card,
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.groups_rounded,
                          size: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(width: AppSpacing.lg),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.title(context),
                          ),
                        ),

                        const SizedBox(width: AppSpacing.sm),

                        Text(
                          time,
                          style: AppTextStyles.caption(context),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.xs),

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            message,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                AppTextStyles.bodySecondary(context),
                          ),
                        ),

                        if (unread > 0) ...[
                          const SizedBox(width: AppSpacing.md),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius:
                                  BorderRadius.circular(999),
                            ),
                            child: Text(
                              unread > 99
                                  ? '99+'
                                  : unread.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.1,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
