import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/features/notes/presentation/widgets/notes_card.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_tasks_app/features/notes/presentation/widgets/notes_filter_bar.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  int _selectedFilterIndex = 0;

  final List<String> _filters = const [
    'All Notes',
    'Recent',
    'Favorites',
    'Shared',
  ];

  // Temporary mock data – replace with Firestore later
  final List<NotePreview> _notes = const [
    NotePreview(
      title: 'Meeting Notes - Q4 Planning',
      preview:
          'Discussed upcoming product roadmap, budget allocation for next quarter, and team restructuring plans...',
      timeLabel: '2 hours ago',
    ),
    NotePreview(
      title: 'Shopping List',
      preview:
          'Groceries for the week: milk, bread, eggs, chicken, vegetables, fruits, pasta, rice...',
      timeLabel: 'Yesterday',
    ),
    NotePreview(
      title: 'Book Ideas & Quotes',
      preview:
          '"The only way to do great work is to love what you do." - Steve Jobs. Collection of inspiring quotes...',
      timeLabel: '3 days ago',
      isFavorite: true,
    ),
    NotePreview(
      title: 'Travel Itinerary - Japan',
      preview:
          'Day 1: Tokyo arrival, check-in hotel. Day 2: Visit Senso-ji Temple, explore Shibuya...',
      timeLabel: '1 week ago',
      isPinned: true,
    ),
    NotePreview(
      title: 'Workout Routine',
      preview:
          'Monday: Chest & Triceps - Bench press, incline press, dips. Wednesday: Back & Biceps...',
      timeLabel: '2 weeks ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        title: const Text(
          'My Notes',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: implement search
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          NotesFilterBar(
            filters: _filters,
            selectedIndex: _selectedFilterIndex,
            onFilterSelected: (index) {
              setState(() => _selectedFilterIndex = index);
              // TODO: apply filtering later
            },
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: NoteCard(
                    note: note,
                    onTap: () {
                      // TODO: open detail page later
                    },
                    onMenuTap: () {
                      // TODO: show note actions
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: open "create note" screen
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              break;
            case 2:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile coming soon 🙂')),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sticky_note_2_outlined),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
