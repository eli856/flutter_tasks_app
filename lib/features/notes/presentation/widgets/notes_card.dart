import 'package:flutter/material.dart';

class NotePreview {
  final String title;
  final String preview;
  final String timeLabel;
  final bool isFavorite;
  final bool isPinned;

  const NotePreview({
    required this.title,
    required this.preview,
    required this.timeLabel,
    this.isFavorite = false,
    this.isPinned = false,
  });
}

class NoteCard extends StatelessWidget {
  final NotePreview note;
  final VoidCallback? onTap;
  final VoidCallback? onMenuTap;

  const NoteCard({
    super.key,
    required this.note,
    this.onTap,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + menu
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    note.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.more_horiz, size: 20),
                  onPressed: onMenuTap,
                ),
              ],
            ),
            const SizedBox(height: 4),
            // Preview text
            Text(
              note.preview,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),
            // Time + icons
            Row(
              children: [
                Text(
                  note.timeLabel,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
                const Spacer(),
                if (note.isFavorite)
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(Icons.star, size: 18, color: Color(0xFFFFC107)),
                  ),
                if (note.isPinned)
                  const Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: Icon(Icons.push_pin, size: 16, color: Colors.grey),
                  ),
                const Icon(Icons.chat_bubble_outline, size: 16, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
