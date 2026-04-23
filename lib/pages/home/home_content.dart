import 'package:flutter/material.dart';
import '../../widgets/main_layout.dart';
import 'widgets/header.dart';
import 'widgets/search_bar.dart';
import 'widgets/chips.dart';
import 'widgets/nearby_section.dart';
import 'widgets/post_section.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      usePadding: false, 
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeHeader(),
            const HomeSearchBar(),
            const HomeChips(),
            const NearbySection(),
            const PostSection(),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
