import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_tracker/providers/CoordinateProvider.dart';

class CoordinateWidget extends StatelessWidget {
  const CoordinateWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CoordinateProviders>(context);
    var coordinate = provider.coordinate;
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Latitude: ${coordinate.latitude}", style: TextStyle(fontSize: 14),),
          Text("Longitude: ${coordinate.longitude}", style: TextStyle(fontSize: 14),),
          Text("Altitude: ${coordinate.altitude}", style: TextStyle(fontSize: 14),),
          SizedBox(height: 10,),
          Container(
            width: 300,
            child: RaisedButton(
              onPressed: (){
                provider.fetchLocation();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.location_on),
                  Text("Fetch Location")
                ],
              )
            ),
          )
        ],
      ),
    );
  }
}