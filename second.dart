import 'package:flutter/material.dart';


// In-memory notes
List<Map<String, String>> notes = [];

/// ----------------------
/// FIRST SCREEN
/// ----------------------
class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  void _saveNote() {
    String title = _titleController.text.trim();
    String note = _noteController.text.trim();

    if (title.isEmpty || note.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both Title and Note')),
      );
      return;
    }

    setState(() {
      notes.add({'title': title, 'note': note});
    });

    _titleController.clear();
    _noteController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Note saved!')),
    );
  }

  void _viewNotes() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => const SecondScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(1, 0), end: Offset.zero)
                .animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Note')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _inputField(_titleController, 'Title'),
              const SizedBox(height: 16),
              _inputField(_noteController, 'Note', maxLines: 5),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _animatedButton(
                    text: 'Save Note',
                    color: Colors.indigo,
                    onTap: _saveNote,
                  ),
                  _animatedButton(
                    text: 'View Notes',
                    color: Colors.teal,
                    onTap: _viewNotes,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField(TextEditingController controller, String label,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _animatedButton({
    required String text,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3))
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

/// ----------------------
/// SECOND SCREEN
/// ----------------------
class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Note deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Notes')),
      body: notes.isEmpty
          ? const Center(child: Text('No notes yet 😴'))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 500),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(
                        note['title']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(note['note']!),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteNote(index),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
