import 'package:flutter/material.dart';
import 'package:lab/models/Staff.dart';
import 'package:lab/services/StaffService.dart';

class StaffPage extends StatefulWidget {
  @override
  _StaffPageState createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  final StaffService staffService = StaffService();
  late Future<List<Staff>> staffList;

  @override
  void initState() {
    super.initState();
    staffList = staffService.getStaffList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Page'),
      ),
      body: FutureBuilder<List<Staff>>(
        future: staffList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Staff>? staffList = snapshot.data;

            // Save staff data to a file
            saveStaffDataToFile(staffList);

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Address')),
                      DataColumn(label: Text('Designation')),
                    ],
                    rows: staffList!.map((staff) {
                      return DataRow(
                        cells: [
                          DataCell(Text(staff.id.toString())),
                          DataCell(Text(staff.name)),
                          DataCell(Text(staff.address)),
                          DataCell(Text(staff.designation)),
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

  Future<void> saveStaffDataToFile(List<Staff>? staffList) async {
    await staffService.saveStaffDataToFile(staffList);
  }
}
