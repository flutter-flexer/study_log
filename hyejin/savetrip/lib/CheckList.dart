import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChecklistBloc with ChangeNotifier {
  List<CheckItem> get all => _all();

  List<CheckItem> _all() {
    return datas;
  }
}

List<CheckItem> datas = [];

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
