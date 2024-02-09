import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:labmates/services/DatabaseHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Database Example'),
        ),
        body: FutureBuilder<Database?>(
          future: DatabaseHelper().initDatabase(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || snapshot.data == null) {
              return Center(child: Text('Error: Database not initialized'));
            } else {
              Database? database = snapshot.data;
              return FutureBuilder<List<Map<String, dynamic>>>(
                future: DatabaseHelper().getUsers(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (userSnapshot.hasError) {
                    return Center(child: Text('Error: ${userSnapshot.error}'));
                  } else {
                    List<Map<String, dynamic>> userList = userSnapshot.data!;
                    return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(userList[index]['name']),
                          subtitle: Text('Age: ${userList[index]['age']}'),
                        );
                      },
                    );
                  }
                },
              );
            }
          },
        )
      ),
    );
  }
}
