import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Simple Tracker"),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Latitude: 0.0", style: TextStyle(fontSize: 14),),
          Text("Longitude: 0.0", style: TextStyle(fontSize: 14),),
          Text("Elevation: 0.0", style: TextStyle(fontSize: 14),),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: Icon(Icons.add), onPressed: (){}),
              IconButton(icon: Icon(Icons.remove), onPressed: (){})
            ],
          )
        ],
      ),
    );
  }
}