import 'package:flutter/material.dart';

class DashboardBottomNav extends StatelessWidget {
  const DashboardBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0, // home selected
      onTap: (index) {
        // TODO: wire up later (Notes, Search, Profile etc.)
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.search),
        //   label: 'Search',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}