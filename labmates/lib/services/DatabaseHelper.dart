import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  late Database? _database;

  DatabaseHelper._internal();

  Future<Database?> initDatabase() async {
    try {
      String path = join(await getDatabasesPath(), 'sample_database.db');
      print('Database path: $path');

      _database = await openDatabase(
        path,
        version: 1,
        onCreate: _createDatabase,
      );

      return _database;
    } catch (e) {
      print('Error initializing database: $e');
      return null;
    }
  }

  void _createDatabase(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY,
          name TEXT,
          age INTEGER
        )
      ''');

      await db.insert('users', {'name': 'John Doe', 'age': 25});
      await db.insert('users', {'name': 'Jane Smith', 'age': 30});
      await db.insert('users', {'name': 'Smith', 'age': 31});
    } catch (e) {
      print('Error creating database: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    if (_database == null) {
      print('Error: Database not initialized');
      return [];
    }

    return await _database!.query('users');
  }
}
