import 'package:demo/screens/BottomNavBar.dart';
import 'package:flutter/material.dart';

class GroupPage extends StatelessWidget {
  // Sample data for each person
  final List<Person> people = [
    Person(name: 'Dr. Dinesh Kumar ', designation: 'Principal Scientist', serialNumber: '001', photoAssetPath: 'assets/images/Dr_Dinesh.png'),
    Person(name: 'Dr. Mir Asif Iquebal', designation: 'Senior Scientist', serialNumber: '002', photoAssetPath: 'assets/images/Dr_MA.jpg'),
    Person(name: 'Dr. Sarika', designation: 'Senior Scientist', serialNumber: '002', photoAssetPath: 'assets/images/Dr_Sarika.png'),
    //Person(name: 'Jane Smith', designation: 'Designer', serialNumber: '002', photoAssetPath: 'https://example.com/jane_smith.jpg'),
    //Person(name: 'Jane Smith', designation: 'Designer', serialNumber: '002', photoAssetPath: 'https://example.com/jane_smith.jpg'),
    // Add more people as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Group Members"),
      ),
      body: ListView.builder(
        itemCount: people.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: buildPersonHeader(people[index]),
            children: [
              buildPersonDetails(people[index]),
            ],
          );
        },
      ),
    );
  }

  Widget buildPersonHeader(Person person) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(person.photoAssetPath),
          radius: 25,
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              person.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(person.designation),
          ],
        ),
      ],
    );
  }

  Widget buildPersonDetails(Person person) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name: ${person.name}"),
          Text("Designation: ${person.designation}"),
          Text("Serial Number: ${person.serialNumber}"),
          // Add more details as needed
         // BottomNavBar(),
        ],
      ),
    );
  }
}

class Person {
  final String name;
  final String designation;
  final String serialNumber;
  final String photoAssetPath;

  Person({required this.name, required this.designation, required this.serialNumber, required this.photoAssetPath});
}
