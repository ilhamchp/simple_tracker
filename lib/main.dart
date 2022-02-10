import 'package:flutter/material.dart';
import 'package:simple_tracker/blocs/coordinate_bloc.dart';
import 'package:simple_tracker/models/coordinate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    CoordinateBloc bloc = CoordinateBloc();
    return Scaffold(
      appBar: AppBar(title: Text("Simple Tracker"),),
      body: StreamBuilder(
        stream: bloc.outputStream,
        initialData: bloc.coordinate,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          Coordinate coord = snapshot.data;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Latitude: ${coord.latitude}", style: TextStyle(fontSize: 14),),
              Text("Longitude: ${coord.longitude}", style: TextStyle(fontSize: 14),),
              Text("Elevation: ${coord.elevation}", style: TextStyle(fontSize: 14),),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(icon: Icon(Icons.add), onPressed: (){
                    bloc.inputSink.add('increase');
                  }),
                  IconButton(icon: Icon(Icons.remove), onPressed: (){
                    bloc.inputSink.add('decrease');
                  })
                ],
              )
            ],
          );
        }
      ),
    );
  }
}