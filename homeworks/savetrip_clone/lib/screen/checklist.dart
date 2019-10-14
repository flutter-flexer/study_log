import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_sample/main.dart';
import 'dart:convert';


class ChecklistView extends StatelessWidget {
  ChecklistView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChecklistModel>>(
      future: fetchChecklists(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ChecklistViewStf(key, snapshot.data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}


class ChecklistViewStf extends StatefulWidget {
  List<ChecklistModel> _items;

  ChecklistViewStf(Key key, List<ChecklistModel> items) : super(key: key) {
    this._items = items;
  }

  @override
  ChecklistViewState createState() => ChecklistViewState();
}

class ChecklistViewState extends State<ChecklistViewStf> {
  int _selectedTag = 0;

  final itemTextController = TextEditingController();

  void addItem() {
    if (itemTextController.text.isNotEmpty) {
      setState(() {
        widget._items.insert(0, ChecklistModel(content: itemTextController.text, tag: _selectedTag));
        itemTextController.clear();
      });
    }
  }

  // user defined function
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("전체 삭제"),
          content: new Text("목록을 모두 삭제합니다. 계속 하시겠습니까?"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("삭제"),
              onPressed: () {
                setState(() {
                  if(_selectedTag == 0) {
                    widget._items = [];
                  } else {
                    widget._items.removeWhere((i) => i.tag == _selectedTag);
                  }
                  Navigator.of(context).pop();
                });
              },
            ),
            new FlatButton(
              child: new Text("취소"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final floatingButtonBloc = Provider.of<FloatingButtonBloc>(context); // Counter 타입의 데이터를 가져옴.
    List<ChecklistModel> itemsToShow = _selectedTag == 0 ? widget._items : widget._items.where((i) => i.tag == _selectedTag).toList();
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
              children: <Widget>[
                Container(
                  child: Text('새 항목 추가'),
                  alignment: Alignment.centerLeft,
                ),
                TextField(
                  keyboardType: TextInputType.text,
                  controller: itemTextController,
                  onChanged: (text) {
                    print(text);
                    if (text?.length > 0) {
                      floatingButtonBloc.showButton();
                    } else {
                      floatingButtonBloc.hideButton();
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                        child: TagButton(
                          text: 'All',
                          isSelected: _selectedTag == 0,
                          onTapTagButton: () {
                            setState(() {
                              _selectedTag = 0;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: TagButton(
                          text: '#A',
                          isSelected: _selectedTag == 1,
                          onTapTagButton: () {
                            setState(() {
                              _selectedTag = 1;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: TagButton(
                          text: '#B',
                          isSelected: _selectedTag == 2,
                          onTapTagButton: () {
                            setState(() {
                              _selectedTag = 2;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: TagButton(
                          text: '#C',
                          isSelected: _selectedTag == 3,
                          onTapTagButton: () {
                            setState(() {
                              _selectedTag = 3;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: TagButton(
                          text: '#D',
                          isSelected: _selectedTag == 4,
                          onTapTagButton: () {
                            setState(() {
                              _selectedTag = 4;
                            });
                          },
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
                          '${itemsToShow
                              .where((item) => item.isChecked)
                              .length}/${itemsToShow.length}',
                        ),
                        Container(
                          width: 135.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                onTap: _showDialog,
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
                    child: ChecklistListview(
                      items: itemsToShow,
                      onChecked: (param) {
                        setState(() {
                          var selectedId = itemsToShow[param['index']].id;
                          var matchedIndex = widget._items.indexWhere((i) => i.id == selectedId);
                          widget._items[matchedIndex].isChecked = param['value'];
                        });
                      },
                      onEdited: (index) {
                        setState(() {
                          var selectedId = itemsToShow[index].id;
                          var matchedIndex = widget._items.indexWhere((i) => i.id == selectedId);
                          ChecklistModel item = widget._items.removeAt(matchedIndex);
                          itemTextController.text = item.content;
                          _selectedTag = item.tag;
                        });
                      },
                      onRemoved: (index) {
                        setState(() {
                          var selectedId = itemsToShow[index].id;
                          var matchedIndex = widget._items.indexWhere((i) => i.id == selectedId);
                          widget._items.removeAt(matchedIndex);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChecklistListview extends StatelessWidget {
  final List<ChecklistModel> items;
  final ValueChanged<Map> onChecked;
  final ValueChanged<int> onEdited;
  final ValueChanged<int> onRemoved;

  ChecklistListview({
    @required this.items,
    @required this.onChecked,
    @required this.onEdited,
    @required this.onRemoved,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: items[index].isChecked,
                      onChanged: (value) {
                        onChecked({'value': value, 'index': index});
                      },
                    ),
                    Text(items[index].content),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(3.0),
                    child: GestureDetector(
                      onTap: () {
                        onEdited(index);
                      },
                      child: Icon(Icons.edit),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        onRemoved(index);
                      },
                      child: Icon(Icons.remove),
                    ),
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
  int tag;
  String id;

  ChecklistModel({this.content, this.isChecked=false, this.tag=1, this.id}) {
    if (this.id == null) {
      this.id = (new Uuid()).toString();
    }
  }

  factory ChecklistModel.fromJson(Map<String, dynamic> json) {
    return ChecklistModel(
      content: json['content'],
      isChecked: json['isChecked'],
      tag: json['tag'],
      id: json['id'],
    );
  }
}

Future<List<ChecklistModel>> fetchChecklists() async {
  final response = await http.get('https://flutter-flexer.firebaseapp.com/checklists');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    List<dynamic> jsonList = json.decode(response.body);
    List<ChecklistModel> list = [];
    for (final i in jsonList) {
      list.add(ChecklistModel.fromJson(i));
    }
    return list;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load checklist');
  }
}

class TagButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTapTagButton;

  TagButton({
    this.text,
    this.isSelected,
    this.onTapTagButton,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapTagButton();
      },
      child: Container(
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15.0,
              color: isSelected ? Colors.cyanAccent : Colors.black,
            ),
          ),
        ),
        width: 20.0,
        height: 25.0,
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[200] : Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
