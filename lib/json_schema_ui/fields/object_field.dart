import 'package:flutter/material.dart';
import 'package:uniturnip/json_schema_ui/fields/json_schema_dependency.dart';
import 'package:uniturnip/json_schema_ui/models/mapPath.dart';

import '../utils.dart';
import '../widgets/array_buttons.dart';
import 'json_schema_leaf.dart';

class JSONSchemaUIField extends StatelessWidget {
  JSONSchemaUIField({
    Key? key,
    required this.schema,
    this.ui = const {},
    MapPath? path,
    dynamic pointer,
  })  : path = Utils.getPath(path, pointer, schema),
        super(key: key);

  final Map<String, dynamic> schema;
  final Map<String, dynamic> ui;
  final MapPath path;

  @override
  Widget build(BuildContext context) {
    List fields = Utils.retrieveSchemaFields(context: context, schema: schema, uiSchema: ui, path: path);
    String? title = schema['title'];
    String? description = schema['description'];

    if (fields.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (path.isLastObject() || path.isLastArray())
          ObjectHeader(title: title, description: description),
        // TODO: Find out if there are any difference between for loop and listview in terms of optimization
        for (String field in fields)
          ObjectBody(path: path, uiSchema: ui, schema: schema, field: field),
        if (path.isLastArray()) ArrayPanel(path),
      ],
    );
  }
}

class ObjectHeader extends StatelessWidget {
  final String? title;
  final String? description;

  const ObjectHeader({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) Text(title!, style: Theme.of(context).textTheme.headline6),
          if (description != null) Text(description!),
          const Divider(height: 10),
        ],
      ),
    );
  }
}

class ObjectBody extends StatelessWidget {
  final Map<String, dynamic> schema;
  final Map<String, dynamic> uiSchema;
  final MapPath path;
  final String field;

  const ObjectBody({
    Key? key,
    required this.schema,
    required this.uiSchema,
    required this.path,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> newSchema = schema['properties']?[field] ?? schema['items'] ?? {};
    Map<String, dynamic> newUiSchema = uiSchema[field] ?? uiSchema['items'] ?? {};
    String schemaType = newSchema['type'] ?? 'not_defined';
    if (schemaType == 'object' || schemaType == 'array') {
      if (newSchema['items'] != null && newSchema['items']['enum'] != null) {
        return JSONSchemaFinalLeaf(
          schema: newSchema['items'],
          ui: newUiSchema.containsKey('items') ? newUiSchema['items'] : newUiSchema,
          pointer: field,
          path: path,
        );
      } else {
        return JSONSchemaUIField(
          schema: newSchema,
          ui: newUiSchema,
          pointer: field,
          path: path,
        );
      }
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          JSONSchemaFinalLeaf(
            schema: newSchema,
            ui: newUiSchema,
            pointer: field,
            path: path,
          ),
          if (schema['dependencies']?[field] != null)
            JSONSchemaDependency(
              schema: schema['dependencies'][field],
              ui: uiSchema,
              path: path,
              pointer: field,
            ),
        ],
      );
    }
  }
}
