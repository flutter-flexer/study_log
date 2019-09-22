import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckListBloc with ChangeNotifier {
  List<CheckItem> get all => _all();
  List<CheckItem> datas = [];

  List<CheckItem> _all() {
    return datas;
  }

  void appendData(CheckItem item) {
     datas.add(item);
  }

  void removeData(int index) {
    datas.removeAt(index);
  }

  void changeChecked(CheckItem item) {
    if (item.isChecked) {
      item.isChecked = false;
    } else {
      item.isChecked = true;
    }
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

class CustomCheckList extends StatefulWidget {
  @override
  CustomCheckListState createState() {
    return CustomCheckListState();
  }
}


class CustomCheckListState extends State<CustomCheckList> {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  var _block = CheckListBloc();
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<CheckListBloc>(
      builder: (context) => _block,
      child: Column(
        children: <Widget>[
          customForm(),
          Expanded(
            child: buildList(),
          ),
        ],
      ),
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

                  if(textController.text.isEmpty) {
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('empty data')));
                  } else {
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('saved data')));
                    CheckItem checkItem = CheckItem(textController.text, false);
                    _block.appendData(checkItem);
                    textController.clear();
                    setState(() {});
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
        padding: const EdgeInsets.all(0.0),
        itemCount: _block.datas.length,
        itemBuilder: (context, i) {
          return buildRow(i);
        });
  }

  Widget buildRow(int index) {
    CheckItem item = _block.datas[index];
    return ListTile(
      title: Text(item.text),
      leading: FlatButton(
        onPressed: () {
          _block.changeChecked(item);
          setState(() {

          });
        },
        child: Icon(
          item.isChecked ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.blue,
        ),
      ),
      trailing: FlatButton(
        onPressed: () {
          _block.removeData(index);
          setState(() {

          });
        },
        child: Icon(Icons.delete, color: Colors.red),
      ),
    );
  }
}
