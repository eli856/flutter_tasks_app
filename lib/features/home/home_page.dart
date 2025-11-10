import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tasks_app/features/home/dashboard_bottom_nav.dart';
import 'package:flutter_tasks_app/features/home/main_action_section.dart';
import 'package:flutter_tasks_app/features/home/quick_overview_section.dart';
import 'package:flutter_tasks_app/features/home/recent_activity_section.dart';
import 'package:flutter_tasks_app/features/notes/notes_page.dart';

class HomePage extends StatelessWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final email = user.email ?? user.uid;
    const primaryBlue = Color(0xFF3164F4);
    const purple = Color(0xFF9B51E0);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: false,
        title: const Row(
          children: [
            Icon(Icons.description_outlined, size: 22),
            SizedBox(width: 8),
            Text('Dashboard', style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        actions: const [
          SizedBox(width: 12),
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage('assets/images/avatar.png'),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, $email !',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Choose what you would like to do',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),

            SingleChildScrollView(
              // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MainActionsSection(),
                  const SizedBox(height: 24),
                  const QuickOverviewSection(),
                  const SizedBox(height: 24),
                  const RecentActivitySection(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const DashboardBottomNav(),
    );
  }
}
