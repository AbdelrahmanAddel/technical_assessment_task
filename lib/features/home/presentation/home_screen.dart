import 'package:flutter/material.dart';
import 'package:flutter_techincal_test/core/common/widget/app_bottom_nav_bar.dart';
import 'package:flutter_techincal_test/core/constant/app_strings.dart';
import 'package:flutter_techincal_test/features/home/presentation/tabs/home_tab.dart';
import 'package:flutter_techincal_test/features/home/presentation/tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  Widget _buildCurrentTab() {
    return switch (_currentIndex) {
      0 => const HomeTab(),
      1 => const ProfileTab(),
      _ => const HomeTab(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_navItems[_currentIndex].label)),
      body: _buildCurrentTab(),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabSelected,
        items: _navItems,
      ),
    );
  }
}
