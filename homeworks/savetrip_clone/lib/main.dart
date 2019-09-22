import 'package:flutter/material.dart';
import 'package:flutter_app_sample/screen/checklist.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CopyTrip',
      home: Main(),
    );
  }
}

class FloatingButtonBloc with ChangeNotifier {
  bool _isShow;
  bool get isShow => _isShow;

  FloatingButtonBloc(this._isShow);

  void showButton() {
    print('Here');
    _isShow = true;
    notifyListeners();
  }
  void hideButton() {
    _isShow = false;
    notifyListeners();
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _tabIndex = 1;

  final GlobalKey<ChecklistViewState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FloatingButtonBloc>(
      builder: (_) => FloatingButtonBloc(false),
      child: Consumer<FloatingButtonBloc>(
        builder: (context, bloc, _) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.menu),
                tooltip: 'Navigation menu',
                onPressed: null,
              ),
              title: Container(
                child: Text('Checklists'),
                alignment: Alignment.centerLeft,
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.home),
                  tooltip: 'Search',
                  onPressed: null,
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                setState(() {
                  _tabIndex = index;
                });
              },
              backgroundColor: Colors.white,
              showUnselectedLabels: true,
              currentIndex: _tabIndex,
              fixedColor: Colors.lightBlueAccent,
              unselectedItemColor: Colors.black,
              selectedFontSize: 12.0,
              unselectedFontSize: 12.0,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.event_note),
                  title: Text('노트'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
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
              ],
            ),
            floatingActionButton: Visibility(
              visible: bloc.isShow,
              child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  _key.currentState.addItem();
                },
                backgroundColor: Colors.blue,
              ),
            ),
            body: ChecklistView(key: _key),
          );
        }
      ),
    );
  }
}
