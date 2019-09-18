import 'package:flutter/material.dart';
import 'package:layout/checklist.dart';
import 'package:provider/provider.dart';

void main() {
  // debugPaintSizeEnabled = true;
  Provider.debugCheckInvalidValueType = null;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: TextTheme(
            title: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
      title: 'CopyTrip',
      home: HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final _tabTitles = [
    '노트',
    '체크리스트',
    '일정',
    '비용',
    '일기',
  ];
  var _currentTap = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          tooltip: 'Navigation menu',
          onPressed: null,
        ),
        title: Text(_tabTitles[_currentTap]),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentTap,
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          unselectedItemColor: Colors.grey,
          selectedIconTheme: IconThemeData(color: Colors.lightBlueAccent),
          selectedItemColor: Colors.lightBlueAccent,
          onTap: (index) {
            setState(() {
              _currentTap = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note),
              title: Text('노트'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle),
              title: Text('체크리스트'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_numbered),
              title: Text('일정'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on),
              title: Text('비용'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              title: Text('일기'),
            ),
          ]),
    );
  }

  Widget _buildBody() {
    switch (_currentTap) {
      case 0:
        return Container();
      case 1:
        return ChecklistWidget();
      case 2:
        return Container();
      case 3:
        return Container();
      case 4:
        return Container();
      default:
        throw UnimplementedError('잘못된 tap index 입니다.');
    }
  }
}


