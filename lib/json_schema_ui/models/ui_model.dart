import 'dart:collection';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/json_schema_ui.dart';
import 'package:uniturnip/json_schema_ui/models/mapPath.dart';
import 'package:uniturnip/json_schema_ui/models/widget_data.dart';
import 'package:uniturnip/json_schema_ui/utils.dart';

class UIModel extends ChangeNotifier {
  Map<String, dynamic> _data;
  ChangeCallback? onUpdate;
  SaveAudioRecordCallback? saveAudioRecord;
  FileCallback? saveFile;
  bool disabled;

  UIModel({
    Map<String, dynamic> data = const {},
    this.disabled = false,
    this.onUpdate,
    this.saveAudioRecord,
    this.saveFile,

  }) : _data = data;

  set data(Map<String, dynamic> value) {
    _data = value;
    notifyListeners();
  }

  UnmodifiableMapView<String, dynamic> get data => UnmodifiableMapView<String, dynamic>(_data);

  void modifyData(MapPath path, dynamic value) {
    _data = Utils.modifyMapByPath(path, _data, value);
    notifyListeners();
    onUpdate!(path: path, data: data);
  }

  void addArrayElement(MapPath path) {
    List<dynamic>? array = Utils.getDataBypath(path, _data);
    if (array == null) {
      _data = Utils.modifyMapByPath(path, _data, [null, null]);
    } else {
      int arrayLength = array.length;
      MapPath newPath = path.add('leaf', arrayLength);
      _data = Utils.modifyMapByPath(newPath, _data, null);
    }
    notifyListeners();
    onUpdate!(path: path, data: data);
  }

  void removeArrayElement(MapPath path) {
    List<dynamic>? array = Utils.getDataBypath(path, _data);
    if (array != null && array.length > 1) {
      array.removeLast();
      _data = Utils.modifyMapByPath(path, _data, array);
      notifyListeners();
      onUpdate!(path: path, data: data);
    }
  }

  getDataByPath(MapPath path) {
    return Utils.getDataBypath(path, _data);
  }

  /// -------------- for ReaderWidget --------------

  TextSpan _sentenceAsTextSpan = const TextSpan();

  TextSpan get sentenceAsTextSpan => _sentenceAsTextSpan;

  String _clickedWord = '';

  String get clickedWord => _clickedWord;

  String _translation = '';

  String get translation => _translation;

  final List<String> _sentenceAsList = [];

  List<String> get sentenceAsList => _sentenceAsList;

  List<Map<String, dynamic>> _dataValue = [];

  List<Map<String, dynamic>> get dataValue => _dataValue;

  int _index = 0;

  int get index => _index;

  final List<String> _clickedWordList = [];

  List<String> get clickedWordList => _clickedWordList;

  final List<String> _translationList = [];

  List<String> get translationList => _translationList;

  void setData(List<Map<String, dynamic>> value) {
    _dataValue = value;
  }

  void getSentenceAsList() {
    sentenceAsList.clear();
    for (var map in dataValue) {
      _sentenceAsList.add(map['word']);
    }
  }

  void getTextSpan(WidgetData widgetData, BuildContext context) {
    final List<TextSpan> wordsAsTextSpan = [];
    for (int index = 0; index < sentenceAsList.length; index++) {
      wordsAsTextSpan.add(TextSpan(text: sentenceAsList[index] + ' '));
    }

    _sentenceAsTextSpan = TextSpan(
        children: wordsAsTextSpan
            .map((e) => TextSpan(
                text: e.text,
                style: TextStyle(
                  fontSize: 20.0,
                  color: (_clickedWord == e.text) ? Colors.greenAccent : Colors.black,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _clickedWord = e.text!;
                    getTextSpan(widgetData, context);
                    getTranslate();
                    changeCount(widgetData, context);
                    addToWordsList();
                    notifyListeners();
                  }))
            .toList());
  }

  void hideClickedWord() {
    _clickedWord = '';
    notifyListeners();
  }

  void getTranslate() {
    var wordWithoutSpace = clickedWord.substring(0, clickedWord.length - 1);
    _index = sentenceAsList.indexOf(wordWithoutSpace);
    _translation = dataValue[index]['translation'];
  }

  void changeCount(WidgetData widgetData, BuildContext context) {
    List<Map<String, dynamic>> copyDataList = List.from(dataValue);
    Map<String, dynamic> copyDataMap = {...dataValue[index]};
    copyDataMap['count'] = copyDataMap['count'] + 1;

    if (copyDataMap['count'] == 1) {
      if (copyDataMap['active'] == true) copyDataMap['active'] = false;
    }

    copyDataList.removeAt(index);
    copyDataList.insert(index, copyDataMap);

    widgetData.onChange(widgetData.path, copyDataList);
  }

  void addToWordsList() {
    if (clickedWordList.contains(clickedWord) && translationList.contains(translation)) {
      var i = _clickedWordList.indexOf(clickedWord);
      _clickedWordList.insert(i, clickedWord);
      _clickedWordList.remove(clickedWord);
      _translationList.insert(i, translation);
      _translationList.remove(translation);
    } else {
      _clickedWordList.add(clickedWord);
      _translationList.add(translation);
    }
    notifyListeners();
  }

  /// -------------- for CardWidget --------------

  int _counter = 0;

  int get counter => _counter;

  int _length = 0;

  int get length => _length;

  void initValues(Map schema) {
    List fields = schema['properties'].keys.toList();
    _length = fields.length;
  }

  getField() {
    _counter++;
    if (counter == length) _counter = 0;
    notifyListeners();
  }
}
