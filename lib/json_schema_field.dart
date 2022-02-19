import 'package:flutter/material.dart';

import 'json_schema_leaf.dart';

class JSONSchemaUIField extends StatelessWidget {
  JSONSchemaUIField(
      {Key? key,
        this.schema = const {},
        this.ui = const {},
        this.path = const [],
      }): fields = schema['properties']?.keys?.toList() ?? [], super(key: key);

  final Map<String, dynamic> schema;
  final Map<String, dynamic> ui;
  final List<String> fields;
  final List<String> path;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListView.builder(
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              itemCount: fields.length,
              itemBuilder: (BuildContext context, int index) {
                String field = fields[index];
                List<String> newPath = [...path];
                newPath.add(field);
                return _buildJSONSchemaField(
                  schema: schema['properties']?[field] ?? {},
                  path: newPath,
                  context: context,);
              }),
        ]);
  }

  Widget _buildJSONSchemaField({
    required Map<String, dynamic> schema,
    required List<String> path,
    required BuildContext context,
  }) {
    if ((schema['type'] ?? 'not_defined') == 'object') {
      return JSONSchemaUIField(schema: schema, path: path);
    } else {
      return JSONSchemaFinalLeaf(schema: schema, path: path);
    }
  }
}