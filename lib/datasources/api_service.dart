import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_tracker/models/coordinate.dart';
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
}