import 'package:demo/screens/HomePage.dart';
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
          child: Image.asset('assets/images/iasri.png',
            width: 100,
            height: 100,
          ),
        ),
        ],
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
              onTap: () {},
            ),
            ListTile(
              trailing: Icon(Icons.info),
              title: const Text ('About us'),
              onTap: () {},

            )
          ],
        ),
      ),

      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children:[
                SliderWidget(),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Container(
                      height:100,
                      width:MediaQuery.of(context).size.width * 0.3,
                      color:Colors.red,
                    ),
                    SizedBox(width: 20,),
                    Container(
                      height:100,
                      width:MediaQuery.of(context).size.width * 0.3,
                      color:Colors.yellow,
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Container(
                      height:100,
                      width:MediaQuery.of(context).size.width * 0.3,
                      color:Colors.blue,
                    ),
                    SizedBox(width: 20,),
                    Container(
                      height:100,
                      width:MediaQuery.of(context).size.width * 0.3,
                      color:Colors.blue,
                    ),
                  ],
                ),


            ],
            ),
          )),
    );
  }

}