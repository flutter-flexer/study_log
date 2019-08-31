import 'package:flutter/material.dart';

class CheckList extends StatefulWidget {
  CheckList({Key key}) : super(key: key);

  @override
  _CheckListState createState() => _CheckListState();
}


class _CheckListState extends State<CheckList> {
  var _bottomNavigationBarIndex = 0;
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

  List<Item> _items = [
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

  void _handleCheckedChanged(Item item, bool isChecked) {
    setState(() {
      if (!isChecked)
        item.isChecked = true;
      else
        item.isChecked = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
//      bottomNavigationBar: BottomNavigationBar(
//        type: BottomNavigationBarType.fixed,
//        currentIndex: _bottomNavigationBarIndex,
//        onTap: (index) {
//          setState(() {
//            _bottomNavigationBarIndex = index;
//          });
//        },
//        items: [
//          BottomNavigationBarItem(
//            icon: Icon(
//                Icons.check_circle,
//            ),
//          ),
//          BottomNavigationBarItem(
//            icon: Icon(
//              Icons.note,
//            ),
//          ),
//        ],
//      ),
      body: Container(
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
//                      onChanged: (string) { // Text 유효성 검증
//
//                      },
//                      onEditingComplete: () { // 작성완료 (enter) 입력시의 행동 정의
//
//                      },
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
                          Text("4/12"),
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
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          final item = _items[index];

                          return Container(
                            height: 36,
                            child: CheckListItem(
                              item: item,
                              isChecked: item.isChecked,
                              onCheckChanged: _handleCheckedChanged,
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
    );
  }
}

typedef void CheckChangedCallback(Item item, bool isChecked);

class CheckListItem extends StatelessWidget {
  CheckListItem({Item item, this.isChecked, this.onCheckChanged})
      : item = item,
        super(key: ObjectKey(item));

  final Item item;
  final bool isChecked;
  final CheckChangedCallback onCheckChanged;

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
        children: <Widget>[Icon(Icons.edit), Icon(Icons.remove)],
      ),
    );
  }
}

class Item {
  String name;
  bool isChecked;

  Item(this.name, this.isChecked);
}
