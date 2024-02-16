import 'package:flutter/material.dart';

class PublicationPage extends StatefulWidget {
  @override
  _PublicationPageState createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  // Sample data for publications
  final List<Publication> publications = [
    Publication(
      title: 'Article 1',
      shortDescription: 'Short description for Article 1.',
      fullDescription: 'This is the full description for Article 1. It contains more details about the content of the article. You can read the full article by clicking the link below.',
      link: 'https://example.com/article1',
      year: 2022,
    ),
    Publication(
      title: 'Article 2',
      shortDescription: 'Short description for Article 2.',
      fullDescription: 'This is the full description for Article 2. It contains more details about the content of the article. You can read the full article by clicking the link below.',
      link: 'https://example.com/article2',
      year: 2022,
    ),
    // Add more publications as needed
  ];

  int selectedYear = 2022; // Default selected year

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Publications"),
      ),
      body: Column(
        children: [
          buildYearDropdown(),
          Expanded(
            child: buildPublicationsList(),
          ),
        ],
      ),
    );
  }

  Widget buildYearDropdown() {
    List<int> years = List.generate(5, (index) => DateTime.now().year - index);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<int>(
        value: selectedYear,
        onChanged: (int? year) {
          setState(() {
            selectedYear = year!;
          });
        },
        items: years.map((int year) {
          return DropdownMenuItem<int>(
            value: year,
            child: Text(year.toString()),
          );
        }).toList(),
      ),
    );
  }

  Widget buildPublicationsList() {
    List<Publication> filteredPublications =
    publications.where((publication) => publication.year == selectedYear).toList();

    return ListView.builder(
      itemCount: filteredPublications.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Show more details when the item is tapped
            showPublicationDetails(context, filteredPublications[index]);
          },
          child: Card(
            child: ListTile(
              title: Text(filteredPublications[index].title),
              subtitle: Text(filteredPublications[index].shortDescription),
            ),
          ),
        );
      },
    );
  }

  void showPublicationDetails(BuildContext context, Publication publication) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(publication.title),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(publication.fullDescription),
              SizedBox(height: 8),
              InkWell(
                onTap: () {
                  // Open the link when the link is tapped
                  launchUrl(publication.link);
                },
                child: Text(
                  'Read more: ${publication.link}',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
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

  void launchUrl(String url) {
    // Implement the logic to open the URL, for example, using the url_launcher package
    // You need to add url_launcher as a dependency in your pubspec.yaml file.
    // Then, import the package and use launch(url).
  }
}

class Publication {
  final String title;
  final String shortDescription;
  final String fullDescription;
  final String link;
  final int year;

  Publication({
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
    required this.link,
    required this.year,
  });
}

