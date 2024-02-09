import 'package:flutter/material.dart';

class User {
  int id;
  String name;
  int age;
  String? photoPath;

  User({
    required this.id,
    required this.name,
    required this.age,
    this.photoPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'photo_path': photoPath,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      photoPath: map['photo_path'],
    );
  }
}
