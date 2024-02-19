import 'dart:io';

import 'package:flutter/material.dart';

class PhotoScreen extends StatelessWidget {
  final String imagePath;
  final String text;

  PhotoScreen({required this.imagePath, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image.file(File(imagePath)),
          ),
          SizedBox(height: 16.0),
          Text(
            text,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
