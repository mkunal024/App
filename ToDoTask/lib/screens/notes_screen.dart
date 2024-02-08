import 'package:flutter/material.dart';
import 'package:todo/services/database_helper.dat.dart';
import 'package:todo/model/note_model.dart';
import 'package:todo/screens/note_screen.dart';

import '../widgets/note_widget.dart';

class NotesScreen extends StatefulWidget{
  const NotesScreen({Key? key}):super(key: key);

  @override
  State<NotesScreen> createState()=> _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: const Text('Notes'), centerTitle: true),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NoteScreen()));
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),


      body: FutureBuilder<List<Note>?>(
        future: DatabaseHelper.getAllNotes(),
        builder: (context, AsyncSnapshot<List<Note>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          else if (snapshot.hasData) {
            if (snapshot.data != null) {
              return ListView.builder(itemBuilder: (context, index) =>
                  NoteWidget(
                    note: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              NoteScreen(note: snapshot.data![index],)));
                      setState(() {});
                    },
                    onLongPress: () async {
                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          title: const Text("Sure to delete this note?"),
                          actions: [
                            ElevatedButton(style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.red)),
                              onPressed: () async {
                                await DatabaseHelper.deleteNote(
                                    snapshot.data![index]);
                                Navigator.pop(context);
                                setState(() {});
                              }, child: const Text('Yes'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('NO'),
                            ),
                          ],
                        );
                      });
                    },
                  ),
                itemCount: snapshot.data!.length,
              );
            }
            return const Center(child: Text('No notes yet'),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}