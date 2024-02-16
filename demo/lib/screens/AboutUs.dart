import 'package:demo/screens/BottomNavBar.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "Copyright © 2024 Your Company Name. All Rights Reserved.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "Creator: Kunal",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Add more sections as needed
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
