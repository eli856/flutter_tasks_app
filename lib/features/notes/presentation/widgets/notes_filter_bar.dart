import 'package:flutter/material.dart';

class NotesFilterBar extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;
  final ValueChanged<int> onFilterSelected;

  const NotesFilterBar({
    super.key,
    required this.filters,
    required this.selectedIndex,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF3164F4);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(filters.length, (index) {
          final isSelected = index == selectedIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(filters[index]),
              selected: isSelected,
              onSelected: (_) => onFilterSelected(index),
              labelStyle: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black87,
              ),
              selectedColor: primaryBlue,
              backgroundColor: const Color(0xFFE8ECF7),
              pressElevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          );
        }),
      ),
    );
  }
}
