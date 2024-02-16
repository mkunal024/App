import 'package:demo/screens/AboutUs.dart';
import 'package:demo/screens/AdminLoginPage.dart';
import 'package:demo/screens/GalleryPage.dart';
import 'package:demo/screens/GroupPage.dart';
import 'package:demo/screens/HomePage.dart';
import 'package:demo/screens/Learning.dart';
import 'package:demo/screens/PatentPage.dart';
import 'package:demo/screens/Publication.dart';
import 'package:demo/screens/ToolsPage.dart';
import 'package:demo/widgets/SliderWidget.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.blue,
        centerTitle:true,
        actions: [Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onLongPress: (){Navigator.push(context,MaterialPageRoute(builder: (context) => AdminLoginPage(),),);},
            child: Image.asset('assets/images/iasri.png',
              width: 100,
              height: 100,
            ),
          ),
        ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.green,
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
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => GroupPage(),),);},
            ),
            ListTile(
              trailing: Icon(Icons.info),
              title: const Text ('About us'),
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs(),),);},

            )
          ],
        ),
      ),

      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Container(
              color: Colors.lightBlueAccent,
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  SliderWidget(),
                  SizedBox(height: 40,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(),),);},
                        child: Container(
                          height:100,
                          width:MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/menu.jfif'),),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.home, color: Colors.white, size: 40),
                              SizedBox(height: 8),
                              Text('Home', style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      GestureDetector(
                        onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => Learning(),),);},
                        child: Container(
                          height:100,
                          width:MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/menu.jfif'),),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.book, color: Colors.white, size: 40),
                              SizedBox(height: 8),
                              Text('Eduaction', style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => GroupPage(),),);},
                        child: Container(
                          height:100,
                          width:MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/menu.jfif'),),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.group, color: Colors.white, size: 40),
                              SizedBox(height: 8),
                              Text('Group', style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      GestureDetector(
                        onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => GalleryPage(),),);},
                        child: Container(
                          height:100,
                          width:MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/menu.jfif'),),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_sharp, color: Colors.white, size: 40),
                              SizedBox(height: 8),
                              Text('Gallery', style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => PublicationPage(),),);},
                        child: Container(
                          height:100,
                          width:MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/menu.jfif'),),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.history_edu, color: Colors.white, size: 40),
                              SizedBox(height: 8),
                              Text('Publication', style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      GestureDetector(
                        onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => ToolsPage(),),);},
                        child: Container(
                          height:100,
                          width:MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/menu.jfif'),),
                          ),
                          child: const  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.settings, color: Colors.white, size: 40),
                              SizedBox(height: 8),
                              Text('Tool', style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => GroupPage(),),);},
                        child: Container(
                          height:100,
                          width:MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/menu.jfif'),),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.data_array, color: Colors.white, size: 40),
                              SizedBox(height: 8),
                              Text('Database',style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
                      GestureDetector(
                        onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => PatentPage(),),);},
                        child: Container(
                          height:100,
                          width:MediaQuery.of(context).size.width * 0.3,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(fit: BoxFit.cover, image: AssetImage('assets/images/menu.jfif'),),
                          ),
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.label_important, color: Colors.white, size: 40),
                              SizedBox(height: 8),
                              Text('Patent',style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),


              ],
              ),
            ),
          )),
    );
  }

}