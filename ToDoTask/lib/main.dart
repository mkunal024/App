import 'package:flutter/material.dart';
import 'package:todo/screens/notes_screen.dart';
import 'package:todo/screens/note_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Local Database",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NotesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}