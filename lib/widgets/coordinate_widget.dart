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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Latitude: ${coordinate.latitude}", style: TextStyle(fontSize: 14),),
        Text("Longitude: ${coordinate.longitude}", style: TextStyle(fontSize: 14),),
        Text("Elevation: ${coordinate.elevation}", style: TextStyle(fontSize: 14),),
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(icon: Icon(Icons.add), onPressed: (){
              provider.increment();
            }),
            IconButton(icon: Icon(Icons.remove), onPressed: (){
              provider.decrement();
            })
          ],
        )
      ],
    );
  }
}