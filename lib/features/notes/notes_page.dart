import 'package:flutter/material.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // For now, fake notes. We'll replace this with Firestore later.
    final fakeNotes = [
      'Remember to study Flutter',
      'Buy milk',
      'Idea: build task+notes app',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // later: open a NoteEditor or show a dialog to add a note
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add note coming soon')),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: fakeNotes.length,
        itemBuilder: (context, index) {
          final note = fakeNotes[index];
          return ListTile(
            title: Text(note),
            onTap: () {
              // later: open note details / edit page
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Open note: $note')),
              );
            },
          );
        },
      ),
    );
  }
}
