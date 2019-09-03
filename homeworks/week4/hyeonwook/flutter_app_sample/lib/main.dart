import 'package:flutter/material.dart';

// Uncomment lines 7 and 10 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  // debugPaintSizeEnabled = true;
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

class ChecklistWidget extends StatefulWidget {
  @override
  _ChecklistWidgetState createState() => _ChecklistWidgetState();
}

class _ChecklistWidgetState extends State<ChecklistWidget> {
  var _selectedTagIndex = 0;
  var _items = [
    new ChecklistModel("담요 2장", false),
    new ChecklistModel("속옷 5벌", false),
    new ChecklistModel("양말 6개", false),
    new ChecklistModel("바디로션", false),
    new ChecklistModel("샴푸", false),
    new ChecklistModel("국제운전면허증", false),
    new ChecklistModel("여행용충전기", false),
    new ChecklistModel("물티슈", false),
    new ChecklistModel("카메라", true),
    new ChecklistModel("여권", true),
    new ChecklistModel("선글라스", true),
    new ChecklistModel("아이패드", true)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            margin: EdgeInsets.only(bottom: 5.0),
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '새 항목 추가',
                  style: TextStyle(color: Colors.lightBlueAccent),
                ),
                TextField(),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: StatefulBuilder(
                    builder: (context, tagsSetState) {
                      var tags = ['All', 'A', 'B', 'C', 'D'];

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          for (var index = 0; index < tags.length; index++)
                            GestureDetector(
                              onTap: () {
                                tagsSetState(() {
                                  _selectedTagIndex = index;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, top: 6, bottom: 6),
                                child: Center(
                                  child: Text(
                                    _selectedTagIndex == index
                                        ? '${tags[index]}'
                                        : '#${tags[index]}',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: index == _selectedTagIndex
                                            ? Colors.lightBlueAccent
                                            : Colors.black),
                                  ),
                                ),
                                decoration: index == _selectedTagIndex
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.grey.withOpacity(0.2))
                                    : BoxDecoration(),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StatefulBuilder(
              builder: (context, listSetState) {
                var selectedCount = _items.where((i) => i.isChecked).length;

                return Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '$selectedCount/${_items.length}',
                            ),
                            Container(
                              width: 135.0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: null,
                                    child: Container(
                                      child: Center(
                                        child: Text(
                                          '태그명 편집',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: null,
                                    child: Container(
                                      child: Center(
                                        child: Text(
                                          '모두 삭제',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: _items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        Checkbox(
                                          value: _items[index].isChecked,
                                          onChanged: (bool value) {
                                            setState(() {
                                              _items[index].isChecked = value;
                                            });
                                          },
                                        ),
                                        Text(_items[index].content),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(3.0),
                                        child: Icon(IconData(0xe3c9,
                                            fontFamily: 'MaterialIcons')),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5.0),
                                        child: Icon(IconData(0xe15b,
                                            fontFamily: 'MaterialIcons')),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChecklistModel {
  String content;
  bool isChecked;

  ChecklistModel(this.content, this.isChecked);
}
