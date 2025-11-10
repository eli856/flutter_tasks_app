import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/features/notes/notes_page.dart';

class MainActionsSection extends StatelessWidget {
  const MainActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF3164F4);
    const purple = Color(0xFF9B51E0);

    return Column(
      children: [
        MainActionCard(
          iconBg: primaryBlue,
          iconColor: Colors.white,
          icon: Icons.sticky_note_2_rounded,
          title: 'My Notes',
          subtitle: 'Access and manage your notes',
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const NotesPage()));
          },
        ),
        const SizedBox(height: 12),
        MainActionCard(
          iconBg: purple,
          iconColor: Colors.white,
          icon: Icons.check_box,
          title: 'My Tasks',
          subtitle: 'View and organize your tasks',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tasks coming soon 🙂')),
            );
          },
        ),
      ],
    );
  }
}

class MainActionCard extends StatelessWidget {
  final Color iconBg;
  final Color iconColor;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const MainActionCard({
    super.key,
    required this.iconBg,
    required this.iconColor,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              blurRadius: 18,
              offset: const Offset(0, 8),
              color: Colors.black.withOpacity(0.04),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: iconColor, size: 26),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 92, 92, 92),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
