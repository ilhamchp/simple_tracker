import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_tracker/models/coordinate.dart';
import 'package:simple_tracker/models/direction.dart';
import 'package:simple_tracker/models/direction_response.dart';
import '../models/coordinate_response.dart';

class APIService{
  static Future<CoordinateResponse> postSaveCoordinate(Coordinate data) async {
    Uri url = Uri.parse('https://hookb.in/YV0P8eZkDeCQERGGEbeJ');
    var body = jsonEncode(data);
    return http.post(
      url,
      body: body,
    ).then((http.Response response) async {
      try{
        print("Response postSaveCoordinate : " + response.body.toString());
        if (response.statusCode == 200 || response.body != null) {
          CoordinateResponse _coordinateResponse = CoordinateResponse.fromJson(jsonDecode(response.body));
          return _coordinateResponse;
        }
        return null;
      }catch(ex){
        print("Error postSaveCoordinate: " + ex.toString());
        return null;
      }
    });
  }

  static Future<DirectionResponse> getDirection(Direction data) async {
    String apiKey = "AIzaSyDsol1tjzTS_mpuxfRaVIeRslJjY5g3I4I";
    String origin = "${data.origin.latitude},${data.origin.longitude}";
    String destination = "${data.destination.latitude},${data.destination.longitude}";
    String waypoints = "";
    data.waypoints.forEach((coordinate) {
      waypoints = waypoints + "${coordinate.latitude},${coordinate.longitude}|";
    });
    final queryParameters = {
      'key': apiKey,
      'origin': origin,
      'destination': destination,
      'waypoints': waypoints
    };
    final url =
      Uri.https('maps.googleapis.com', '/maps/api/directions/json', queryParameters);
    return http.get(
      url,
    ).then((http.Response response) async {
      try{
        print("Response getDirection : " + response.body.toString());
        if (response.statusCode == 200 || response.body != null) {
          DirectionResponse _directionResponse = DirectionResponse.fromJson(jsonDecode(response.body));
          return _directionResponse;
        }
        return null;
      }catch(ex){
        print("Error getDirection: " + ex.toString());
        return null;
      }
    });
  }

}