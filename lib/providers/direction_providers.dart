import 'package:flutter/material.dart';
import 'package:simple_tracker/datasources/api_service.dart';
import 'package:simple_tracker/models/direction.dart';
import 'package:simple_tracker/models/direction_response.dart';

class DirectionProvider with ChangeNotifier{
  DirectionResponse _direction = DirectionResponse();
  DirectionResponse get direction => _direction;

  void fetchDirection(Direction data) async {
    var response = await APIService.getDirection(data);
    if (response != null){
      _direction = response;
      notifyListeners();
    }
  }
}