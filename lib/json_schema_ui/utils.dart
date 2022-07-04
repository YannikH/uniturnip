import 'package:flutter/material.dart';

import 'models/mapPath.dart';
import 'models/widget_data.dart';

class Utils {
  static _defaultWidgetType({required type}) {
    // Return default widget for fields types.
    switch (type) {
      case 'string':
        return 'text';
      case 'integer':
        return 'number';
      case 'number':
        return 'number';
      case 'boolean':
        return 'checkbox';
      case 'null':
        return 'null';
      default:
        return type;
    }
  }

  static getWidgetType(WidgetData widgetData) {
    // Return widget's type that fits schema or uiSchema conditions.
    // Conditions priority: [ui:widget] --> [format] --> [enum] --> [type].
    final uiSchema = widgetData.uiSchema;
    final schema = widgetData.schema;
    final String widgetType;
    final String type = schema['type'];

    if (uiSchema != null && uiSchema.containsKey('ui:widget')) {
      widgetType = uiSchema['ui:widget'];
    } else if (schema.containsKey('format')) {
      widgetType = schema['format'];
    } else if (schema.containsKey('enum') && (type != 'boolean' || type != 'null')) {
      widgetType = 'select';
    } else {
      widgetType = _defaultWidgetType(type: type);
    }
    return widgetType;
  }

  static Map<String, dynamic> modifyMapByPath(
      MapPath path, Map<String, dynamic> data, dynamic value) {
    data = {...data};
    data = _modifyMapByPath(path, data, value).cast<String, dynamic>();
    return data;
  }

  static dynamic _modifyMapByPath(MapPath path, dynamic data, dynamic value) {
    if (path.steps.isNotEmpty) {
      if (path.steps.length > 1) {
        PathStep step = path.steps[0];
        if (step.type == StepType.object) {
          data[step.pointer] ??= {}; //TODO Test replacing object with array
        } else if (step.type == StepType.array) {
          data[step.pointer] ??= [];
        }
        data[step.pointer] =
            _modifyMapByPath(path.removeAt(0), data[step.pointer], value) as dynamic;
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
      try {
        selectedData = selectedData[step.pointer];
      } on RangeError {
        return null;
      }
      if (selectedData == null) {
        return selectedData;
      }
    }
    return selectedData;
  }

  /// Return path if exist, else create new path.
  static MapPath getPath(MapPath? path, pointer, schema) {
    if (path == null) {
      return MapPath();
    }
    if (pointer == null) {
      return path;
    }
    print(schema);
    return path.add(schema['type'], pointer);
  }

  /// Sort [fields] by [order] list.
  static List _sortFields(List fields, List order) {
    List orderList = <dynamic>{...order, ...fields}.toList();
    Map<String, dynamic> fieldsMap = {for (var key in fields) key: orderList.indexOf(key)};
    List orderFiltered = order.where((prop) => prop == "*" || fieldsMap.containsKey(prop)).toList();
    Map<String, dynamic> orderMap = {for (var key in orderFiltered) key: orderList.indexOf(key)};
    List rest = fields.where((prop) => !orderMap.containsKey(prop)).toList();
    List complete = [...orderFiltered];
    int restIndex = complete.indexOf('*');
    if (restIndex < 0) {
      return complete;
    }
    complete.insertAll(restIndex, rest);
    complete.remove('*');
    // TODO: Add wildcard verification

    return complete;
  }

  /// Return keys from schema [Schema]<Map>.
  static List retrieveSchemaFields({
    required Map<String, dynamic> schema,
    required Map<String, dynamic> uiSchema,
    required BuildContext context,
    required MapPath path,
  }) {
    List fields = [];

    if (schema['properties'] != null) {
      fields = schema['properties'].keys.toList();

      if (uiSchema.containsKey('ui:order')) {
        List order = uiSchema['ui:order'] ?? [];
        fields = _sortFields(fields, order);
      }
    }
    // else if (schema['items'] != null) {
    //   final int length = context.select((UIModel uiModel) => uiModel.getDataByPath(path)?.length ?? 1);
    //   fields = Iterable<int>.generate(length).toList();
    // }
    return fields;
  }
}
