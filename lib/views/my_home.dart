import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_tracker/providers/CoordinateProvider.dart';
import 'package:simple_tracker/providers/timer_provider.dart';
import 'package:simple_tracker/widgets/coordinate_widget.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoordinateProviders>(
          create: (_) => CoordinateProviders(),
        ),
        ChangeNotifierProvider<TimerProvider>(
          create: (_) => TimerProvider(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text("Simple Tracker"),),
        body: CoordinateWidget(),
      ),
    );
  }
}