import 'dart:async';
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
  bool isRecordingVideo = false;
  double zoomLevel = 1.0;
  int timerDuration = 0; // Default: No timer

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(
      widget.cameras[0],
      ResolutionPreset.medium,
      enableAudio: false,
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
      String formattedDate = DateFormat('yyyyMMdd_HHmmss').format(
        DateTime.now(),
      );
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
        builder: (context) =>
            PhotoScreen(imagePath: photo.imagePath, text: photo.text),
      ),
    );
  }

  void addPhotoToFolder() {
    if (isCameraMode) {
      takePhoto().then((imagePath) {
        if (imagePath.isNotEmpty) {
          setState(() {
            widget.folder.photos.add(
              Photo(
                imagePath: imagePath,
                text: '',
                date: DateTime.now(),
              ),
            );
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

  // Function to toggle between camera mode and gallery mode
  void toggleCameraMode() {
    setState(() {
      isCameraMode = !isCameraMode;
    });

    if (isCameraMode) {
      _initializeControllerFuture = _cameraController.initialize();
    }
  }

  // Toggle between photo and video recording modes
  void togglePhotoVideoMode() {
    setState(() {
      isRecordingVideo = !isRecordingVideo;
    });
  }

  // Function to start/stop video recording
  void toggleVideoRecording() {
    if (_cameraController.value.isRecordingVideo) {
      // Stop video recording
      _cameraController.stopVideoRecording().then((_) {
        // Handle the end of video recording
      });
    } else {
      // Start video recording
      _cameraController.startVideoRecording().then((_) {
        // Handle the start of video recording
      });
    }
  }

  // Function to switch between the front and rear camera
  void toggleCameraDirection() async {
    final lensDirection = _cameraController.description.lensDirection;
    CameraDescription newCamera;

    if (lensDirection == CameraLensDirection.front) {
      newCamera = widget.cameras.firstWhere((camera) =>
      camera.lensDirection == CameraLensDirection.back);
    } else {
      newCamera = widget.cameras.firstWhere((camera) =>
      camera.lensDirection == CameraLensDirection.front);
    }

    if (newCamera != null) {
      await _cameraController.dispose();
      _cameraController =
          CameraController(newCamera, ResolutionPreset.medium);
      _initializeControllerFuture = _cameraController.initialize();
      setState(() {});
    }
  }

  // Function to toggle flash mode
  void toggleFlash() async {
    final FlashMode currentFlashMode = _cameraController.value.flashMode;
    final FlashMode newFlashMode = currentFlashMode == FlashMode.off
        ? FlashMode.auto
        : FlashMode.off;
    await _cameraController.setFlashMode(newFlashMode);
    setState(() {});
  }

  // Function to zoom in
  void zoomIn() {
    if (zoomLevel < 5.0) {
      setState(() {
        zoomLevel += 0.1;
        _cameraController.setZoomLevel(zoomLevel);
      });
    }
  }

  // Function to zoom out
  void zoomOut() {
    if (zoomLevel > 1.0) {
      setState(() {
        zoomLevel -= 0.1;
        _cameraController.setZoomLevel(zoomLevel);
      });
    }
  }

  // Function to set a timer for capturing photo
  void setTimer(int duration) {
    setState(() {
      timerDuration = duration;
    });

    if (duration > 0) {
      Timer(Duration(seconds: duration), () {
        // Take a photo after the specified duration
        takePhoto().then((imagePath) {
          if (imagePath.isNotEmpty) {
            setState(() {
              widget.folder.photos.add(
                Photo(
                  imagePath: imagePath,
                  text: '',
                  date: DateTime.now(),
                ),
              );
            });
            // Exit camera mode and return to gallery mode
            toggleCameraMode();
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.folder.name),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            onPressed: toggleCameraDirection,
            icon: Icon(Icons.flip_camera_android),
          ),
          IconButton(
            onPressed: toggleFlash,
            icon: Icon(
              _cameraController.value.flashMode == FlashMode.off
                  ? Icons.flash_off
                  : Icons.flash_on,
            ),
          ),
          IconButton(
            onPressed: () => setTimer(3), // 3 seconds timer
            icon: Text('3s'),
          ),
          IconButton(
            onPressed: () => setTimer(5), // 5 seconds timer
            icon: Text('5s'),
          ),
          IconButton(
            onPressed: () => setTimer(10), // 10 seconds timer
            icon: Text('10s'),
          ),
          IconButton(
            onPressed: togglePhotoVideoMode,
            icon: Icon(
              isRecordingVideo ? Icons.photo_camera : Icons.videocam,
            ),
          ),
        ],
      ),
      body: isCameraMode
          ? Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Align(
            alignment: Alignment.center,
            child: CountdownWidget(timerDuration),
          ),
          Positioned(
            left: 16.0,
            bottom: 100.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: zoomIn,
                  icon: Icon(Icons.zoom_in),
                ),
                IconButton(
                  onPressed: zoomOut,
                  icon: Icon(Icons.zoom_out),
                ),
              ],
            ),
          ),
        ],
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
              child: Image.file(
                File(widget.folder.photos[index].imagePath),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isRecordingVideo) {
            toggleVideoRecording();
          } else {
            addPhotoToFolder();
          }
        },
        tooltip: isCameraMode
            ? 'Capture'
            : isRecordingVideo
            ? 'Stop Recording'
            : 'Take Photo',
        child: Icon(
          isCameraMode
              ? Icons.camera
              : isRecordingVideo
              ? Icons.videocam
              : Icons.camera_alt,
        ),
      ),
      bottomNavigationBar: isCameraMode
          ? BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: togglePhotoVideoMode,
              icon: Icon(
                isRecordingVideo
                    ? Icons.photo_camera
                    : Icons.videocam,
              ),
            ),
            IconButton(
              onPressed: toggleCameraDirection,
              icon: Icon(
                Icons.flip_camera_android,
              ),
            ),
            IconButton(
              onPressed: toggleFlash,
              icon: Icon(
                _cameraController.value.flashMode == FlashMode.off
                    ? Icons.flash_off
                    : Icons.flash_on,
              ),
            ),
          ],
        ),
      )
          : null,
    );
  }

  void deletePhoto(Photo photo) {
    setState(() {
      widget.folder.photos.remove(photo);
    });
  }
}

class CountdownWidget extends StatefulWidget {
  final int duration;

  CountdownWidget(this.duration);

  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late Timer _timer;
  int _currentCountdown = 0;

  @override
  void initState() {
    super.initState();
    _currentCountdown = widget.duration;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_currentCountdown > 0) {
        setState(() {
          _currentCountdown--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_currentCountdown',
      style: TextStyle(fontSize: 48.0, color: Colors.white),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
