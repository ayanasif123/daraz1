import 'package:flutter/material.dart';
import 'package:grid/db_helper.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List<Map<String, dynamic>> notes = [];

  void loadNotes() async {
    final data = await DBHelper.getNotes();
    setState(() {
      notes = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("All Notes")),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            title: Text(note['title']),
            subtitle: Text(note['note']),
          );
        },
      ),
    );
  }
}
