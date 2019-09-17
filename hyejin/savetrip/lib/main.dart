import 'package:flutter/material.dart';

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

// stateful Builder

class CustomCheckList extends StatefulWidget {
  @override
  CustomCheckListState createState() {
    return CustomCheckListState();
  }
}

class CheckItem {
  String text;
  bool isChecked;

  CheckItem(String text, bool isChecked) {
    this.text = text;
    this.isChecked = isChecked;
  }
}

class CustomCheckListState extends State<CustomCheckList> {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  final datas = <CheckItem>[];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        customForm(),
        Expanded(
          child: buildList(),
        ),
      ],
    );
  }

  Widget customForm() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'please enter some text';
                  }
                  return null;
                },
                controller: textController,
              ),
            ),
            Container(
              width: 100,
              child: RaisedButton(
                onPressed: () {
                  Scaffold.of(context).removeCurrentSnackBar();
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('saved data')));
                  setState(() {
                    CheckItem checkItem = CheckItem(textController.text, false);
                    datas.add(checkItem);
                    textController.clear();
                  });
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(0.0),
        itemCount: datas.length,
        itemBuilder: (context, i) {
          return buildRow(datas[i], i);
        });
  }

  Widget buildRow(CheckItem item, int index) {
    return ListTile(
      title: Text(item.text),
      leading: FlatButton(
        onPressed: () {
          setState(() {
            if (item.isChecked) {
              item.isChecked = false;
            } else {
              item.isChecked = true;
            }
          });
        },
        child: Icon(
          item.isChecked ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.blue,
        ),
      ),
      trailing: FlatButton(
        onPressed: () {
          setState(() {
            datas.removeAt(index);
          });
        },
        child: Icon(Icons.delete, color: Colors.red),
      ),
    );
  }
}
