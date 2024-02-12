import 'dart:convert';

import 'package:lab/models/CurrentProject.dart';
import 'package:lab/helper/FileHelper.dart';

class ProjectService {
  static const String fileName = 'Project_data.json';

  Future<List<CurrentProject>> getProjectList() async {
    // Fetch staff data from the database or another source
    // For simplicity, we'll use a dummy list here
    return [
      CurrentProject(id: 1, title: 'DBT', description: 'xyz'),
      CurrentProject(id: 2, title: 'Cabin', description: 'abc'),
      CurrentProject(id: 3, title: 'DST', description: 'pqr'),
    ];
  }

  Future<void> saveProjectDataToFile(List<CurrentProject>? projectList) async {
    if (projectList != null) {
      final jsonData = projectList.map((project) => project.toMap()).toList();
      final jsonString = jsonEncode(jsonData);

      await FileHelper.writeToFile(fileName, jsonString);
    }
  }

  Future<List<CurrentProject>> readProjectDataFromFile() async {
    final jsonString = await FileHelper.readFromFile(fileName);

    if (jsonString.isNotEmpty) {
      final jsonData = jsonDecode(jsonString) as List<dynamic>;
      return jsonData.map((data) => CurrentProject.fromMap(data)).toList();
    }

    return [];
  }
}
