import 'package:demo/model/tool.dart';
import 'package:demo/screens/ToolsPage.dart';
import 'package:flutter/material.dart';

class ToolProvider with ChangeNotifier {
  List<Tool> _tools = [
    Tool(name: 'Flutter', url: 'https://flutter.dev'),
    Tool(name: 'Dart', url: 'https://dart.dev'),
    Tool(name: 'Visual Studio Code', url: 'https://code.visualstudio.com'),
    // Add more tools as needed
  ];

  List<Tool> get tools => _tools;

  void addTool(Tool tool) {
    _tools.add(tool);
    notifyListeners();
  }

  void updateTool(int index, Tool tool) {
    _tools[index] = tool;
    notifyListeners();
  }

  void deleteTool(int index) {
    _tools.removeAt(index);
    notifyListeners();
  }
}
