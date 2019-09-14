import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final title = 'CheckList';

    return MaterialApp(
      title: title,
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
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: CustomCheckList()

      ),
    );
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
                  if (_formKey.currentState.validate())
                    if (dictionaryMemo.contains(textController.text) == false) {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('saved data')));
                      setState(() {
                        dictionaryMemo.add(textController.text);
                        memos.add(textController.text);
                        textController.clear();
                      });
                    } else {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text('overlapped data')));
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
        color : Colors.blue,
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
