import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '체크리스트'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class TagButtons extends StatefulWidget {
  @override
  _TagButtonsState createState() => _TagButtonsState();
}

class TagModel {
  String text;
  int index;

  TagModel({
    this.text,
    this.index
  });
}

class Item {
  String text;
  TagModel tag;

  Item({
    this.text,
    this.tag
  });
}

List<TagModel> _tags = [
  TagModel(text: "All", index: 0),
  TagModel(text: "#A", index: 1),
  TagModel(text: "#B", index: 2),
  TagModel(text: "#C", index: 3),
  TagModel(text: "#D", index: 4),
];

List<Item> _items = [
  Item(text: "안", tag: _tags[1]),
  Item(text: "녕", tag: _tags[2]),
  Item(text: "하", tag: _tags[3]),
  Item(text: "세", tag: _tags[4]),
  Item(text: "요", tag: _tags[1]),
];

class _TagButtonsState extends State<TagButtons> {
  int _currentSelected = 0;

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: _tags.map((model) => new MaterialButton(
        minWidth: 50.0,
        child: new Text(
          model.text
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        onPressed: () {
          setState(() {
            _currentSelected = model.index;
          });
        },
        color: _currentSelected == model.index ? Colors.lightBlue : Colors.white,
        highlightColor: Colors.lightBlue
      )).toList(),
    );
  }
}

Widget tagSection = new Card(
  margin: EdgeInsets.all(5.0),
  child: new Padding(
    padding: EdgeInsets.all(10.0),
    child: new Column(
      children: [
        new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                decoration: InputDecoration(
                  labelText: '새 항목 추가',
                ),
              ),
            ),
          ],
        ),
        new TagButtons()
      ],
    )
  ),
);

Widget listRow = new Row(
  children: <Widget>[
    new Checkbox(
      onChanged: (bool value) {}, 
      value: null,
    )
  ],
);

Widget listSection = new Card(
  margin: EdgeInsets.all(5.0),
  child: new ListView(
    padding: const EdgeInsets.all(8.0),
    children: <Widget>[

    ],
  )
);

Widget checkBoxItem = Container(
  padding: EdgeInsets.all(10.0),
  child: new Container(
    height: 50,
    color: Colors.amber[600],
    child: const Center(child: Text('Entry A'))
  ),
);

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      drawer: Drawer(),
      body: new Container(
        child: new Column(
          children: <Widget>[
            tagSection,
            new Expanded(
              child: listSection
            )
          ],
        )
      ),
    );
  }
}
