import 'package:flutter/material.dart';
import 'package:simple_tracker/models/coordinate.dart';

class CoordinateProviders with ChangeNotifier{
  Coordinate _coordinate = Coordinate(0, 0, 0);

  Coordinate get coordinate => _coordinate;

  void increment(){
    _coordinate.latitude += 1;
    _coordinate.longitude += 1;
    _coordinate.elevation += 1;
    notifyListeners();
  }

  void decrement(){
    _coordinate.latitude -= 1;
    _coordinate.longitude -= 1;
    _coordinate.elevation -= 1;
    notifyListeners();
  }
}