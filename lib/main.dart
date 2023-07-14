import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';



Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(StickyNotesApp());
}

class StickyNotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sticky Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StickyNotesScreen(),
    );
  }
}

class StickyNotesScreen extends StatefulWidget {
  @override
  _StickyNotesScreenState createState() => _StickyNotesScreenState();
}

class _StickyNotesScreenState extends State<StickyNotesScreen> {
  List<String> _notes = [];

  void _addNote() {
    setState(() {
      _notes.add('');
    });
  }

  void _deleteNoteAt(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  void _updateNoteAt(int index, String note) {
    setState(() {
      _notes[index] = note;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Sticky notes'),
        ),
        backgroundColor: Colors.yellow[900],

        

      ),
      backgroundColor: Colors.yellow[200],
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          return StickyNote(
            note: _notes[index],
            onChanged: (note) => _updateNoteAt(index, note),
            onDelete: () => _deleteNoteAt(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow[900],
        child: Icon(Icons.add),
        onPressed: _addNote,
      ),
    );
  }
}

class StickyNote extends StatelessWidget {
  final String note;
  final ValueChanged<String> onChanged;
  final VoidCallback onDelete;

  StickyNote({
    required this.note,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(


              padding: EdgeInsets.all(8.0),
              color: Colors.grey[300],
              child: TextField(

                maxLines: null,
                keyboardType: TextInputType.multiline,
                onChanged: onChanged,
                decoration: InputDecoration.collapsed(
                  hintText: 'Enter your note...',
                ),
                style: TextStyle(fontSize: 20.0),

              ),
            ),
            Container(
              color: Colors.grey[300],
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.delete
                ),
                onPressed: onDelete,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
