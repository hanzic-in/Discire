import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/main_layout.dart';
import 'widgets/group_card.dart';

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
      'image': 'assets/groups/coding.jpg',
      'members': '2.1k members',
      'online': '12 online',
      'voice': '4 talking now',
      'category': 'Coding',
    },
    {
      'name': 'Pixel Society',
      'image': 'assets/groups/design.jpg',
      'members': '980 members',
      'online': '18 online',
      'voice': '2 live circles',
      'category': 'Design',
    },
    {
      'name': 'AI Underground',
      'image': 'assets/groups/ai.jpg',
      'members': '4.7k members',
      'online': '34 online',
      'voice': '5 talking now',
      'category': 'AI',
    },
    {
      'name': 'Night Drive',
      'image': 'assets/groups/music.jpg',
      'members': '540 members',
      'online': '8 online',
      'voice': 'Listening session',
      'category': 'Music',
    },
    {
      'name': 'Chill Lobby',
      'image': 'assets/groups/gaming.jpg',
      'members': '870 members',
      'online': '16 online',
      'voice': '3 talking now',
      'category': 'Gaming',
    },
  ];

  List<Map<String, dynamic>> get filteredGroups {
    if (currentTab == 0) return groups;
    return groups.where((e) => e['category'] == tabs[currentTab]).toList();
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
            height: screenHeight * 0.42,
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
                // HEADER
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    8,
                    AppSpacing.md,
                    0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Groups',
                        style: AppTextStyles.display(context),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Find your people',
                        style: AppTextStyles.caption(context),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // SEARCH
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  child: Container(
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: theme.searchBar.withOpacity(0.72),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      border: Border.all(
                        color: theme.searchBarBorder,
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
                            style: TextStyle(
                              color: theme.textPrimary,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Search groups...',
                              hintStyle: TextStyle(
                                color: theme.textTertiary,
                              ),
                              border: InputBorder.none,
                              filled: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                // TABS
                SizedBox(
                  height: 42,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: tabs.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemBuilder: (context, index) {
                      final isActive = currentTab == index;

                      return GestureDetector(
                        onTap: () => setState(() => currentTab = index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isActive
                                ? theme.textPrimary
                                : theme.card.withOpacity(0.45),
                            borderRadius: BorderRadius.circular(AppRadius.pill),
                          ),
                          child: Text(
                            tabs[index],
                            style: AppTextStyles.caption(context).copyWith(
                              color: isActive
                                  ? theme.background
                                  : theme.textSecondary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 26),

                // GROUPS GRID
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md, 0,
                      AppSpacing.md, 140,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredGroups.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.82,
                    ),

                    itemBuilder: (context, index) {
                      final group = filteredGroups[index];
                      return GroupCard(
                        group: group,
                        onTap: () {
                         // Navigate to detail
                        },
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
