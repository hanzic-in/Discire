import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../widgets/main_layout.dart';
import '../../widgets/app_header.dart';
import '../../widgets/app_search_bar.dart';
import '../../widgets/filter_chips.dart';
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
  String searchQuery = '';

  final List<Map<String, dynamic>> groups = [
    {
      'name': 'Late Night Coders',
      'image': 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=600&q=80',
      'members': '2.1k members',
      'online': '12 online',
      'voice': '4 talking',
      'category': 'Coding',
    },
    {
      'name': 'Pixel Society',
      'image': 'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=600&q=80',
      'members': '980 members',
      'online': '18 online',
      'voice': '2 live',
      'category': 'Design',
    },
    {
      'name': 'AI Underground',
      'image': 'https://images.unsplash.com/photo-1677442136019-21780ecad995?w=600&q=80',
      'members': '4.7k members',
      'online': '34 online',
      'voice': '5 talking',
      'category': 'AI',
    },
    {
      'name': 'Night Drive',
      'image': 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=600&q=80',
      'members': '540 members',
      'online': '8 online',
      'voice': 'Listening',
      'category': 'Music',
    },
    {
      'name': 'Chill Lobby',
      'image': 'https://images.unsplash.com/photo-1542751371-adc38448a05e?w=600&q=80',
      'members': '870 members',
      'online': '16 online',
      'voice': '3 talking',
      'category': 'Gaming',
    },
  ];

  List<Map<String, dynamic>> get filteredGroups {
    var result = currentTab == 0 ? groups : groups.where((e) => e['category'] == tabs[currentTab]).toList();
    if (searchQuery.isNotEmpty) {
      result = result.where((e) => e['name'].toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppThemeExtension.of(context);
    final double staticGradientHeight = MediaQuery.sizeOf(context).height * 0.42;

    return MainLayout(
      usePadding: false,
      child: Stack(
        children: [
          // Gradient Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: staticGradientHeight,
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
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // REUSABLE HEADER
                const AppHeader(
                  title: 'Groups',
                  subtitle: 'Find your people',
                ),

                // REUSABLE SEARCH
                AppSearchBar(
                  hint: 'Search groups...',
                  onChanged: (value) => setState(() => searchQuery = value),
                ),

                const SizedBox(height: AppSpacing.xl),

                // REUSABLE TABS
                FilterChips(
                  items: tabs,
                  selectedIndex: currentTab,
                  onSelected: (index) => setState(() => currentTab = index),
                ),

                const SizedBox(height: AppSpacing.xl),

                // GRID
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenPadding, 
                      0,
                      AppSpacing.screenPadding, 
                      140,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredGroups.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppSpacing.lg,
                      mainAxisSpacing: AppSpacing.lg,
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
