import 'dart:convert';
import 'package:lab/models/Staff.dart';
import 'package:lab/helper/FileHelper.dart';

class StaffService {
  static const String fileName = 'staff_data.json';

  Future<List<Staff>> getStaffList() async {
    // Fetch staff data from the database or another source
    // For simplicity, we'll use a dummy list here
    return [
      Staff(id: 1, name: 'Kunal', address: 'Baraut', designation: 'Project Associate-1'),
      Staff(id: 2, name: 'Jane Smith', address: '456 Oak St', designation: 'UX Designer'),
      Staff(id: 3, name: 'Bob Johnson', address: '789 Elm St', designation: 'Project Manager'),
    ];
  }

  Future<void> saveStaffDataToFile(List<Staff>? staffList) async {
    if (staffList != null) {
      final jsonData = staffList.map((staff) => staff.toMap()).toList();
      final jsonString = jsonEncode(jsonData);

      await FileHelper.writeToFile(fileName, jsonString);
    }
  }

  Future<List<Staff>> readStaffDataFromFile() async {
    final jsonString = await FileHelper.readFromFile(fileName);

    if (jsonString.isNotEmpty) {
      final jsonData = jsonDecode(jsonString) as List<dynamic>;
      return jsonData.map((data) => Staff.fromMap(data)).toList();
    }

    return [];
  }
}
