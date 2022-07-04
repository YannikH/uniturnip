import 'dart:collection';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../utils.dart';
import 'mapPath.dart';
import 'widget_data.dart';

class UIModel extends ChangeNotifier {
  UIModel({Map<String, dynamic> data = const {}, this.onUpdate}) : _data = data;

  Map<String, dynamic> _data;

  ///  получаем данные из formData
  set data(Map<String, dynamic> value) {
    _data = value;
    notifyListeners();
  }

  void Function({required MapPath path, required Map<String, dynamic> data})?
      onUpdate;

  UnmodifiableMapView<String, dynamic> get data =>
      UnmodifiableMapView<String, dynamic>(_data);

  /// этот метод вызывается, когда пользователь вводит данные в текстовое поле.
  /// и новые данные этого текстового поля передаются в formData
  void modifyData(MapPath path, dynamic value) {
    _data = Utils.modifyMapByPath(path, _data, value);
    notifyListeners();
    onUpdate!(path: path, data: data);
  }

  /// добавляет поле в форме, если тип array c items
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

  /// удаляет поле в форме, если тип array c items
  void removeArrayElement(MapPath path) {
    List<dynamic>? array = Utils.getDataBypath(path, _data);
    if (array != null && array.length > 1) {
      array.removeLast();
      _data = Utils.modifyMapByPath(path, _data, array);
      notifyListeners();
      onUpdate!(path: path, data: data);
    }
  }

  /// возвращает значение поля из formData
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

  final List<String> _words = [];
  List<String> get words => _words;

  List<Map<String, dynamic>> _formData = [];
  List<Map<String, dynamic>> get formData => _formData;

  int _index = 0;
  int get index => _index;

  final List<String> _clickedWords = [];
  List<String> get clickedWords => _clickedWords;

  final List<String> _translations = [];
  List<String> get translations => _translations;

  void setData(List<Map<String, dynamic>> value) {
    /// получаем данные текста из formData
    _formData = value;
    /// получаем список всех слов текста (words)
    words.clear();
    for (var map in formData) {
      _words.add(map['word']);
    }
  }

  void getTextSpan(WidgetData widgetData, BuildContext context) {
    /// все слова из списка words оборачиваем виджетом TextSpan
    final List<TextSpan> wordsAsTextSpan = [];
    for (int index = 0; index < words.length; index++) {
      wordsAsTextSpan.add(TextSpan(text: words[index] + ' '));
    }

    /// получаем текст типа TextSpan
    _sentenceAsTextSpan = TextSpan(
        children: wordsAsTextSpan.map((word) => TextSpan(
            text: word.text,
            style: TextStyle(
              fontSize: 20.0,
              color: (_clickedWord == word.text) ? Colors.greenAccent : Colors.black,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _clickedWord = word.text!;
                getTextSpan(widgetData, context); /// снова вызываем этот метод(рекурсия), чтобы нажатое слово поменяло цвет
                getTranslate(); /// получаем перевод нажатого слова
                increaseCount(widgetData, context); /// увеличиваем свойство count(количество нажатий) на один
                getClickedWords(); /// получаем список всех нажатых слов
                notifyListeners();
              }))
            .toList());
  }

  void hideClickedWord() {
    _clickedWord = '';
    notifyListeners();
  }

  void getTranslate() {
    var wordWithoutSpace = clickedWord.substring(0, clickedWord.length - 1); /// убираем лишний пробел в конце слова
    _index = words.indexOf(wordWithoutSpace); /// находим под каким индексом находится нажатое слово в списке всех слов
    _translation = formData[index]['translation']; /// получаем перевод нажатого слова
  }

  void increaseCount(WidgetData widgetData, BuildContext context) {
    List<Map<String, dynamic>> formDataAsList = List.from(formData);   /// получаем данные текста из formData в виде списка
    Map<String, dynamic> clickedWordProperties = {...formData[index]};
    clickedWordProperties['count'] = clickedWordProperties['count'] + 1; /// при каждом нажатии на слово, свойство count этого слова увеличивается на один

    if (clickedWordProperties['count'] == 1) clickedWordProperties['active'] = true; /// если слово нажато один раз, то свойство active становится true

    /// заменяем в схеме изменившиеся свойства
    formDataAsList.removeAt(index);
    formDataAsList.insert(index, clickedWordProperties);

    widgetData.onChange(context, widgetData.path, formDataAsList);    /// и передаем в метод onChange
  }

  /// добавляем все нажатые слова по очереди в список для отображения в UI
  void getClickedWords() {
    if (!clickedWords.contains(clickedWord) && !translations.contains(translation)) {
      _clickedWords.add(clickedWord);
      _translations.add(translation);
    }
    notifyListeners();
  }


  /// -------------- for CardWidget --------------

  int _counter = 0;
  int get counter => _counter;

  int _numberOfCards = 0;
  int get numberOfCards => _numberOfCards;

  /// в методе getNumOfCards получаем количество карточек, которое используем в методе getCard
  void getNumOfCards(Map schema) {
    List cards = schema['properties'].keys.toList(); /// получаем список всех карточек
    _numberOfCards = cards.length;
  }

  getCard() {
    _counter ++; /// значение counter нужен для метода retrieveSchemaFields, откуда определяется какую карточку передать для отображения в UI
    if (counter == numberOfCards) _counter = 0; /// показ карточек начинается с начала (с первой карточки)
    notifyListeners();
  }
}