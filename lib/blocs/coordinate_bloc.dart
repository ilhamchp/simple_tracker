import 'dart:async';
import 'package:simple_tracker/models/coordinate.dart';

class CoordinateBloc{
  var _coordinate = Coordinate(0, 0, 0);
  Coordinate get coordinate => _coordinate;

  StreamController _inputController = StreamController();
  StreamSink get inputSink => _inputController.sink;

  StreamController _outputController = StreamController();
  StreamSink get _outputSink => _outputController.sink;

  Stream get outputStream => _outputController.stream;

  CoordinateBloc(){
    _inputController.stream.listen((event) {
      if (event == 'increase') {
        _coordinate.latitude += 1;
        _coordinate.longitude += 1;
        _coordinate.elevation += 1;
        
        _outputSink.add(_coordinate);
      } else if (event == 'decrease') {
        _coordinate.latitude -= 1;
        _coordinate.longitude -= 1;
        _coordinate.elevation -= 1;

        _outputSink.add(_coordinate);
      }
    });
  }

  dispose(){
    _inputController.close();
    _outputController.close();
  }
}