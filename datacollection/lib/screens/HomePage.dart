import 'dart:io';
import 'package:camera/camera.dart';
import 'package:datacollection/models/Folder.dart';
import 'package:datacollection/models/Photo.dart';
import 'package:datacollection/screens/FolderScreen.dart';
import 'package:datacollection/screens/PhotoScreen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';


class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomePage({required this.cameras});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Folder> folders = [];
  TextEditingController folderNameController = TextEditingController();
  TextEditingController folderContentController = TextEditingController();

  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

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

      // Generate a unique file name based on the current date and time
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';

      // Combine the directory path and the file name to create the complete file path
      String imagePath = path.join(tempDirectoryPath, fileName);

      // Move the captured image to the desired location
      File(imageFile.path).copySync(imagePath);
      File(imageFile.path).deleteSync();

      return imagePath;
    } catch (e) {
      print('Error taking photo: $e');
      return '';
    }
  }

  void addPhoto(Folder folder, String text) async {
    String imagePath = await takePhoto();
    if (imagePath.isNotEmpty) {
      setState(() {
        folder.photos.add(Photo(imagePath: imagePath, text: text, date: DateTime.now()));
      });
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

  void addFolder(String folderName, String folderContent) {
    setState(() {
      folders.add(Folder(name: folderName, photos: [], content: folderContent));
    });
  }

  void openFolder(Folder folder) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FolderScreen(folder: folder, cameras: widget.cameras),
      ),
    );
  }

  void showFolderOptions(int index) {
    folderNameController.text = folders[index].name;
    folderContentController.text = folders[index].content;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Folder Options'),
          content: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: folderNameController,
                    decoration: InputDecoration(labelText: 'Folder Name'),
                  ),
                  TextField(
                    controller: folderContentController,
                    decoration: InputDecoration(labelText: 'Content'),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (folderNameController.text.isNotEmpty) {
                              setState(() {
                                folders[index].name = folderNameController.text;
                                folders[index].content = folderContentController.text;
                              });
                              folderNameController.clear();
                              folderContentController.clear();
                              Navigator.pop(context);
                            }
                          },
                          child: Text('Save'),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              folders.removeAt(index);
                            });
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(primary: Colors.red),
                          child: Text('Delete'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  void showCreateFolderDialog() {
    folderNameController.clear();
    folderContentController.clear();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create Folder'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: folderNameController,
                decoration: InputDecoration(labelText: 'Folder Name'),
              ),
              TextField(
                controller: folderContentController,
                decoration: InputDecoration(labelText: 'Folder Content'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (folderNameController.text.isNotEmpty) {
                    addFolder(folderNameController.text, folderContentController.text);
                    folderNameController.clear();
                    folderContentController.clear();
                    Navigator.pop(context);
                  }
                },
                child: Text('Create'),
              ),
            ],
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Folder Management App'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: folders.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.folder),
            title: Text(folders[index].name),
            subtitle: Text(folders[index].content),
            onTap: () => openFolder(folders[index]),
            onLongPress: () => showFolderOptions(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Create Folder'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: folderNameController,
                      decoration: InputDecoration(labelText: 'Folder Name'),
                    ),
                    TextField(
                      controller: folderContentController,
                      decoration: InputDecoration(labelText: 'Folder Content'),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (folderNameController.text.isNotEmpty) {
                          addFolder(folderNameController.text, folderContentController.text);
                          folderNameController.clear();
                          folderContentController.clear();
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Create'),
                    ),
                  ],
                ),
              );
            },
          );
        },

        tooltip: 'Add Folder',
        child: Icon(Icons.add),
      ),
    );
  }
}
