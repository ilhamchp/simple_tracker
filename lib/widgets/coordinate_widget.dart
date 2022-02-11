
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_tracker/providers/CoordinateProvider.dart';
import 'package:simple_tracker/providers/timer_provider.dart';

class CoordinateWidget extends StatefulWidget {
  const CoordinateWidget({
    Key key,
  }) : super(key: key);

  @override
  _CoordinateWidgetState createState() => _CoordinateWidgetState();
}

class _CoordinateWidgetState extends State<CoordinateWidget> {
  @override
  Widget build(BuildContext context) {
    var coordProvider = Provider.of<CoordinateProviders>(context);
    var timerProvider = Provider.of<TimerProvider>(context);
    var coordinate = coordProvider.coordinate;
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Latitude: ${coordinate.latitude}", style: TextStyle(fontSize: 14),),
          Text("Longitude: ${coordinate.longitude}", style: TextStyle(fontSize: 14),),
          Text("Altitude: ${coordinate.altitude}", style: TextStyle(fontSize: 14),),
          SizedBox(height: 10,),
          Container(
            width: 300,
            child: RaisedButton(
              onPressed: (){
                coordProvider.fetchLocation();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.location_on),
                  Text("Fetch Location")
                ],
              )
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: 300,
            child: RaisedButton(
              onPressed: (){
                timerProvider.startTimer();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.play_arrow_outlined),
                  Text("Start Service")
                ],
              )
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: 300,
            child: RaisedButton(
              onPressed: (){
                timerProvider.stopTimer();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.stop_outlined),
                  Text("Stop Service")
                ],
              )
            ),
          )
        ],
      ),
    );
  }
}