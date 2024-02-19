// main.dart
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'screens/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<CameraDescription> cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
}

class MyApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  MyApp({required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Folder",
      theme: ThemeData (primarySwatch: Colors.blue),
      home: HomePage(cameras: cameras),
      debugShowCheckedModeBanner: false,
    );
  }
}