import 'package:flutter/material.dart';

class ChecklistScreen extends StatelessWidget {
  ChecklistScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChecklistView(key: key);
  }
}

class ChecklistView extends StatefulWidget {
  ChecklistView({Key key}) : super(key: key);

  @override
  ChecklistViewState createState() => ChecklistViewState();
}

class ChecklistViewState extends State<ChecklistView> {
  List<ChecklistModel> _items;
  int _selectedTag = 0;

  final itemTextController = TextEditingController();

  @override
  void initState() {
    _items = [
      new ChecklistModel(content: "담요 2장"),
      new ChecklistModel(content: "속옷 5벌"),
      new ChecklistModel(content: "양말 6개"),
      new ChecklistModel(content: "바디로션"),
      new ChecklistModel(content: "샴푸"),
      new ChecklistModel(content: "국제운전면허증"),
      new ChecklistModel(content: "여행용충전기"),
      new ChecklistModel(content: "물티슈"),
      new ChecklistModel(content: "카메라", isChecked: true),
      new ChecklistModel(content: "여권", isChecked: true),
      new ChecklistModel(content: "선글라스", isChecked: true),
      new ChecklistModel(content: "아이패드", isChecked: true)
    ];
  }

  void addItem() {
    if (itemTextController.text.isNotEmpty) {
      setState(() {
        _items.insert(0, ChecklistModel(content: itemTextController.text, tag: _selectedTag));
        itemTextController.clear();
      });
    }
  }

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
              children: <Widget>[
                Container(
                  child: Text('새 항목 추가'),
                  alignment: Alignment.centerLeft,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: itemTextController,
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
                          '${_items
                              .where((item) => item.isChecked)
                              .length}/${_items.length}',
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
                    child: ChecklistListview(
                      items: _items,
                      onChecked: (param) {
                        setState(() {
                          _items[param['index']].isChecked = param['value'];
                        });
                      },
                      onEdited: (index) {
                        setState(() {
                          ChecklistModel item = _items.removeAt(index);
                          itemTextController.text = item.content;
                          _selectedTag = item.tag;
                        });
                      },
                      onRemoved: (index) {
                        setState(() {
                          _items.removeAt(index);
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

  ChecklistModel({this.content, this.isChecked=false, this.tag = 1});
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
