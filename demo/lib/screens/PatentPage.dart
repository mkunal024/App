import 'package:flutter/material.dart';

class PatentPage extends StatelessWidget {
  // Sample data for patents
  final List<Patent> patents = [
    Patent(name: 'Patent 1', link: 'https://example.com/patent1'),
    Patent(name: 'Patent 2', link: 'https://example.com/patent2'),
    // Add more patents as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patents"),
      ),
      body: buildPatentsList(),
    );
  }

  Widget buildPatentsList() {
    return ListView.builder(
      itemCount: patents.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(patents[index].name),
            subtitle: Text("Click to view details"),
            onTap: () {
              // Show patent details on tap
              showPatentDetails(context, patents[index]);
            },
          ),
        );
      },
    );
  }

  void showPatentDetails(BuildContext context, Patent patent) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(patent.name),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Patent link: ${patent.link}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class Patent {
  final String name;
  final String link;

  Patent({
    required this.name,
    required this.link,
  });
}
