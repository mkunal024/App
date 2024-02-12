import 'package:flutter/material.dart';
import 'package:lab/models/CurrentProject.dart';
import 'package:lab/services/ProjectService.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final ProjectService projectService = ProjectService();
  late Future<List<CurrentProject>> projectList;

  @override
  void initState() {
    super.initState();
    projectList = projectService.getProjectList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Page'),
      ),
      body: FutureBuilder<List<CurrentProject>>(
        future: projectList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<CurrentProject>? projectList = snapshot.data;

            // Save staff data to a file
            saveProjectDataToFile(projectList);

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Title')),
                      DataColumn(label: Text('Description')),
                    ],
                    rows: projectList!.map((staff) {
                      return DataRow(
                        cells: [
                          DataCell(Text(staff.id.toString())),
                          DataCell(Text(staff.title)),
                          DataCell(Text(staff.description)),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> saveProjectDataToFile(List<CurrentProject>? projectList) async {
    await projectService.saveProjectDataToFile(projectList);
  }
}
