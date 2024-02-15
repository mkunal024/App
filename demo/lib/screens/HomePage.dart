import 'package:demo/screens/FirstPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Welcome!!'),
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
        body:Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hello!!",
                style: TextStyle(fontSize: 24, color: Colors.white,
                ),
             ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FirstPage(),),);
                    print('Working');
                    },
                child: Text('Click here to start'),)
              ],
            )
        )
        ),
  );
  }
}