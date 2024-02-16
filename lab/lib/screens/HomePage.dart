import 'package:flutter/material.dart';
import 'package:lab/screens/AboutUsPage.dart';
import 'package:lab/screens/HomePageLinks.dart';
import 'package:lab/screens/InformationPage.dart';
import 'package:lab/screens/ProjectPage.dart';
import 'package:lab/screens/StaffPage.dart';
import 'package:lab/widgets/SliderWidget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lab'),
        backgroundColor: Colors.orange,
        centerTitle: true,
       // leading: Container(child: const Text('logo here'),),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              trailing: Icon(Icons.home),
              title: const Text ('Home'),
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),),);}

            ),
            ListTile(
              trailing: Icon(Icons.group),
              title: const Text ('Group'),
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => StaffPage(),),);},
            ),
            ListTile(
              trailing: Icon(Icons.info),
              title: const Text ('About us'),
              onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage(),),);},

            )
          ],
        ),
      ),

      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
            Container(height:MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width * 0.8, child: SliderWidget()),
             // SizedBox(height: 20,),
              Row(
                children: [
                  //SizedBox(width: 20,),
                  Container(height: MediaQuery.of(context).size.height * 0.42, width: MediaQuery.of(context).size.width * 0.4, child: HomePageLinks()),
                  SizedBox(width: 65,),
                 Column(children: [
                   InkWell(
                     onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => ProjectPage(),),);
                     },
                     child: Container(
                       height: MediaQuery.of(context).size.height * 0.2, width: MediaQuery.of(context).size.width * 0.5,
                       decoration: BoxDecoration(
                         //color: Colors.red,
                         border: Border.all(color: Colors.black, width: 2.0),
                       ),
                       child: Image.asset('assets/images/project.png', fit: BoxFit.cover,)
                     ),
                   ),

                   SizedBox(height: 20,),
                   InkWell(
                     onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => StaffPage(),),);
                     },
                     child: Container(
                       height: MediaQuery.of(context).size.height * 0.2, width: MediaQuery.of(context).size.width * 0.5,
                       decoration: BoxDecoration(
                         //color: Colors.red,
                         border: Border.all(color: Colors.black, width: 2.0),
                       ),
                         child: Image.asset('assets/images/staff.png', fit: BoxFit.cover,)
                     ),
                   ),
          ],
                  ),
                ],
              ),
              SizedBox(height: 20,),
             Container(width:320, child:AboutUsPage())
            ],
          ),
        ),
    );
  }
}