// Photo.dart
import 'package:flutter/material.dart';

class Photo {
  final String imagePath;
  String text;
  final DateTime date;

  Photo({
    required this.imagePath,
    required this.text,
    required this.date,
  });
}
