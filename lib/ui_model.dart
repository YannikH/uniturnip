import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:uniturnip/mapPath.dart';
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

}