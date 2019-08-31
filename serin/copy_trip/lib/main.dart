import 'package:flutter/material.dart';
import 'package:copy_trip/screens/checklists.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Copy save stip',
      theme: ThemeData(
        primaryColor: Colors.white,
        //primarySwatch: Colors.blue,
      ),
      home: CheckList(),
    );
  }
}

