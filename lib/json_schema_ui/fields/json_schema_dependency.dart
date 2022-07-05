import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/mapPath.dart';
import '../models/ui_model.dart';
import 'object_field.dart';

class JSONSchemaDependency extends StatelessWidget {
  JSONSchemaDependency({
    Key? key,
    required this.schema,
    required MapPath path,
    required this.pointer,
    this.ui = const {},
  })  : path = path.add('leaf', pointer),
        super(key: key);

  final dynamic pointer;
  final MapPath path;
  final Map<String, dynamic> schema;
  final Map<String, dynamic> ui;

  @override
  Widget build(BuildContext context) {
    return Consumer<UIModel>(builder: (context, uiModel, _) {
      final data = uiModel.getDataByPath(path);
      List oneOf = schema['oneOf'] ?? [];
      for (Map<String, dynamic> dependency in oneOf) {
        List options = dependency['properties']?[pointer]?['enum'] ?? [];
        if (options.contains(data)) {
          Map<String, dynamic> newSchema = {...dependency};
          Map<String, dynamic> newSchemaProperties = {...dependency['properties']};
          newSchemaProperties.remove(pointer);
          newSchema['properties'] = newSchemaProperties;
          newSchema['type'] = 'object';
          MapPath newPath = path.removeLast();
          String field = newSchemaProperties.keys.first;
          Map<String, dynamic> newUiSchema = ui.containsKey(field) ? {field: ui[field]} : {};
          return JSONSchemaUIField(schema: newSchema, ui: newUiSchema, path: newPath);
        }
      }
      return const SizedBox.shrink();
    });
  }
}
