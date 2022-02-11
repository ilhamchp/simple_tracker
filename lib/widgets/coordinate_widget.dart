import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  GoogleMapController _mapController;
  final Map<String, Marker> _markers = {};
  Position position;
  Timer timer;
  @override
  Widget build(BuildContext context) {
    var coordProvider = Provider.of<CoordinateProviders>(context);
    var timerProvider = Provider.of<TimerProvider>(context);
    position = coordProvider.coordinate;
    timer = timerProvider.timer;
    if (position.longitude != null || position.latitude != null) {
      _showMarker();
    }
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 400,
            child: GoogleMap(
              myLocationButtonEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(position.latitude ?? -6.914744, position.longitude ?? 107.609810),
                zoom: 12
              ),
              markers: _markers.values.toSet(),
            ),
          ),
          Text("Latitude: ${position.latitude ?? "Unknown"}", style: TextStyle(fontSize: 14),),
          Text("Longitude: ${position.longitude ?? "Unknown"}", style: TextStyle(fontSize: 14),),
          Text("Accuracy: ${position.accuracy ?? "Unknown"} meters", style: TextStyle(fontSize: 14),),
          Text("Service: ${timer != null ? timer.isActive ? "Running" : "Not running" : "Not running"}"),
          SizedBox(height: 10,),
          Container(
            width: 200,
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
            width: 200,
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
            width: 200,
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

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
  }

  void _showMarker() async {
    setState(() async {
      var myLoc = LatLng(position.latitude, position.longitude);
      _mapController.animateCamera(CameraUpdate.newLatLngZoom(myLoc, 12));
      _mapController.animateCamera(CameraUpdate.newLatLngZoom(myLoc, 17));
      _markers.clear();
      
      // Marker can more than 1
      final marker = Marker(
        markerId: MarkerId("curloc"),
        position: myLoc,
        infoWindow: InfoWindow(
          title: "Your location is here!",
          snippet: "Hello",
          onTap: (){
            print("Hello you tapped your location!");
          }
        )
      );
      _markers['curloc'] = marker;
    });
  }
}