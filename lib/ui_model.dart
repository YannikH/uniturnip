import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:uniturnip/utils.dart';

class UIModel extends ChangeNotifier {
  UIModel({
    required data,
    this.onUpdate
  }) : _data = data;

  Map<String, dynamic> _data;
  final void Function(
      {required List<String> path,
      required Map<String, dynamic> data})? onUpdate;

  UnmodifiableMapView<String, dynamic> get data =>
      UnmodifiableMapView<String, dynamic>(_data);

  void modifyData(List<String> path, dynamic value) {
    _data = Utils.modifyMapByPath(path, _data, value);
    notifyListeners();
    onUpdate!(path: path, data: data);
  }

  getDataByPath(List<String> path) {
    return Utils.getDataBypath(path, _data);
  }

}