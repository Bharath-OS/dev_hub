import 'package:dev_hub/shared/presentation/widgets/custom_app_bar.dart';
import 'package:dev_hub/shared/presentation/widgets/custom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'core/constants/app_colors.dart';
import 'core/constants/app_text_styles.dart';
import 'features/profile/presentation/profile_screen.dart';
import 'features/workspace/presentation/workspace.dart';

class MainClass extends StatefulWidget {
  const MainClass({super.key});

  @override
  State<StatefulWidget> createState() => _MainClassState();
}

class _MainClassState extends State<MainClass> {
  int _currentNavIndex = 0;

  static const List<Widget> _screens = [
    WorkspacePage(),
    _PlaceholderTab(
      icon: Icons.chat_bubble_outline,
      title: 'DMs',
    ),
    _PlaceholderTab(
      icon: Icons.check_circle_outline,
      title: 'Tasks',
    ),
    _PlaceholderTab(
      icon: Icons.call_outlined,
      title: 'Calls',
    ),
    ProfileScreen(),
  ];

  void _onNavTap(int index) {
    setState(() {
      _currentNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(
        onMenuPressed: () {},
        onSearchPressed: () {},
      ),
      body: IndexedStack(
        index: _currentNavIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentNavIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  final IconData icon;
  final String title;

  const _PlaceholderTab({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: AppColors.secondary,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: AppTextStyles.title.copyWith(
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Coming soon',
              style: AppTextStyles.body.copyWith(
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
