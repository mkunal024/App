import 'package:demo/helper/ToolProvider.dart';
import 'package:demo/model/tool.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminToolsPage extends StatelessWidget {
  final int? index;

  AdminToolsPage({this.index});

  @override
  Widget build(BuildContext context) {
    var toolsProvider = Provider.of<ToolProvider>(context);

    TextEditingController nameController =
    TextEditingController(text: index != null ? toolsProvider.tools[index!].name : '');
    TextEditingController urlController =
    TextEditingController(text: index != null ? toolsProvider.tools[index!].url : '');

    return Scaffold(
      appBar: AppBar(
        title: Text(index != null ? "Edit Tool" : "Add Tool"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Tool Name'),
            ),
            TextFormField(
              controller: urlController,
              decoration: InputDecoration(labelText: 'Tool URL'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Add or update a new tool
                if (index != null) {
                  toolsProvider.updateTool(
                    index!,
                    Tool(name: nameController.text, url: urlController.text),
                  );
                  Navigator.pop(context, 'Tool Updated');
                } else {
                  toolsProvider.addTool(
                    Tool(name: nameController.text, url: urlController.text),
                  );
                  Navigator.pop(context, 'Tool Added');
                }
              },
              child: Text(index != null ? 'Update Tool' : 'Add Tool'),
            ),
            if (index != null)
              ElevatedButton(
                onPressed: () {
                  // Delete the tool
                  toolsProvider.deleteTool(index!);
                  Navigator.pop(context, 'Tool Deleted');
                },
                child: Text('Delete Tool'),
              ),
          ],
        ),
      ),
    );
  }
}