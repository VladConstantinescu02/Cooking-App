import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/navigation/navigation_items.dart';

class Navigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const Navigation({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: navigationShell.currentIndex < navigationItems.length
          ? navigationShell.currentIndex
          : 0,
      onTap: _onItemTapped,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      items: navigationItems.map((item) {
        return BottomNavigationBarItem(
          icon: Icon(item.icon),
          label: item.label,
        );
      }).toList(),
    );
  }

  void _onItemTapped(int index) {
    navigationShell.goBranch(index);
  }
}