import 'dart:collection';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'mapPath.dart';
import '../utils.dart';
import 'widget_data.dart';

class UIModel extends ChangeNotifier {
  UIModel({Map<String, dynamic> data = const {}, this.onUpdate}) : _data = data;

  Map<String, dynamic> _data;
  bool _isExternal = false;

  bool get isExternal => _isExternal;

  set data(Map<String, dynamic> value) {
    _data = value;
    _isExternal = true;
    notifyListeners();
    // onUpdate!(path: MapPath(), data: _data);
  }

  void Function({required MapPath path, required Map<String, dynamic> data})?
      onUpdate;

  UnmodifiableMapView<String, dynamic> get data =>
      UnmodifiableMapView<String, dynamic>(_data);

  void modifyData(MapPath path, dynamic value) {
    _data = Utils.modifyMapByPath(path, _data, value);
    _isExternal = false;
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
    _isExternal = false;
    notifyListeners();
    onUpdate!(path: path, data: data);
  }

  void removeArrayElement(MapPath path) {
    List<dynamic>? array = Utils.getDataBypath(path, _data);
    if (array != null && array.length > 1) {
      array.removeLast();
      _data = Utils.modifyMapByPath(path, _data, array);
      _isExternal = false;
      notifyListeners();
      onUpdate!(path: path, data: data);
    }
  }

  getDataByPath(MapPath path) {
    return Utils.getDataBypath(path, _data);
  }

  /// -------------- for ReaderWidget --------------

  int _counter = 0;

  List<String> _textList = [];
  List<String> get textList => _textList;

  TextSpan _sentenceAsTextSpan = const TextSpan();
  TextSpan get sentenceAsTextSpan => _sentenceAsTextSpan;

  String _clickedWord = '';
  String get clickedWord => _clickedWord;

  String _sentenceAsString = '';
  String get sentenceAsString => _sentenceAsString;

  String _translation = '';
  String get translation => _translation;

  List<String> words = [];

  void getTextAsList(String text) {
    _textList = text.split('.');
    _sentenceAsString = _textList[_counter];
  }

  void getTextSpan(WidgetData widgetData, BuildContext context) {
    final List<String> arrayStrings = sentenceAsString.split(" ");
    final List<TextSpan> arrayOfTextSpan = [];
    Map<String, String> wordsWithTranslation = widgetData.uiSchema['wordsWithTranslation'];
    String wordWithSpace ='';

    for (int index = 0; index < arrayStrings.length; index++) {
      arrayOfTextSpan.add(TextSpan(text: arrayStrings[index] + ' '));
    }

    _sentenceAsTextSpan = TextSpan(
        children: arrayOfTextSpan
            .map((e) => TextSpan(
            text: e.text,
            style: TextStyle(
              fontSize: 20.0,
              color: (_clickedWord == e.text) ? Colors.greenAccent : Colors.black,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _clickedWord = e.text!;
                wordWithSpace = e.text!;
                getTextSpan(widgetData, context);
                getTranslation(wordWithSpace, wordsWithTranslation); //1
                // _translation = widgetData.uiSchema[clickedWord]['description'];  //2
                words.add(clickedWord);
                widgetData.onChange(context, widgetData.path, words.toSet().toList());
                notifyListeners();
              }))
            .toList());
  }

  void updateText(bool value) {
    if (value) {
      _counter++;
      if (_counter < textList.length) {
      _sentenceAsString = textList[_counter];
      }
    } else {
      _counter--;
      if (_counter >= 0) {
        _sentenceAsString = textList[_counter];
      }
    }
    notifyListeners();
  }

  void getTranslation(String word, Map wordsWithTranslation) {
    var wordWithoutSpace = word.substring(0, word.length - 1);
    if (wordsWithTranslation.containsKey(wordWithoutSpace)) {
      _translation = wordsWithTranslation[wordWithoutSpace];
    } else {
      print("NO word '$word' in $wordsWithTranslation");
    }
    notifyListeners();
  }

  void hideClickedWord() {
    _clickedWord = '';
    notifyListeners();
  }

}