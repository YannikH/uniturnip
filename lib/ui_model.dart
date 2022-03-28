import 'dart:collection';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:uniturnip/mapPath.dart';
import 'package:uniturnip/src/widgets/form/models/widget_data.dart';
import 'package:uniturnip/utils.dart';

class UIModel extends ChangeNotifier {
  UIModel({
    Map<String, dynamic> data = const {},
    this.onUpdate
  }) : _data = data;

  Map<String, dynamic> _data;
  bool _isExternal = false;

  bool get isExternal => _isExternal;

  set data(Map<String, dynamic> value) {
    _data = value;
    _isExternal = true;
    notifyListeners();
    // onUpdate!(path: MapPath(), data: _data);

  }

  void Function(
      {required MapPath path,
      required Map<String, dynamic> data})? onUpdate;

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

  /// for ReaderWidget
  //final String text = 'A child and his father were visiting an elderly neighbor. They were raking the neighbors leaves, organizing the neighbors garage, putting the trash out, and performing other small jobs around the neighbors house. The child had not really seen the elderly neighbor up close, but on this day the child was going to meet the neighbor up close for the first time. When the child met the neighbor up close he asked the neighbor how old he was, and the father was flabbergasted by his childs question and attempted to apologize to the neighbor, but the neighbor laughed and said that was ok, the child is curious. The elderly neighbor told the child he was 92 years old. The child had a look of unbelief and asked the neighbor, "Did you start at the number one?"';
  //int counter = 0;

  String _clickedWord = '';
  String get clickedWord => _clickedWord;

  TextSpan getTextSpan(String sentence, WidgetData widgetData, BuildContext context) {
    final arrayStrings = sentence.split(" ");
    List<TextSpan> arrayOfTextSpan = [];
    late TextSpan textSpan;

    for (int index = 0; index < arrayStrings.length; index++) {
      arrayOfTextSpan.add(TextSpan(text: arrayStrings[index] + ' '));
    }

    textSpan = TextSpan(
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
                getTextSpan(sentence, widgetData, context);
                widgetData.onChange(context, widgetData.path, _clickedWord);
                notifyListeners();
              }))
            .toList());
    return textSpan;
  }

  void hideClickedWord() {
    _clickedWord = '';
    notifyListeners();
  }

// textList = text.split('.');
// sentence = textList[0];


// updateText(bool value) {
//   if (value) {
//     counter++;
//     if (counter < textList.length) {
//       sentence = textList[counter];
//       getTextSpan();
//     }
//   } else {
//     counter--;
//     if (counter >= 0) {
//       sentence = textList[counter];
//       getTextSpan();
//     }
//   }
//   notifyListeners();
// }

}