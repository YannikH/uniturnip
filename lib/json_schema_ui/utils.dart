import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fields/json_schema_dependency.dart';
import 'fields/json_schema_field.dart';
import 'fields/json_schema_leaf.dart';
import 'models/mapPath.dart';
import 'models/ui_model.dart';
import 'models/widget_data.dart';
import 'widgets.dart';

class Utils {
  static Widget _formWidget({required String widget, required WidgetData widgetData}) {
    switch (widget) {
      case 'audio':
        return AudioWidget(widgetData: widgetData);
      case 'checkbox':
        return CheckboxWidget(widgetData: widgetData);
      case 'checkboxes':
        return CheckboxesWidget(widgetData: widgetData);
      case 'radio':
        return RadioWidget(widgetData: widgetData);
      case 'select':
        return SelectWidget(widgetData: widgetData);
// case 'hidden':
//   return HiddenWidget(widgetData: widgetData);
      case 'text':
        return TextWidget(widgetData: widgetData);
      case 'password':
        return PasswordWidget(widgetData: widgetData);
      case 'email':
        return EmailWidget(widgetData: widgetData);
// case 'uri':
//   return URLWidget(widgetData: widgetData);
      case 'data-url':
        return FileWidget(widgetData: widgetData);
      case 'textarea':
        return TextareaWidget(widgetData: widgetData);
      case 'date':
        return DateWidget(widgetData: widgetData);
      case 'datetime':
        return DateTimeWidget(widgetData: widgetData);
      case 'date-time':
        return DateTimeWidget(widgetData: widgetData);
// case 'color':
//   return ColorWidget(widgetData: widgetData);
      case 'file':
        return FileWidget(widgetData: widgetData);
      case 'number':
        return NumberWidget(widgetData: widgetData);
// case 'range':
//   return RangeWidget(widgetData: widgetData);
      case 'files':
        return FileWidget(widgetData: widgetData);
      case 'null':
        return NullWidget(widgetData: widgetData);
      case 'reader':
        return ReaderWidget(widgetData: widgetData);
      // case 'card':
        // return CardWidget(widgetData: widgetData);
      default:
        return TextWidget(widgetData: widgetData);
    }
  }

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

  static formWidget(WidgetData widgetData) {
    // Return widget that fits schema or uiSchema conditions.
    // Conditions priority: [ui:widget] --> [format] --> [enum] --> [type].
    final uiSchema = widgetData.uiSchema;
    final schema = widgetData.schema;
    final String widget;
    final String type = schema['type'];

    if (uiSchema != null && uiSchema.containsKey('ui:widget')) {
      widget = uiSchema['ui:widget'];
    } else if (schema.containsKey('format')) {
      widget = schema['format'];
    } else if (schema.containsKey('enum') && (type != 'boolean' || type != 'null')) {
      widget = 'select';
    } else {
      widget = _defaultWidgetType(type: type);
    }
    print("$schema Widget: $widget");
    return _formWidget(widget: widget, widgetData: widgetData);
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
    return path.add(schema['type'], pointer);
  }

  /// Sort [fields] by [order] list.
  static List _sortFields(List fields, List order) {
    List orderList = <dynamic>{...order, ...fields}.toList();
    Map<String, dynamic> fieldsMap = {for (var key in fields) key: orderList.indexOf(key)};
    List orderFiltered = order.where(
            (prop) => prop == "*" || fieldsMap.containsKey(prop)
    ).toList();
    Map<String, dynamic> orderMap = {for (var key in orderFiltered) key: orderList.indexOf(key)};
    List rest = fields.where((prop) => !orderMap.containsKey(prop)).toList();
    List complete = [...orderFiltered];
    int restIndex = complete.indexOf('*');
    if(restIndex < 0){
      return complete;
    }
    complete.insertAll(restIndex, rest);
    complete.remove('*');
    // TODO: Add wildcard verification

    return complete;
  }

