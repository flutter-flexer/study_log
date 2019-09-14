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

class CustomCheckListState extends State<CustomCheckList> {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  final memos = <String>[];
  final Set<String> dictionaryMemo = Set<String>();
  final Set<String> _isChaeckedMemo = Set<String>();

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
                  if (_formKey.currentState.validate()) if (dictionaryMemo
                          .contains(textController.text) ==
                      false) {
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('saved data')));
                    setState(() {
                      dictionaryMemo.add(textController.text);
                      memos.add(textController.text);
                      textController.clear();
                    });
                  } else {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('overlapped data')));
                  }
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
        padding: const EdgeInsets.all(16.0),
        itemCount: memos.length,
        itemBuilder: (context, i) {
          return buildRow(memos[i]);
        });
  }

  Widget buildRow(String str) {
    final bool isChecked = _isChaeckedMemo.contains(str);
    return ListTile(
      title: Text(str),
      leading: Icon(
        isChecked ? Icons.check_box : Icons.check_box_outline_blank,
        color: Colors.blue,
      ),
      onTap: () {
        setState(() {
          if (isChecked) {
            _isChaeckedMemo.remove(str);
          } else {
            _isChaeckedMemo.add(str);
          }
        });
      },
    );
  }
}
