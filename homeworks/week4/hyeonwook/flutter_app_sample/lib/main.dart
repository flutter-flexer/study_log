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
      title: 'CopyTrip',
      home: Scaffold(
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
        body: Container(
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
                  children: <Widget>[
                    Container(
                      child: Text('새 항목 추가'),
                      alignment: Alignment.centerLeft,
                    ),
                    TextField(),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: null,
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'All',
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black),
                                  ),
                                ),
                                width: 30.0,
                                height: 18.0,
                                decoration: BoxDecoration(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: null,
                              child: Container(
                                child: Center(
                                  child: Text(
                                    '#A',
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black),
                                  ),
                                ),
                                width: 30.0,
                                height: 18.0,
                                decoration: BoxDecoration(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: null,
                              child: Container(
                                child: Center(
                                  child: Text(
                                    '#B',
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black),
                                  ),
                                ),
                                width: 30.0,
                                height: 18.0,
                                decoration: BoxDecoration(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: null,
                              child: Container(
                                child: Center(
                                  child: Text(
                                    '#C',
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black),
                                  ),
                                ),
                                width: 30.0,
                                height: 18.0,
                                decoration: BoxDecoration(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: null,
                              child: Container(
                                child: Center(
                                  child: Text(
                                    '#D',
                                    style: TextStyle(
                                        fontSize: 15.0, color: Colors.black),
                                  ),
                                ),
                                width: 30.0,
                                height: 18.0,
                                decoration: BoxDecoration(),
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
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '4/12',
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
                      Expanded(child: ChecklistListview()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChecklistListview extends StatefulWidget {
  @override
  _ChecklistListviewState createState() => _ChecklistListviewState();
}

class _ChecklistListviewState extends State<ChecklistListview> {
  List<ChecklistModel> _items;

  @override
  void initState() {
    _items = [
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
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: _items.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    child: Icon(IconData(0xe3c9, fontFamily: 'MaterialIcons')),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(IconData(0xe15b, fontFamily: 'MaterialIcons')),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChecklistModel {
  String content;
  bool isChecked;

  ChecklistModel(this.content, this.isChecked);
}
