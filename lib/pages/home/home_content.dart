import 'flutter:material.dart';

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
