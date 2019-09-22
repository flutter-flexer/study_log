import 'package:flutter/material.dart';
import 'package:savetrip/CheckList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Tabbar(),
    );
  }
}

class Tabbar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TabbarState();
  }
}

class TabbarState extends State<Tabbar> {
  // This widget is the root of your application.
  int _currentIndex = 1;

  final List<Widget> _children = [
    Icon(Icons.event_note),
    CustomCheckList(),
    Icon(Icons.storage)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Save TRIP')),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.event_note), title: Text('노트')),
          BottomNavigationBarItem(
              icon: Icon(Icons.check_box), title: Text('체크리스트')),
          BottomNavigationBarItem(icon: Icon(Icons.storage), title: Text('일정')),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}