import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/common/widget/app_bottom_nav_bar.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/core/router/app_page_transitions.dart';
import 'package:flutter_techincal_test/features/home/presentation/tabs/home_tab.dart';
import 'package:flutter_techincal_test/features/home/presentation/tabs/profile_tab.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  static const _navItems = <AppBottomNavItem>[
    AppBottomNavItem(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: AppStrings.homeTab,
    ),
    AppBottomNavItem(
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      label: AppStrings.profileTab,
    ),
  ];

  int _currentIndex = 0;

  void _onTabSelected(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_navItems[_currentIndex].label)),
      body: AnimatedSwitcher(
        duration: AppPageTransitions.duration,
        transitionBuilder: (child, animation) =>
            AppPageTransitions.fade(animation, child),
        child: KeyedSubtree(
          key: ValueKey<int>(_currentIndex),
          child: switch (_currentIndex) {
            0 => const HomeTab(),
            1 => const ProfileTab(),
            _ => const HomeTab(),
          },
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        items: _navItems,
      ),
    );
  }
}
