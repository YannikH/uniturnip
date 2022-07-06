import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniturnip/json_schema_ui/fields/object_field.dart';
import 'package:uniturnip/json_schema_ui/models/mapPath.dart';
import 'package:uniturnip/json_schema_ui/models/ui_model.dart';

class JSONSchemaDependency extends StatelessWidget {
  final dynamic pointer;
  final MapPath path;
  final Map<String, dynamic> schema;
  final Map<String, dynamic> uiSchema;

  JSONSchemaDependency({
    Key? key,
    required this.schema,
    required MapPath path,
    required this.pointer,
    this.uiSchema = const {},
  })  : path = path.add('leaf', pointer),
        super(key: key);

  Map<String, dynamic> _createSchema(
    Map<String, dynamic> schema,
    Map<String, dynamic> properties,
  ) {
    Map<String, dynamic> newSchema = {...schema};
    Map<String, dynamic> newSchemaProperties = properties;
    newSchemaProperties.remove(pointer);
    newSchema['properties'] = newSchemaProperties;
    newSchema['type'] = 'object';
    return newSchema;
  }

  Map<String, dynamic> _createUiSchema(
    Map<String, dynamic> uiSchema,
    Map<String, dynamic> properties,
  ) {
    String field = properties.keys.first;
    if (uiSchema.containsKey(field)) {
      return {field: uiSchema[field]};
    } else {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UIModel>(builder: (context, uiModel, _) {
      final data = uiModel.getDataByPath(path);
      List oneOf = schema['oneOf'] ?? [];
      // Iterate over dependencies until find desired option's dependency.
      for (var dependency in oneOf) {
        // Check if dependency has available options in enum.
        List options = dependency['properties']?[pointer]?['enum'] ?? [];
        if (options.contains(data)) {
          Map<String, dynamic> properties = {...dependency['properties']};
          final newSchema = _createSchema(dependency, properties);
          final newUiSchema = _createUiSchema(uiSchema, properties);
          var newPath = path.removeLast();
          return JSONSchemaUIField(schema: newSchema, ui: newUiSchema, path: newPath);
        }
      }
      // If desired dependency is not found return empty widget.
      return const SizedBox.shrink();
    });
  }
}
