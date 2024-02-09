import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Us',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          'Welcome to our app! This is a brief description of what our app is all about.',
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 24.0),
        Text(
          'Creator: Kunal',
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(height: 8.0),
        Text(
          'Copyright © 2024. All rights reserved.',
          style: TextStyle(fontSize: 14.0, color: Colors.grey),
        ),
        // Add more content if needed
      ],
    );
  }
}
