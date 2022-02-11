import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_tracker/datasources/api_service.dart';
import 'package:simple_tracker/models/coordinate.dart';
import 'package:simple_tracker/utilities/locator.dart';

class TimerProvider with ChangeNotifier{
  Timer _timer;
  Timer get timer => _timer;

  void startTimer() async {
    print("Timer started...");
    _timer = Timer.periodic(Duration(seconds: 30), (Timer t) async {
      var location = await Locator.determinePosition();
      if (location != null || location.latitude != null || location.longitude != null){
        var coordinate = Coordinate(
          latitude: location.latitude,
          longitude: location.longitude,
          altitude: location.altitude
        );
        APIService.postSaveCoordinate(coordinate);
      }
    });
    notifyListeners();
  }

  void stopTimer(){
    print("Timer stopped...");
    _timer.cancel();
    notifyListeners();
  }
  
}