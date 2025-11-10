import 'package:flutter/material.dart';

class QuickOverviewSection extends StatelessWidget {
  const QuickOverviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF3164F4);
    const purple = Color(0xFF9B51E0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Overview',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 12),
        Row(
          children: const [
            Expanded(
              child: OverviewStatCard(
                icon: Icons.sticky_note_2_rounded,
                value: '12',
                labelTop: 'Notes',
                labelBottom: 'Total saved',
                iconColor: primaryBlue,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: OverviewStatCard(
                icon: Icons.view_timeline_outlined,
                value: '8',
                labelTop: 'Tasks',
                labelBottom: 'Pending',
                iconColor: purple,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class OverviewStatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String labelTop;
  final String labelBottom;

  const OverviewStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.labelTop,
    required this.labelBottom,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 14,
            offset: const Offset(0, 6),
            color: Colors.black.withOpacity(0.03),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          Text(
            labelTop,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 2),
          Text(
            labelBottom,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
