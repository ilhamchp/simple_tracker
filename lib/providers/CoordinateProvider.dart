import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:simple_tracker/utilities/locator.dart';

class CoordinateProviders with ChangeNotifier{
  Position _coordinate = Position();

  Position get coordinate => _coordinate;

  void fetchLocation() async {
    var location = await Locator.determinePosition();
    if (location != null) {
      print(location);
      _coordinate = location;
      notifyListeners();
    }
  }
}