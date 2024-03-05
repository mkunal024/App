import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController folderNameController = TextEditingController();
  TextEditingController blocksController = TextEditingController();
  TextEditingController plotsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Explorer'),
      ),
      body: Center(
        child: Text('Your files and folders go here.'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Show a dialog with a form to create a new folder.
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Create New Folder'),
                content: Column(
                  children: [
                    TextFormField(
                      controller: folderNameController,
                      decoration: InputDecoration(labelText: 'Folder Name'),
                    ),
                    TextFormField(
                      controller: blocksController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Number of Blocks'),
                    ),
                    TextFormField(
                      controller: plotsController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Number of Plots'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      // Add logic to create a new folder with blocks and plots.
                      createFolder();
                      Navigator.pop(context);
                    },
                    child: Text('Create'),
                  ),
                  TextButton(
                    onPressed: () {
                      // Cancel the folder creation.
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ],
              );
            },
          );
        },
        tooltip: 'Create New',
        child: Icon(Icons.add),
      ),
    );
  }

  void createFolder() {
    String folderName = folderNameController.text;
    int numBlocks = int.tryParse(blocksController.text) ?? 0;
    int numPlots = int.tryParse(plotsController.text) ?? 0;

    // Add your logic to create the folder structure here.
    print('Creating Folder: $folderName with $numBlocks blocks and $numPlots plots');

    // Add logic to create folders based on the specified structure.
    // This is a simplified example, and you may need to adapt it based on your requirements.
    for (int block = 1; block <= numBlocks; block++) {
      for (int plot = 1; plot <= numPlots; plot++) {
        // Create a folder for each block and plot.
        String blockFolderName = 'Block$block';
        String plotFolderName = 'Plot$plot';

        print('Creating Block Folder: $blockFolderName / $plotFolderName');
      }
    }
  }
}