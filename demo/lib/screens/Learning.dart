import 'package:flutter/material.dart';


class Learning extends StatelessWidget {
  // Sample data for each container
  final List<String> containerData = [
    "This is the content for Container 1. It can be a long text. Scroll down to read more.",
    "Here's some detailed information for Container 2. Scroll down to explore.",
    "Container 3 contains additional details. Scroll to view the complete content.",
    "You can customize the content for more containers.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expandable Containers"),
      ),
      body: ListView.builder(
        itemCount: containerData.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text("Container ${index + 1}"),
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.grey[200],
                child: Text(
                  containerData[index],
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

