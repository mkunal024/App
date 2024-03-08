import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController folderNameController = TextEditingController();
  TextEditingController blocksController = TextEditingController();
  TextEditingController plotsController = TextEditingController();
  TextEditingController traitController = TextEditingController();
  TextEditingController updatePlotController = TextEditingController();

  String selectedTrait = 'Height';
  List<String> createdFolders = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Explorer'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: createdFolders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(createdFolders[index]),
                  onTap: () {
                    // Navigate to a new page to display folder details.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FolderDetailsPage(folderPath: createdFolders[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          ElevatedButton(
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
                        DropdownButton<String>(
                          value: selectedTrait,
                          onChanged: (String? value) {
                            setState(() {
                              selectedTrait = value!;
                            });
                          },
                          items: <String>['Height', 'Flowering', 'Custom']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
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
            child: Text('Create New Folder'),
          ),
        ],
      ),
    );
  }

  Future<void> createFolder() async {
    String folderName = folderNameController.text;
    int numBlocks = int.tryParse(blocksController.text) ?? 0;
    int numPlots = int.tryParse(plotsController.text) ?? 0;

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;

    String rootFolderPath = '$appDocPath/$folderName';
    await Directory(rootFolderPath).create(recursive: true);

    for (int block = 1; block <= numBlocks; block++) {
      String blockFolderName = 'Block$block';
      String blockFolderPath = '$rootFolderPath/$blockFolderName';
      await Directory(blockFolderPath).create(recursive: true);

      for (int plot = 1; plot <= numPlots; plot++) {
        String plotFolderName = 'Plot$plot';
        String plotFolderPath = '$blockFolderPath/$plotFolderName';
        await Directory(plotFolderPath).create(recursive: true);

        createTabularFile(plotFolderPath, selectedTrait);
        updatePlotNameOrId(plotFolderPath);
      }
    }

    setState(() {
      createdFolders.add(rootFolderPath);
    });

    print('Folders and files created in: $rootFolderPath');
  }

  Future<void> createTabularFile(String folderPath, String trait) async {
    String fileName = 'data.csv';
    String fileContent = 'Plot, $trait\n';
    for (int i = 1; i <= 3; i++) {
      fileContent += 'Plot$i, Value$i\n';
    }

    File file = File('$folderPath/$fileName');
    await file.writeAsString(fileContent);

    print('Creating Tabular File: $folderPath/$fileName');
    print('File Content:\n$fileContent');
  }

  void updatePlotNameOrId(String folderPath) {
    String updatedPlotName = updatePlotController.text;

    print('Updating Plot Name/ID in $folderPath: $updatedPlotName');
  }
}

class FolderDetailsPage extends StatelessWidget {
  final String folderPath;

  const FolderDetailsPage({Key? key, required this.folderPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Folder Details'),
      ),
      body: Center(
        child: Text('Details for folder: $folderPath'),
      ),
    );
  }
}
