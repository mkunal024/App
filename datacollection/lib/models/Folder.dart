// Folder.dart

import 'package:flutter/material.dart';
import 'package:datacollection/models/Photo.dart';

class Folder {
  String name;
  List<Photo> photos;
  String content; // Add this line for content property

  Folder({
    required this.name,
    required this.photos,
    required this.content, // Add this line for content property
  });
}
