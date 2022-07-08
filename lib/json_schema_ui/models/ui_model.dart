import 'dart:collection';
import 'package:flutter/material.dart';
import 'mapPath.dart';
import '../utils.dart';

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
  /// и эти данные передаются в formData
  void modifyData(MapPath path, dynamic value) {
    _data = Utils.modifyMapByPath(path, _data, value);
    notifyListeners();
    onUpdate!(path: path, data: data);
  }

  /// добавляет поле в форме, если поле типа array
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

  /// удаляет поле в форме, если поле типа array
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

  /// -------------- for CardWidget --------------

  int _counter = 0;
  int get counter => _counter;

  int _numberOfCards  = 0;
  int get numberOfCards  => _numberOfCards ;

  /// в методе getNumOfCards получаем количество карточек, которое используем в методе getCard
  void getNumOfCards(Map schema) {
    List cards  = schema['properties'].keys.toList();
    _numberOfCards  = cards .length;
  }

  getCard() {
    /// значение counter нужен для метода retrieveSchemaFields, откуда определяется какую карточку передать для отображения в UI
    _counter ++;

    /// показ карточек начинается с начала (с первой карточки)
    if (counter == numberOfCards ) _counter = 0;
    notifyListeners();
  }
}