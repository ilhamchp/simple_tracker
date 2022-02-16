import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:simple_tracker/models/coordinate.dart';
import 'package:simple_tracker/models/direction.dart';
import 'package:simple_tracker/models/direction_response.dart';
import 'package:simple_tracker/providers/CoordinateProvider.dart';
import 'package:simple_tracker/providers/direction_providers.dart';
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
  final Map<String, Polyline> _polylines = {};
  Position position;
  Timer timer;
  DirectionResponse direction;

  LatLng center = LatLng(-6.839588, 107.353198);

  List<LatLng> locationMap = [];

  Direction dir = Direction();

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  List<LatLng> generateLocationMap(){
    return [
      LatLng(-6.840236, 107.349322),
      LatLng(-6.838798, 107.350882),
      LatLng(-6.836726, 107.352422),
      LatLng(-6.837930, 107.354251),
      LatLng(-6.842777, 107.353071),
      LatLng(-6.842618, 107.350602),
      LatLng(-6.840978, 107.350666),
      LatLng(-6.840483, 107.349486),
      LatLng(-6.839924, 107.350870),
      LatLng(-6.839588, 107.353198)
    ];
  }

  Direction generateDirection(){
    List<LatLng> waypoint = locationMap;
    waypoint.remove(0);
    waypoint.remove(waypoint.length - 1);
    return Direction(
      origin: locationMap.first,
      destination: locationMap.last,
      waypoints: waypoint
    );
  }

  @override
  Widget build(BuildContext context) {
    var coordProvider = Provider.of<CoordinateProviders>(context);
    var timerProvider = Provider.of<TimerProvider>(context);
    var directionProvider = Provider.of<DirectionProvider>(context);
    position = coordProvider.coordinate;
    timer = timerProvider.timer;
    direction = directionProvider.direction;
    if (position.longitude != null || position.latitude != null) {
      _showMarker();
    }
    if (direction.routes != null) {
      _showPolylines();
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
              polylines: _polylines.values.toSet()
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
                locationMap = generateLocationMap();
                directionProvider.fetchDirection(generateDirection());
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
      var myLoc = center;
      _mapController.animateCamera(CameraUpdate.newLatLngZoom(myLoc, 12));
      _mapController.animateCamera(CameraUpdate.newLatLngZoom(myLoc, 17));
      _markers.clear();
      var idx = 0;
      locationMap.forEach((location) {
        print("Index $idx at $location");
        final marker = Marker(
          markerId: MarkerId("Location $idx"),
          position: location,
          infoWindow: InfoWindow(
            title: "Location number $idx!",
            snippet: "Hello",
            onTap: (){
              print("Hello you tapped your location!");
            }
          )
        );
        _markers['$idx'] = marker;
        idx++;
      });
    });
  }

  void _showPolylines() async {
    setState(() {
      var idx = 0;
      _polylines.clear();
      direction.routes.forEach((route) {
        route.legs.forEach((leg) {
          leg.steps.forEach((step) {
            PolylinePoints polylinePoints = PolylinePoints();
            var line = polylinePoints.decodePolyline(step.polyline.points);
            List<LatLng> listCoord = [];
            line.forEach((coord) {
              listCoord.add(LatLng(coord.latitude, coord.longitude));
            });
            var polyline = Polyline(
              polylineId: PolylineId("$idx"),
              points: listCoord,
              color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
              width: 5,
            );
            _polylines["$idx"] = polyline;
            idx++;
          });
        });
      });
    });
  }
}