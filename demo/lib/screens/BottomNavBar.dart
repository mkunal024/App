import 'package:demo/screens/AboutUs.dart';
import 'package:demo/screens/GalleryPage.dart';
import 'package:demo/screens/HomePage.dart';
import 'package:demo/screens/Learning.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _BottomNavBarState();

}

class _BottomNavBarState extends State<BottomNavBar>
{
  int myIndex=0;
  List<Widget> widgetList = [HomePage(),Learning(),GalleryPage(),AboutUs()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
             setState(() {
               myIndex = index;
             });
             if (myIndex == 0) {
               Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(builder: (context) => HomePage()),
               );
             } else if (myIndex == 1) {
               Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(builder: (context) => AboutUs()),
               );
             }
        },
        currentIndex: myIndex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home', backgroundColor: Colors.blueGrey),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Learning'),
        BottomNavigationBarItem(icon: Icon(Icons.image_sharp), label: 'Images'),
        BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Group')
      ],
      ),
    );
  }

}