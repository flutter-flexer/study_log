import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChecklistBloc with ChangeNotifier {
  List<ChecklistModel> get all => _all();
  List<ChecklistModel> _all() {
    return hashTagA + hashTagB + hashTagC + hashTagD;
  }

  List<ChecklistModel> hashTagA = [
    new ChecklistModel("담요 2장", false),
    new ChecklistModel("속옷 5벌", false),
    new ChecklistModel("양말 6개", false),
    new ChecklistModel("바디로션", false),
  ];
  List<ChecklistModel> hashTagB = [
    new ChecklistModel("샴푸", false),
    new ChecklistModel("국제운전면허증", false),
    new ChecklistModel("여행용충전기", false),
    new ChecklistModel("물티슈", false),
  ];
  List<ChecklistModel> hashTagC = [
    new ChecklistModel("카메라", true),
    new ChecklistModel("여권", true),
  ];
  List<ChecklistModel> hashTagD = [new ChecklistModel("선글라스", true), new ChecklistModel("아이패드", true)];

  int get checkedCount => _checkedCount;
  int _checkedCount = 0;
  set checkedCount(newValue) {
    if (_checkedCount != newValue) {
      _checkedCount = newValue;
      notifyListeners();
    }
  }

  void updateCheckedCount() {
    int checkedCountOfTagA = hashTagA.where((e) => e.isChecked).length;
    int checkedCountOfTagB = hashTagB.where((e) => e.isChecked).length;
    int checkedCountOfTagC = hashTagC.where((e) => e.isChecked).length;
    int checkedCountOfTagD = hashTagD.where((e) => e.isChecked).length;

    int total = checkedCountOfTagA + checkedCountOfTagB + checkedCountOfTagC + checkedCountOfTagD;

    _checkedCount = total;
  }
}

class ChecklistModel {
  String content;
  bool isChecked;

  ChecklistModel(this.content, this.isChecked);
}

class ChecklistWidget extends StatefulWidget {
  @override
  _ChecklistWidgetState createState() => _ChecklistWidgetState();
}

class _ChecklistWidgetState extends State<ChecklistWidget> {
  var _selectedTagIndex = 0;

  var _bloc = ChecklistBloc();

  @override
  Widget build(BuildContext context) {
    _bloc.updateCheckedCount();

    return ChangeNotifierProvider<ChecklistBloc>(
      builder: (context) => _bloc,
      child: Container(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '새 항목 추가',
                    style: TextStyle(color: Colors.lightBlueAccent),
                  ),
                  TextField(),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: StatefulBuilder(
                      builder: (context, tagsSetState) {
                        var tags = ['All', 'A', 'B', 'C', 'D'];

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            for (var index = 0; index < tags.length; index++)
                              GestureDetector(
                                onTap: () {
                                  tagsSetState(() {
                                    _selectedTagIndex = index;
                                  });

                                  setState(() {

                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(left: 12, right: 12, top: 6, bottom: 6),
                                  child: Center(
                                    child: Text(
                                      _selectedTagIndex == index ? '${tags[index]}' : '#${tags[index]}',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: index == _selectedTagIndex ? Colors.lightBlueAccent : Colors.black),
                                    ),
                                  ),
                                  decoration: index == _selectedTagIndex
                                      ? BoxDecoration(
                                          borderRadius: BorderRadius.circular(16), color: Colors.grey.withOpacity(0.2))
                                      : BoxDecoration(),
                                ),
                              ),
                          ],
                        );
                      },
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
                            '${_bloc.checkedCount}/${_bloc.all.length}',
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
                      child: ListView(
                        children: [
                          ..._buildList()
                        ],
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

  List<Widget> _buildList() {
    List<ChecklistModel> items = [];
    switch (_selectedTagIndex) {
      case 0:
        items = _bloc.all;
        break;
      case 1:
        items = _bloc.hashTagA;
        break;
      case 2:
        items = _bloc.hashTagB;
        break;
      case 3:
        items = _bloc.hashTagC;
        break;
      case 4:
        items = _bloc.hashTagD;
        break;
      default:
        throw UnimplementedError("적합하지 않은 tag index");
    }

    return items.map((i) => Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: i.isChecked,
                  onChanged: (bool value) {
                    setState(() {
                      i.isChecked = value;
                    });
                  },
                ),
                Text(i.content),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(3.0),
                child: Icon(IconData(0xe3c9, fontFamily: 'MaterialIcons')),
              ),
              Container(
                padding: EdgeInsets.all(5.0),
                child: Icon(IconData(0xe15b, fontFamily: 'MaterialIcons')),
              ),
            ],
          ),
        ],
      ),
    )).toList();
  }
}
