import 'dart:io';
import 'package:camera/camera.dart';
import 'package:datacollection/models/Folder.dart';
import 'package:datacollection/models/Photo.dart';
import 'package:datacollection/screens/PhotoScreen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class FolderScreen extends StatefulWidget {
  final Folder folder;
  final List<CameraDescription> cameras;

  FolderScreen({required this.folder, required this.cameras});

  @override
  _FolderScreenState createState() => _FolderScreenState();
}

class _FolderScreenState extends State<FolderScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;
  bool isCameraMode = false;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
      widget.cameras[0],
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<String> takePhoto() async {
    try {
      await _initializeControllerFuture;

      // Capture the image without specifying a file path
      XFile imageFile = await _cameraController.takePicture();

      // Get the temporary directory path
      String tempDirectoryPath = (await getTemporaryDirectory()).path;

      // Generate a unique file name based on the current timestamp
      String formattedDate = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      String fileName = 'photo_$formattedDate.png';

      // Combine the directory path and the file name to create the complete file path
      String imagePath = '$tempDirectoryPath/$fileName';

      // Move the captured image to the desired location
      File(imageFile.path).copySync(imagePath);

      return imagePath;
    } catch (e) {
      print('Error taking photo: $e');
      return '';
    }
  }

  void openPhoto(Photo photo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoScreen(imagePath: photo.imagePath, text: photo.text),
      ),
    );
  }

  void addPhotoToFolder() {
    if (isCameraMode) {
      takePhoto().then((imagePath) {
        if (imagePath.isNotEmpty) {
          setState(() {
            widget.folder.photos.add(Photo(imagePath: imagePath, text: '', date: DateTime.now()));
          });
          // Exit camera mode and return to gallery mode
          toggleCameraMode();
        }
      });
    } else {
      // Enter camera mode
      toggleCameraMode();
    }
  }

  void deletePhoto(Photo photo) {
    setState(() {
      widget.folder.photos.remove(photo);
    });
  }

  // Function to toggle between camera mode and gallery mode
  void toggleCameraMode() {
    setState(() {
      isCameraMode = !isCameraMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.folder.name),
        backgroundColor: Colors.orange,
      ),
      body: isCameraMode
          ? GestureDetector(
        onTap: () {
          addPhotoToFolder();
        },
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_cameraController);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      )
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: widget.folder.photos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => openPhoto(widget.folder.photos[index]),
            onLongPress: () => deletePhoto(widget.folder.photos[index]),
            child: Card(
              elevation: 2.0,
              child: Image.file(File(widget.folder.photos[index].imagePath), fit: BoxFit.cover),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addPhotoToFolder();
        },
        tooltip: isCameraMode ? 'Capture' : 'Take Photo',
        child: Icon(isCameraMode ? Icons.camera : Icons.camera_alt),
      ),
    );
  }
}
