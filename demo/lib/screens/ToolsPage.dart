import 'package:demo/helper/ToolProvider.dart';
import 'package:demo/screens/AdminToolPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToolsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tools List"),
      ),
      body: buildToolsList(context),
    );
  }

  Widget buildToolsList(BuildContext context) {
    var toolsProvider = Provider.of<ToolProvider>(context, listen: false);

    return ListView.builder(
      itemCount: toolsProvider.tools.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(toolsProvider.tools[index].name),
          subtitle: Text(toolsProvider.tools[index].url),
          onTap: () {
            // Open the URL when the list tile is tapped
            launchUrl(toolsProvider.tools[index].url);
          },
          onLongPress: () async {
            // Navigate to the AdminToolsPage for CRUD operations and await the result
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AdminToolsPage(index: index),
              ),
            );

            // Show a snackbar with the result
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result ?? 'Operation cancelled'),
              ),
            );
          },
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