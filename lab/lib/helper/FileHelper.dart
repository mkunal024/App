import 'dart:io';
import 'dart:convert';

class FileHelper {
  static Future<void> writeToFile(String fileName, String data) async {
    final file = File(fileName);
    await file.writeAsString(data);
  }

  static Future<String> readFromFile(String fileName) async {
    try {
      final file = File(fileName);
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      // Handle exceptions, e.g., file not found
      return '';
    }
  }
}
