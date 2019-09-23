import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CheckListBloc with ChangeNotifier {
  List<Item> items = [
    Item("2 blackets", false),
    Item("5 underwears", false),
    Item("6 pair socks", false),
    Item("Body lotion", false),
    Item("Hair shampoo", false),
    Item("International driver license", false),
    Item("Universal Charger", false),
    Item("Wet tissues", false),
    Item("Camera", true),
    Item("Passport", true),
    Item("Sunglass", true),
    Item("iPad", true),
  ];

  int _checkCount = 0;

  int get checkCount => _checkCount;

  set checkCount(v) {
    if (_checkCount != v) {
      _checkCount = v;
      notifyListeners();
    }
  }

  void updateCheckCount() {
    _checkCount = items.where((e) => e.isChecked).length;
  }
}

class CheckList extends StatefulWidget {
  CheckList({Key key}) : super(key: key);

  @override
  _CheckListState createState() => _CheckListState();
}

class _CheckListState extends State<CheckList> {
  var _bottomNavigationBarIndex = 1;
  var _floatingButtonFlag = false;
  var _focusNode = FocusNode();
  var _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();

    super.dispose();
  }

  var _bloc = CheckListBloc();

  void _handleCheckedChanged(Item item, bool isChecked) {
    setState(() {
      if (!isChecked)
        item.isChecked = true;
      else
        item.isChecked = false;
    });
  }

  void _handleItemAdded(String itemName) {
    setState(() {
      Fluttertoast.showToast(
        msg: '"' + _textEditingController.text + '" 추가됨',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
      );

      _bloc.items.add(Item(itemName, false));
    });
  }

  void _handleItemDeleted(Item item) {
    setState(() {
      Fluttertoast.showToast(
        msg: '"' + item.name + '" 제거됨',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
      );
      _bloc.items.remove(item);
    });
  }

  void _handleItemEdit(Item item) {
    setState(() {
      Fluttertoast.showToast(
        msg: '"' + item.name + '" 수정',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
      );
      _textEditingController.text = item.name;
      _bloc.items.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    _bloc.updateCheckCount();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          "Checklists",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.black45,
              ),
              onPressed: () {}),
        ],
      ),
      drawer: Drawer(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _bottomNavigationBarIndex,
        selectedItemColor: Colors.lightBlue,
        onTap: (index) {
          setState(() {
            _bottomNavigationBarIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.description,
            ),
            title: Text("노트"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_circle,
            ),
            title: Text("체크리스트"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.format_list_numbered,
            ),
            title: Text("일정"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.monetization_on,
            ),
            title: Text("비용"),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.mode_comment,
            ),
            title: Text("일기"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          if (_floatingButtonFlag) {
            _handleItemAdded(_textEditingController.text);
            _textEditingController.text = "";
          }
        },
      ),
      body: ChangeNotifierProvider<CheckListBloc>(
        builder: (context) => _bloc,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black12,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Add new item",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.lightBlue,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      TextField(
                        focusNode: _focusNode,
                        controller: _textEditingController,
                        onChanged: (s) {
                          if (s != "") {
                            _floatingButtonFlag = true;
                          }
                        },
                        onEditingComplete: () {
                          // 작성완료 (enter) 입력시의 행동 정의
                          if (_textEditingController.text != "") {
                            _handleItemAdded(_textEditingController.text);
                            _textEditingController.text = "";
                            _floatingButtonFlag = false;
                          }
                        },
                        onTap: () {},
                        //keyboardType: Keybo,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.lightBlue,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        //mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            width: 70,
                            child: FlatButton(
                              onPressed: () {},
                              //color: Colors.black12,
                              color: Colors.grey.withOpacity(0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                "#ALL",
                                style: TextStyle(
                                  color: Colors.lightBlue,
                                ),
                              ),
                            ),
                          ),
                          // TODO: cover each flat button to container
                          FlatButton(
                            onPressed: () {},
                            child: Text("#A"),
                          ),
                          FlatButton(
                            onPressed: () {},
                            child: Text("#B"),
                          ),
                          FlatButton(
                            onPressed: () {},
                            child: Text("#C"),
                          ),
//                        FlatButton(
//                          onPressed: () {},
//                          child: Text(
//                              "#D"
//                          ),
//                        ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  //padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //Text("4/12"),
                            Text('${_bloc._checkCount}/${_bloc.items.length}'),
                            Text(
                              " DELETE ALL",
                              style: TextStyle(
                                color: Colors.lightBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _bloc.items.length,
                          itemBuilder: (context, index) {
                            final item = _bloc.items[index];

                            return Container(
                              //height: 56,
                              child: CheckListItem(
                                item: item,
                                isChecked: item.isChecked,
                                onCheckChanged: _handleCheckedChanged,
                                onItemAdded: _handleItemAdded,
                                onItemDeleted: _handleItemDeleted,
                                onItemEdit: _handleItemEdit,
                              ),
                            );
                          },
                        ),
                      ),
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

// TODO: show floating button only when the textfield is active
//class ItemAddFloatingButton extends StatelessWidget {
//  //ItemAddFloatingButton({})
//
//  @override
//  Widget build(BuildContext context) {
//    return FloatingActionButton(
//      child: Icon(Icons.add),
//      onPressed: () {
//        if (_floatingButtonFlag) {
//          _handleItemAdded(_textEditingController.text);
//          _textEditingController.text = "";
//        }
//      },
//    );
//
//  }
//}

typedef void CheckChangedCallback(Item item, bool isChecked);
typedef void ItemAddedCallback(String itemName);
typedef void ItemDeletedCallback(Item item);
typedef void ItemEditCallback(Item item);

class CheckListItem extends StatelessWidget {
  CheckListItem(
      {Item item,
      this.isChecked,
      this.onCheckChanged,
      this.onItemAdded,
      this.onItemDeleted,
      this.onItemEdit})
      : item = item,
        super(key: ObjectKey(item));

  final Item item;
  final bool isChecked;
  final CheckChangedCallback onCheckChanged;
  final ItemAddedCallback onItemAdded;
  final ItemDeletedCallback onItemDeleted;
  final ItemEditCallback onItemEdit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.all(1.0),
      onTap: () {
        onCheckChanged(item, item.isChecked);
      },
      leading: Checkbox(
        value: item.isChecked,
        onChanged: (v) {
          onCheckChanged(item, item.isChecked);
        },
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      title: Text(
        item.name,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              onItemEdit(item);
            },
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              onItemDeleted(item);
            },
          ),
        ],
      ),
    );
  }
}

class Item {
  String name;
  bool isChecked;
  int idx;
  String tag;

  // TODO: add order and tag
  //int order; // this order is for sorting
  //String tag;

  Item(this.name, this.isChecked, {this.idx = 0, this.tag = 'A'});
}
