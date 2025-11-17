import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tasks_app/features/home/presentation/widgets/dashboard_bottom_nav.dart';
import 'package:flutter_tasks_app/features/home/presentation/widgets/main_action_section.dart';
import 'package:flutter_tasks_app/features/home/presentation/widgets/quick_overview_section.dart';
import 'package:flutter_tasks_app/features/home/presentation/widgets/recent_activity_section.dart';

class HomePage extends ConsumerWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = user.email ?? user.uid;

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
            SizedBox(width: 12),
            Text('Dashboard', style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        actions: [
          PopupMenuButton<_UserMenuAction>(
            tooltip: 'Account',
            onSelected: (value) async {
              if (value == _UserMenuAction.logout) {
                await FirebaseAuth.instance.signOut();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: _UserMenuAction.logout,
                child: Text('Logout'),
              ),
            ],
            child: const Padding(
              padding: EdgeInsets.only(right: 16),
              child: CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
            ),
          ),
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

enum _UserMenuAction { logout }
