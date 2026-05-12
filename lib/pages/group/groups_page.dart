import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/main_layout.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final List<String> tabs = [
    'All',
    'Coding',
    'Design',
    'AI',
    'Music',
    'Gaming',
  ];

  int currentTab = 0;

  final List<Map<String, dynamic>> groups = [
    {
      'name': 'Late Night Coders',
      'members': '2.1k members',
      'online': '12 online',
      'voice': '3 talking now',
      'emoji': '💻',
      'category': 'Coding',
    },
    {
      'name': 'Pixel Society',
      'members': '980 members',
      'online': '18 online',
      'voice': '1 live room',
      'emoji': '🎨',
      'category': 'Design',
    },
    {
      'name': 'AI Underground',
      'members': '4.7k members',
      'online': '34 online',
      'voice': '5 talking now',
      'emoji': '🤖',
      'category': 'AI',
    },
    {
      'name': 'Night Drive',
      'members': '540 members',
      'online': '8 online',
      'voice': 'Listening session',
      'emoji': '🎵',
      'category': 'Music',
    },
    {
      'name': 'Indie Builders',
      'members': '1.3k members',
      'online': '21 online',
      'voice': '2 live circles',
      'emoji': '🚀',
      'category': 'Coding',
    },
    {
      'name': 'Chill Lobby',
      'members': '870 members',
      'online': '16 online',
      'voice': '4 talking now',
      'emoji': '🎮',
      'category': 'Gaming',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);

    final filteredGroups = currentTab == 0
        ? groups
        : groups
            .where((e) => e['category'] == tabs[currentTab])
            .toList();

    return MainLayout(
      usePadding: false,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 340,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: theme.headerGradient,
                  stops: const [0.0, 0.38, 0.68],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Groups',
                        style: AppTextStyles.heading(context).copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        'Find your people',
                        style: AppTextStyles.body(context).copyWith(
                          color: theme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 54,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: theme.surface.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search_rounded,
                          color: theme.textSecondary,
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search groups...',
                              hintStyle: TextStyle(
                                color: theme.textTertiary,
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              color: theme.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                SizedBox(
                  height: 42,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: tabs.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final isActive = currentTab == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            currentTab = index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isActive
                                ? theme.textPrimary
                                : Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.06),
                            ),
                          ),
                          child: Text(
                            tabs[index],
                            style: TextStyle(
                              color: isActive
                                  ? theme.background
                                  : theme.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 140),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.82,
                    ),
                    itemCount: filteredGroups.length,
                    itemBuilder: (context, index) {
                      final group = filteredGroups[index];

                      return Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: theme.surface.withOpacity(0.72),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.06),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 54,
                              height: 54,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Text(
                                group['emoji'],
                                style: const TextStyle(fontSize: 26),
                              ),
                            ),

                            const Spacer(),

                            Text(
                              group['name'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  AppTextStyles.title(context).copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              group['members'],
                              style: AppTextStyles.caption(context).copyWith(
                                color: theme.textSecondary,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              group['online'],
                              style: AppTextStyles.caption(context).copyWith(
                                color: theme.textSecondary,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.06),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                group['voice'],
                                style: AppTextStyles.caption(context)
                                    .copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
