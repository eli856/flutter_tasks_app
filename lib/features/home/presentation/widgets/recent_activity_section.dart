import 'package:flutter/material.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Recent Activity',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 12),
        ActivityTile(
          icon: Icons.note_add_outlined,
          iconBg: Color(0xFFE8F0FF),
          title: 'Created new note',
          subtitle: '2 hours ago',
        ),
        SizedBox(height: 8),
        ActivityTile(
          icon: Icons.check_circle_outline,
          iconBg: Color(0xFFE6F9EC),
          title: 'Completed task',
          subtitle: '5 hours ago',
        ),
        SizedBox(height: 8),
        ActivityTile(
          icon: Icons.add_task_outlined,
          iconBg: Color(0xFFF3E7FF),
          title: 'Added new task',
          subtitle: '1 day ago',
        ),
      ],
    );
  }
}

class ActivityTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String subtitle;

  const ActivityTile({
    super.key,
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: const Offset(0, 5),
            color: Colors.black.withOpacity(0.03),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