  /// Return dependency if it exists in [schema].
  static Widget _dependency({
    required Map<String, dynamic> schema,
    required Map<String, dynamic> ui,
    required MapPath path,
    required field,
  }) {
    if (field != null && schema['dependencies']?[field] != null) {
      return JSONSchemaDependency(
          schema: schema['dependencies']?[field], ui: ui, path: path, pointer: field);
    } else {
      return const SizedBox.shrink();
    }
  }

  /// Return keys from schema [Schema]<Map>.
  static List retrieveSchemaFields({
    required Map<String, dynamic> schema,
    required Map<String, dynamic> ui,
    required BuildContext context,
    required MapPath path,
  }) {
    List fields = [];
    int length;

    if (schema['properties'] != null) {
      fields = schema['properties'].keys.toList();

      if (ui['ui:widget'] == "card" && ui.containsKey('ui:order')) { ///---
        List list = [];
        List order = ui['ui:order'] ?? [];
        fields = _sortFields(fields, order);
        int counter = context.watch<UIModel>().counter;
        list.add(fields[counter]);
        for (var element in list) {
          fields.clear();
          fields.add(element);  ///^^^
        }
      } else if (ui.containsKey('ui:order')) {
        List order = ui['ui:order'] ?? [];
        fields = _sortFields(fields, order);
      }

  } else if (schema['items'] != null) {
      // if (schema['items']['enum'] != null) {
      //   fields = [];
      // } else {
      //   length = context.select((UIModel uiModel) => uiModel.getDataByPath(path)?.length ?? 1);
      //   fields = Iterable<int>.generate(length).toList();
      // }
      length = context.select((UIModel uiModel) => uiModel.getDataByPath(path)?.length ?? 1);
      fields = Iterable<int>.generate(length).toList();
    }
    return fields;
  }

  static Widget getFieldLeaf({
    required Map<String, dynamic> schema,
    required Map<String, dynamic> ui,
    required MapPath path,
    required field,
  }) {
    Map<String, dynamic> newSchema = schema['properties']?[field] ?? schema['items'] ?? {};
    Map<String, dynamic> newUiSchema = ui[field] ?? ui['items'] ?? {};
    String schemaType = newSchema['type'] ?? 'not_defined';
    if (schemaType == 'array' || ui['ui:widget'] == "reader") {  ///
      return JSONSchemaFinalLeaf(
        schema: newSchema,
        ui: newUiSchema,
        pointer: field,
        path: path,
      );
    } else if (schemaType == 'object' || schemaType == 'array') {
      if (newSchema['items'] != null && newSchema['items']['enum'] != null) {
        return JSONSchemaFinalLeaf(
          schema: newSchema['items'],
          ui: newUiSchema['items'],
          pointer: field,
          path: path,
        );
        // List _items = newSchema['items']['enum'];
        // for (int i = 0; i < _items.length; i++) {
        //   path.add('array', i);
        // }
        // String _type = newSchema['items']['type'];
        //   Map<String, dynamic> _schema = {
        //     'title': newSchema['title'],
        //     'type': 'object',
        //     'properties': {
        //
        //     }
        //   };
        //   Map<String, dynamic> _ui = {};
        //   for (String _item in _items) {
        //     _schema['properties'][_item] = {
        //       'title': _item,
        //       'type': _type,
        //     };
        //     _ui[_item] = newUiSchema['items'];
        //   }
        //   return JSONSchemaUIField(
        //     schema: _schema,
        //     ui: _ui,
        //     pointer: field,
        //     path: path,
        //   );
      }
      return JSONSchemaUIField(
        schema: newSchema,
        ui: newUiSchema,
        pointer: field,
        path: path,
      );
    } else {
      return Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        JSONSchemaFinalLeaf(
          schema: newSchema,
          ui: newUiSchema,
          pointer: field,
          path: path,
        ),
        _dependency(path: path, ui: ui, schema: schema, field: field)
      ]);
    }
  }
}
