import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  // Sample image URLs
  final List<String> imageUrls = [
    'assets/images/menu.jfif',
    'assets/images/slider1.png',
    'assets/images/slider2.jpg',
    'assets/images/slider3.png',
    // Add more image URLs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Gallery"),
      ),
      body: buildGallery(),
    );
  }

  Widget buildGallery() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 images in a row
        crossAxisSpacing: 4.0, // Spacing between columns
        mainAxisSpacing: 4.0, // Spacing between rows
      ),
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Open the image in full view on click
            openImage(context, imageUrls[index]);
          },
          child: Image.network(
            imageUrls[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  void openImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
