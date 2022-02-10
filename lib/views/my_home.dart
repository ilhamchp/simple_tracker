import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_tracker/providers/CoordinateProvider.dart';
import 'package:simple_tracker/widgets/coordinate_widget.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CoordinateProviders(),
      child: Scaffold(
        appBar: AppBar(title: Text("Simple Tracker"),),
        body: CoordinateWidget(),
      ),
    );
  }
}