import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:simple_tracker/models/coordinate.dart';
import 'package:simple_tracker/providers/CoordinateProvider.dart';
import 'package:simple_tracker/utilities/locator.dart' as MyLocator;
import '../datasources/api_service.dart';

class CoordinateWidget extends StatefulWidget {
  const CoordinateWidget({
    Key key,
  }) : super(key: key);

  @override
  _CoordinateWidgetState createState() => _CoordinateWidgetState();
}

class _CoordinateWidgetState extends State<CoordinateWidget> {
  Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CoordinateProviders>(context);
    var coordinate = provider.coordinate;
    saveCoordinate(coordinate);
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
                provider.fetchLocation();
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
                startTimer();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.play_arrow_outlined),
                  Text("Start Service")
                ],
              )
            ),
          )
        ],
      ),
    );
  }

  void startTimer() async {
    _timer = Timer.periodic(Duration(seconds: 30), (Timer t) async {
      var location = await MyLocator.Locator.determinePosition();
      if (location != null){
        saveCoordinate(location);
      }
    });
  }

  void saveCoordinate(Position data) {
    if (data.latitude == null || data.longitude == null) {
      return;
    }
    var coordinate = Coordinate(
      latitude: data.latitude,
      longitude: data.longitude,
      altitude: data.altitude
    );
    APIService.postSaveCoordinate(coordinate);
  }
}