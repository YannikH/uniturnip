import 'package:flutter/material.dart';
import 'package:uniturnip/mapPath.dart';

class Utils {

  static Map<String, dynamic> modifyMapByPath(
    MapPath path,
    Map<String, dynamic> data,
    dynamic value) {

    data = {...data};
    data = _modifyMapByPath(path, data, value).cast<String, dynamic>();
    return data;
  }

  static dynamic _modifyMapByPath(
      MapPath path,
      dynamic data,
      dynamic value) {
    if (path.steps.isNotEmpty) {
      if (path.steps.length > 1) {
        PathStep step = path.steps[0];
        if (step.type == StepType.object) {
          data[step.pointer] ??= {}; //TODO Test replacing object with array
        } else if (step.type == StepType.array) {
          data[step.pointer] ??= [];
        }
        data[step.pointer] = _modifyMapByPath(
            path.removeAt(0),
            data[step.pointer],
            value) as dynamic;
      } else {
        try {
          data[path.steps[0].pointer] = value;
        } on RangeError {
          data.add(value);
        } on TypeError {
          if (data is List<Null>) {
            List<dynamic> array = [...data];
            array[path.steps[0].pointer] = value;
            return array;
          } else {
            rethrow;
          }
        }
      }
    }
    return data;
  }

  static dynamic getDataBypath(MapPath path, Map<String, dynamic> data) {
    dynamic selectedData = data;
    for (final step in path.steps) {
      selectedData = selectedData[step.pointer];
      if (selectedData == null) {
        return selectedData;
      }
    }
    return selectedData;
  }
}