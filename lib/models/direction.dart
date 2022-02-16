import 'package:google_maps_flutter/google_maps_flutter.dart';

class Direction {
  LatLng origin;
  LatLng destination;
  List<LatLng> waypoints;

  Direction({this.origin, this.destination, this.waypoints});
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.origin != null) {
      data['origin'] = this.origin.toJson();
    }
    if (this.destination != null) {
      data['destination'] = this.destination.toJson();
    }
    if (this.waypoints != null) {
      data['waypoints'] = this.waypoints.map((v) => v.toJson()).toList();
    }
    return data;
  }
}